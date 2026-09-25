defmodule Auth0.Api.Management.EmailsTest do
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

  describe "delete_email_provider (A-066 DELETE /api/v2/emails/provider)" do
    test "sends the request and returns an empty body", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        assert conn.method == "DELETE"
        assert conn.request_path == "/api/v2/emails/provider"
        Plug.Conn.resp(conn, 204, "")
      end)

      assert {:ok, ""} = Management.delete_email_provider(config(bypass))
    end

    test "returns an error tuple on 4xx", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        Plug.Conn.resp(conn, 404, "{\"statusCode\":404}")
      end)

      assert {:error, 404, _} = Management.delete_email_provider(config(bypass))
    end
  end
end
