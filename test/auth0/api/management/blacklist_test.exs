defmodule Auth0.Api.Management.BlacklistTest do
  use ExUnit.Case
  alias Auth0.Api.Management
  alias Auth0.Config

  setup do
    bypass = Bypass.open()
    {:ok, bypass: bypass}
  end

  defp config(bypass) do
    %Config{
      domain: "localhost:#{bypass.port}",
      http_protocol: "http",
      api_token: "test-token"
    }
  end

  describe "get_blacklisted_tokens (D-006 deprecated, behaviour unchanged)" do
    test "still works as before", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        assert conn.method == "GET"
        assert conn.request_path == "/api/v2/blacklists/tokens"
        Plug.Conn.resp(conn, 200, "[]")
      end)

      assert {:ok, []} = Management.get_blacklisted_tokens(%{"aud" => "a"}, config(bypass))
    end

    test "returns an error tuple on 4xx", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn -> Plug.Conn.resp(conn, 404, "{}") end)
      assert {:error, 404, _} = Management.get_blacklisted_tokens(%{"aud" => "a"}, config(bypass))
    end
  end

  describe "blacklist_token (D-007 deprecated, behaviour unchanged)" do
    test "still works as before", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        assert conn.method == "POST"
        assert conn.request_path == "/api/v2/blacklists/tokens"
        {:ok, raw, conn} = Plug.Conn.read_body(conn)
        assert Jason.decode!(raw) == %{"jti" => "j"}
        Plug.Conn.resp(conn, 204, "")
      end)

      assert {:ok, ""} = Management.blacklist_token(%{"jti" => "j"}, config(bypass))
    end

    test "returns an error tuple on 4xx", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn -> Plug.Conn.resp(conn, 404, "{}") end)
      assert {:error, 404, _} = Management.blacklist_token(%{"jti" => "j"}, config(bypass))
    end
  end
end
