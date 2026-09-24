defmodule Auth0.Api.Management.SessionsTest do
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

  describe "update_session (A-005)" do
    test "sends PATCH /api/v2/sessions/ses_1", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        assert conn.method == "PATCH"
        assert conn.request_path == "/api/v2/sessions/ses_1"
        {:ok, raw, conn} = Plug.Conn.read_body(conn)
        assert Jason.decode!(raw) == %{"session_metadata" => %{"k" => "v"}}
        Plug.Conn.resp(conn, 200, "{\"id\":\"x\"}")
      end)

      assert {:ok, %{"id" => "x"}} =
               Management.update_session(
                 "ses_1",
                 %{"session_metadata" => %{"k" => "v"}},
                 config(bypass)
               )
    end

    test "returns an error tuple on 4xx", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn -> Plug.Conn.resp(conn, 400, "{}") end)

      assert {:error, 400, _} =
               Management.update_session(
                 "ses_1",
                 %{"session_metadata" => %{"k" => "v"}},
                 config(bypass)
               )
    end
  end

  describe "revoke_session (C-003)" do
    test "revokes with POST and returns an empty string on 202", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        assert conn.method == "POST"
        assert conn.request_path == "/api/v2/sessions/ses_1/revoke"
        Plug.Conn.resp(conn, 202, "")
      end)

      assert {:ok, ""} = Management.revoke_session("ses_1", config(bypass))
    end

    test "returns an error tuple on 4xx", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn -> Plug.Conn.resp(conn, 404, "{}") end)
      assert {:error, 404, _} = Management.revoke_session("ses_1", config(bypass))
    end
  end
end
