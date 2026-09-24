defmodule Auth0.Common.Management.TokenManagerTest do
  # The token cache (ETS) and the application state are VM global.
  use ExUnit.Case, async: false

  alias Auth0.Config
  alias Auth0.Common.Management.TokenManager
  alias Auth0.Common.Management.TokenManager.Store

  @client_id "shared-client-id"

  setup do
    :ok = Store.clear()
    :ok
  end

  defp config(bypass, overrides \\ []) do
    struct!(
      %Config{
        domain: "localhost:#{bypass.port}",
        http_protocol: "http",
        client_id: @client_id,
        client_secret: "super-secret-value"
      },
      overrides
    )
  end

  defp token_response(conn, access_token, expires_in \\ 3600) do
    conn
    |> Plug.Conn.put_resp_content_type("application/json")
    |> Plug.Conn.resp(
      200,
      Jason.encode!(%{
        access_token: access_token,
        expires_in: expires_in,
        token_type: "Bearer"
      })
    )
  end

  defp counting_token_endpoint(bypass, access_token, expires_in \\ 3600) do
    {:ok, counter} = Agent.start_link(fn -> 0 end)

    Bypass.expect(bypass, "POST", "/oauth/token", fn conn ->
      Agent.update(counter, &(&1 + 1))
      token_response(conn, access_token, expires_in)
    end)

    counter
  end

  describe "tenant isolation" do
    test "same client_id on different domains never shares a token" do
      bypass_a = Bypass.open()
      bypass_b = Bypass.open()

      Bypass.expect_once(bypass_a, "POST", "/oauth/token", fn conn ->
        {:ok, body, conn} = Plug.Conn.read_body(conn)
        assert URI.decode_query(body)["client_id"] == @client_id
        token_response(conn, "token-for-tenant-a")
      end)

      Bypass.expect_once(bypass_b, "POST", "/oauth/token", fn conn ->
        token_response(conn, "token-for-tenant-b")
      end)

      assert TokenManager.get_token(config(bypass_a)) == "token-for-tenant-a"
      assert TokenManager.get_token(config(bypass_b)) == "token-for-tenant-b"
      # served from the cache: expect_once fails if tenant A's endpoint is hit again
      assert TokenManager.get_token(config(bypass_a)) == "token-for-tenant-a"
    end

    test "a cached token is not served to a config with a different client_secret" do
      bypass = Bypass.open()
      {:ok, secrets} = Agent.start_link(fn -> [] end)

      Bypass.expect(bypass, "POST", "/oauth/token", fn conn ->
        {:ok, body, conn} = Plug.Conn.read_body(conn)
        secret = URI.decode_query(body)["client_secret"]
        Agent.update(secrets, &[secret | &1])
        token_response(conn, "token-for-" <> secret)
      end)

      assert TokenManager.get_token(config(bypass)) == "token-for-super-secret-value"

      # same domain and client_id (neither is secret) but a wrong client_secret:
      # the legitimate caller's cached token must not be returned
      refute TokenManager.get_token(config(bypass, client_secret: "guessed-secret")) ==
               "token-for-super-secret-value"

      # the legitimate config is still served from its own cache entry
      assert TokenManager.get_token(config(bypass)) == "token-for-super-secret-value"

      assert Agent.get(secrets, &Enum.reverse/1) == ["super-secret-value", "guessed-secret"]
    end
  end

  describe "ETS ownership" do
    test "cache survives the exit of the process that first used it" do
      bypass = Bypass.open()

      Bypass.expect_once(bypass, "POST", "/oauth/token", fn conn ->
        token_response(conn, "cached-token")
      end)

      task = Task.async(fn -> TokenManager.get_token(config(bypass)) end)
      assert Task.await(task) == "cached-token"
      refute Process.alive?(task.pid)

      assert :ets.whereis(:tokens_registry) != :undefined
      assert :ets.info(:tokens_registry, :owner) == Process.whereis(Store)

      # read from another process without hitting the endpoint again
      assert TokenManager.get_token(config(bypass)) == "cached-token"
    end

    test "table is protected: other processes cannot write to it directly" do
      assert :ets.info(:tokens_registry, :protection) == :protected

      assert_raise ArgumentError, fn ->
        :ets.insert(:tokens_registry, {{"evil.example", @client_id, nil}, {"forged", 0}})
      end
    end
  end

  describe "clear_token_cache / expiration" do
    test "clear_token_cache: true fetches a new token" do
      bypass = Bypass.open()
      counter = counting_token_endpoint(bypass, "token")

      assert TokenManager.get_token(config(bypass)) == "token"
      assert TokenManager.get_token(config(bypass, clear_token_cache: true)) == "token"
      assert Agent.get(counter, & &1) == 2
    end

    test "a token with expires_in: 0 is fetched again every time" do
      bypass = Bypass.open()
      counter = counting_token_endpoint(bypass, "short-lived", 0)

      assert TokenManager.get_token(config(bypass)) == "short-lived"
      assert TokenManager.get_token(config(bypass)) == "short-lived"
      assert Agent.get(counter, & &1) == 2
    end

    test "a token with expires_in: 3600 is served from the cache" do
      bypass = Bypass.open()
      counter = counting_token_endpoint(bypass, "long-lived", 3600)

      assert TokenManager.get_token(config(bypass)) == "long-lived"
      assert TokenManager.get_token(config(bypass)) == "long-lived"
      assert Agent.get(counter, & &1) == 1
    end

    test "a token is stored with an early expiration of expires_in minus the margin" do
      bypass = Bypass.open()
      _counter = counting_token_endpoint(bypass, "long-lived", 3600)

      before = System.system_time(:second)
      assert TokenManager.get_token(config(bypass)) == "long-lived"
      later = System.system_time(:second)

      assert [{_key, {"long-lived", expiration}}] = :ets.tab2list(:tokens_registry)
      # margin = min(30, div(3600, 2)) = 30
      assert expiration in (before + 3600 - 30)..(later + 3600 - 30)
    end

    test "a cached token inside the early-refresh margin is fetched again" do
      bypass = Bypass.open()
      counter = counting_token_endpoint(bypass, "fresh-token", 3600)
      config = config(bypass)
      now = System.system_time(:second)

      key =
        {config.domain, config.client_id, :crypto.hash(:sha256, config.client_secret)}

      # early expiration reached (the real token would still be valid for up to 30s more)
      :ok = Store.put(key, {"stale-token", now})
      assert TokenManager.get_token(config) == "fresh-token"
      assert Agent.get(counter, & &1) == 1

      # an entry whose early expiration is still in the future is served from the cache
      :ok = Store.put(key, {"cached-token", now + 60})
      assert TokenManager.get_token(config) == "cached-token"
      assert Agent.get(counter, & &1) == 1
    end

    test "the client_secret is not stored in the cache" do
      bypass = Bypass.open()
      _counter = counting_token_endpoint(bypass, "long-lived", 3600)

      assert TokenManager.get_token(config(bypass)) == "long-lived"

      entries = :ets.tab2list(:tokens_registry)

      refute entries |> inspect(limit: :infinity) =~ "super-secret-value"
      assert :binary.match(:erlang.term_to_binary(entries), "super-secret-value") == :nomatch

      # the key carries only the SHA-256 digest of the secret
      assert [{{_domain, @client_id, digest}, _value}] = entries
      assert digest == :crypto.hash(:sha256, "super-secret-value")
    end
  end

  describe "fallback without the application" do
    # Application.stop/1 logs "[notice] Application auth0_api exited: :stopped"
    @tag :capture_log
    test "works without cache when the application is not running" do
      on_exit(fn -> {:ok, _} = Application.ensure_all_started(:auth0_api) end)

      :ok = Application.stop(:auth0_api)

      assert Process.whereis(Store) == nil
      assert :ets.whereis(:tokens_registry) == :undefined

      bypass = Bypass.open()
      counter = counting_token_endpoint(bypass, "uncached-token", 3600)

      assert TokenManager.get_token(config(bypass)) == "uncached-token"
      assert TokenManager.get_token(config(bypass)) == "uncached-token"
      assert TokenManager.get_token(config(bypass, clear_token_cache: true)) == "uncached-token"
      assert Agent.get(counter, & &1) == 3
    end
  end
end
