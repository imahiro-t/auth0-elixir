defmodule Auth0.Common.HttpOptionsTest do
  # Timing-sensitive (timeouts and pool isolation): not async.
  use ExUnit.Case, async: false

  alias Auth0.Authentication.Token.ClientCredentials
  alias Auth0.Authentication.Token.ClientCredentials.Params
  alias Auth0.Common.HttpOptions
  alias Auth0.Common.Management.Http
  alias Auth0.Config

  # A TCP server that accepts connections (and keeps them open) but never sends a byte.
  defmodule SilentServer do
    @moduledoc false

    def start() do
      {:ok, listen} =
        :gen_tcp.listen(0, [:binary, active: false, reuseaddr: true, ip: {127, 0, 0, 1}])

      {:ok, port} = :inet.port(listen)
      pid = spawn_link(fn -> accept_loop(listen, []) end)
      :ok = :gen_tcp.controlling_process(listen, pid)
      {port, pid}
    end

    defp accept_loop(listen, held) do
      case :gen_tcp.accept(listen) do
        # Keep a reference so the socket stays open; never read or reply.
        {:ok, socket} -> accept_loop(listen, [socket | held])
        {:error, _} -> :ok
      end
    end
  end

  # A TCP port on which new connections cannot be established in time: a listen socket with
  # a minimal backlog that is never accepted from, whose accept queue is filled up first. The
  # kernel then drops further SYNs, so a connect to it hangs until the client's timeout.
  defmodule SlowConnectServer do
    @moduledoc false

    def start() do
      owner = self()

      pid =
        spawn_link(fn ->
          {:ok, listen} =
            :gen_tcp.listen(0, [:binary, active: false, backlog: 0, ip: {127, 0, 0, 1}])

          {:ok, port} = :inet.port(listen)
          result = fill(port, 20, [])
          send(owner, {:slow_connect_server, self(), port, result})
          Process.sleep(:infinity)
        end)

      receive do
        {:slow_connect_server, ^pid, port, :ok} -> {:ok, port}
        {:slow_connect_server, ^pid, _port, :error} -> :error
      after
        10_000 -> :error
      end
    end

    defp fill(_port, 0, _held), do: :error

    defp fill(port, attempts, held) do
      case :gen_tcp.connect({127, 0, 0, 1}, port, [:binary, active: false], 300) do
        {:ok, socket} -> fill(port, attempts - 1, [socket | held])
        # The accept queue is full: the held sockets stay open (this process sleeps).
        {:error, :timeout} -> :ok
        {:error, _} -> :error
      end
    end
  end

  defp elapsed_ms(fun) do
    {us, result} = :timer.tc(fun)
    {div(us, 1000), result}
  end

  describe "build/1" do
    test "passes the default timeouts and a per-domain pool" do
      config = %Config{domain: "tenant-a.example.com"}

      assert HttpOptions.build(config) == [
               recv_timeout: 5_000,
               timeout: 8_000,
               hackney: [pool: {:auth0_api, "tenant-a.example.com"}]
             ]
    end

    test "uses the timeouts set in Config" do
      config = %Config{domain: "tenant-a.example.com", recv_timeout: 1_234, connect_timeout: 567}

      assert [recv_timeout: 1_234, timeout: 567, hackney: _] = HttpOptions.build(config)
    end

    test "different domains get different pools" do
      refute HttpOptions.pool_name(%Config{domain: "a.example.com"}) ==
               HttpOptions.pool_name(%Config{domain: "b.example.com"})
    end
  end

  describe "a server that accepts but never responds" do
    setup do
      {port, _pid} = SilentServer.start()

      config = %Config{
        domain: "127.0.0.1:#{port}",
        http_protocol: "http",
        api_token: "test-token"
      }

      {:ok, config: config}
    end

    test "Management GET times out with the default recv_timeout (5 s)", %{config: config} do
      {ms, result} = elapsed_ms(fn -> Http.get("/test", config) end)

      assert result == {:error, :timeout}
      assert ms >= 4_500 and ms < 8_000, "returned after #{ms} ms"
    end

    test "every Management request function honours Config recv_timeout", %{config: config} do
      config = %Config{config | recv_timeout: 300}

      requests = [
        fn -> Http.get("/test", config) end,
        fn -> Http.post("/test", %{a: 1}, config) end,
        fn -> Http.patch("/test", %{a: 1}, config) end,
        fn -> Http.put("/test", %{a: 1}, config) end,
        fn -> Http.delete("/test", config) end,
        fn -> Http.delete("/test", %{a: 1}, config) end,
        fn -> Http.multipart_post("/test", {:multipart, [{"a", "b"}]}, config) end
      ]

      for request <- requests do
        {ms, result} = elapsed_ms(request)
        assert result == {:error, :timeout}
        assert ms < 2_000, "returned after #{ms} ms"
      end

      {ms, result} = elapsed_ms(fn -> Http.raw_request(:get, "/test", %{}, nil, config) end)
      assert {:error, %HTTPoison.Error{reason: :timeout}} = result
      assert ms < 2_000, "returned after #{ms} ms"
    end

    test "the client credentials token request honours Config recv_timeout", %{config: config} do
      config = %Config{config | api_token: nil, recv_timeout: 300}
      params = %Params{audience: "aud", client_id: "cid", client_secret: "secret"}

      {ms, result} = elapsed_ms(fn -> ClientCredentials.execute(params, config) end)

      assert result == {:error, :timeout}
      assert ms < 2_000, "returned after #{ms} ms"
    end

    test "a Management request that needs a token (token cache path) returns in bounded time",
         %{config: config} do
      config = %Config{
        config
        | api_token: nil,
          client_id: "cid",
          client_secret: "secret",
          recv_timeout: 300
      }

      # Token request times out (no token), then the API request itself times out.
      {ms, result} = elapsed_ms(fn -> Http.get("/test", config) end)

      assert result == {:error, :timeout}
      assert ms < 3_000, "returned after #{ms} ms"
    end
  end

  describe "a host whose connections cannot be established" do
    setup do
      case SlowConnectServer.start() do
        {:ok, slow_port} ->
          bypass = Bypass.open()

          Bypass.stub(bypass, "GET", "/healthy", fn conn ->
            Plug.Conn.resp(conn, 200, "ok")
          end)

          slow_config = %Config{
            domain: "127.0.0.1:#{slow_port}",
            http_protocol: "http",
            api_token: "test-token",
            connect_timeout: 3_000
          }

          healthy_config = %Config{
            domain: "localhost:#{bypass.port}",
            http_protocol: "http",
            api_token: "test-token"
          }

          {:ok,
           slow_port: slow_port,
           slow_config: slow_config,
           healthy_config: healthy_config,
           bypass: bypass}

        :error ->
          flunk("could not set up a TCP port whose connects hang (accept queue never filled)")
      end
    end

    test "fails with a connect error within Config connect_timeout", %{slow_config: config} do
      config = %Config{config | connect_timeout: 500}

      {ms, result} = elapsed_ms(fn -> Http.get("/test", config) end)

      assert {:error, reason} = result
      assert reason in [:connect_timeout, :checkout_timeout, :timeout]
      assert ms < 2_000, "returned after #{ms} ms"
    end

    test "does not delay a library request to another Auth0 domain",
         %{slow_config: slow_config, healthy_config: healthy_config} do
      slow = Task.async(fn -> elapsed_ms(fn -> Http.get("/test", slow_config) end) end)
      # Let the slow request start connecting inside its pool first.
      Process.sleep(300)

      {ms, result} = elapsed_ms(fn -> Http.get("/healthy", healthy_config) end)

      assert result == {:ok, 200, "ok"}
      assert ms < 1_000, "healthy request took #{ms} ms"

      {slow_ms, slow_result} = Task.await(slow, 10_000)
      assert {:error, _} = slow_result
      assert slow_ms < 5_000, "slow request returned after #{slow_ms} ms"
    end

    test "a slow connect in hackney's default pool does not delay library requests",
         %{slow_port: slow_port, healthy_config: healthy_config} do
      # Another hackney user of the host application (default pool, no options).
      other =
        Task.async(fn -> HTTPoison.get("http://127.0.0.1:#{slow_port}/", [], timeout: 3_000) end)

      Process.sleep(300)

      {ms, result} = elapsed_ms(fn -> Http.get("/healthy", healthy_config) end)

      assert result == {:ok, 200, "ok"}
      assert ms < 1_000, "library request took #{ms} ms"

      assert {:error, %HTTPoison.Error{}} = Task.await(other, 10_000)
    end

    test "a slow connect from the library does not delay hackney's default pool",
         %{slow_config: slow_config, bypass: bypass} do
      slow = Task.async(fn -> Http.get("/test", slow_config) end)
      Process.sleep(300)

      {ms, result} =
        elapsed_ms(fn -> HTTPoison.get("http://localhost:#{bypass.port}/healthy") end)

      assert {:ok, %HTTPoison.Response{status_code: 200}} = result
      assert ms < 1_000, "default-pool request took #{ms} ms"

      assert {:error, _} = Task.await(slow, 10_000)
    end
  end
end
