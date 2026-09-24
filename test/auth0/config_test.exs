defmodule Auth0.ConfigTest do
  # persistent_term state used for the http warning is VM global.
  use ExUnit.Case, async: false

  import ExUnit.CaptureLog

  alias Auth0.Config

  @warning "credentials are sent in plain text"

  defp unique_domain(), do: "example-#{System.unique_integer([:positive])}.test"

  defp count_warnings(log) do
    log |> String.split(@warning) |> length() |> Kernel.-(1)
  end

  describe "inspect/1" do
    test "does not expose api_token or client_secret" do
      config = %Config{
        domain: "tenant.auth0.com",
        api_token: "super-secret-api-token",
        client_id: "my-client-id",
        client_secret: "super-secret-client-secret"
      }

      inspected = inspect(config)

      refute inspected =~ "super-secret-api-token"
      refute inspected =~ "super-secret-client-secret"
      assert inspected =~ "tenant.auth0.com"
      assert inspected =~ "my-client-id"
    end

    test "masked fields are still accessible" do
      config = %Config{api_token: "super-secret-api-token", client_secret: "s"}

      assert Config.get_api_token(config) == "super-secret-api-token"
      assert Config.get_client_secret(config) == "s"
    end
  end

  describe "get_http_protocol/1" do
    test "returns https by default, for nil and for \"https\"" do
      assert Config.get_http_protocol(%Config{}) == "https"
      assert Config.get_http_protocol(%Config{http_protocol: nil}) == "https"
      assert Config.get_http_protocol(%Config{http_protocol: "https"}) == "https"
    end

    test "returns http for \"http\"" do
      assert Config.get_http_protocol(%Config{domain: "localhost:4000", http_protocol: "http"}) ==
               "http"
    end

    test "raises ArgumentError for invalid values" do
      for value <- ["ftp", "HTTPS", "", :https] do
        assert_raise ArgumentError, fn ->
          Config.get_http_protocol(%Config{domain: "localhost", http_protocol: value})
        end
      end
    end

    test "warns exactly once per non-loopback domain" do
      domain = unique_domain()
      config = %Config{domain: domain, http_protocol: "http", client_secret: "super-secret"}

      log =
        capture_log([level: :warning], fn ->
          assert Config.get_http_protocol(config) == "http"
          assert Config.get_http_protocol(config) == "http"
        end)

      assert count_warnings(log) == 1
      assert log =~ domain
      refute log =~ "super-secret"
    end

    test "warns again for a different domain" do
      domain_a = unique_domain()
      domain_b = unique_domain()

      log_a =
        capture_log([level: :warning], fn ->
          Config.get_http_protocol(%Config{domain: domain_a, http_protocol: "http"})
        end)

      log_b =
        capture_log([level: :warning], fn ->
          Config.get_http_protocol(%Config{domain: domain_b, http_protocol: "http"})
          Config.get_http_protocol(%Config{domain: domain_a, http_protocol: "http"})
        end)

      assert count_warnings(log_a) == 1
      assert count_warnings(log_b) == 1
      assert log_b =~ domain_b
    end

    test "does not warn for loopback domains" do
      for domain <- ["localhost:4000", "127.0.0.1:4000", "[::1]:4000", "LOCALHOST", "127.1.2.3"] do
        log =
          capture_log([level: :warning], fn ->
            assert Config.get_http_protocol(%Config{domain: domain, http_protocol: "http"}) ==
                     "http"
          end)

        assert count_warnings(log) == 0, "unexpected warning for #{domain}"
      end
    end

    test "does not warn for https" do
      log =
        capture_log([level: :warning], fn ->
          Config.get_http_protocol(%Config{domain: unique_domain(), http_protocol: "https"})
        end)

      assert count_warnings(log) == 0
    end
  end

  describe "get_recv_timeout/1 and get_connect_timeout/1" do
    test "default to 5000 and 8000 ms" do
      assert Config.get_recv_timeout(%Config{}) == 5_000
      assert Config.get_connect_timeout(%Config{}) == 8_000
      assert Config.get_recv_timeout(%Config{recv_timeout: nil}) == 5_000
      assert Config.get_connect_timeout(%Config{connect_timeout: nil}) == 8_000
    end

    test "return the configured positive integers" do
      assert Config.get_recv_timeout(%Config{recv_timeout: 15_000}) == 15_000
      assert Config.get_connect_timeout(%Config{connect_timeout: 1}) == 1
    end

    test "raise ArgumentError for invalid values" do
      for value <- [0, -1, 1.5, "5000", :infinity] do
        assert_raise ArgumentError, ~r/invalid :recv_timeout/, fn ->
          Config.get_recv_timeout(%Config{recv_timeout: value})
        end

        assert_raise ArgumentError, ~r/invalid :connect_timeout/, fn ->
          Config.get_connect_timeout(%Config{connect_timeout: value})
        end
      end
    end
  end
end
