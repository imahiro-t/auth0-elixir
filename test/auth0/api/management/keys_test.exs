defmodule Auth0.Api.Management.KeysTest do
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

  describe "create_encryption_wrapping_key/2 (quality gate fix: body was the tuple {})" do
    test "posts an empty JSON object and returns the decoded key", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        assert conn.method == "POST"
        assert conn.request_path == "/api/v2/keys/encryption/kid-1/wrapping-key"
        {:ok, raw, conn} = Plug.Conn.read_body(conn)
        assert Jason.decode!(raw) == %{}

        Plug.Conn.resp(
          conn,
          201,
          "{\"public_key\":\"pk\",\"algorithm\":\"CKM_RSA_AES_KEY_WRAP\"}"
        )
      end)

      assert {:ok, %{"public_key" => "pk"}} =
               Management.create_encryption_wrapping_key("kid-1", config(bypass))
    end

    test "returns an error tuple on 4xx", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        Plug.Conn.resp(conn, 404, "{\"statusCode\":404}")
      end)

      assert {:error, 404, _} = Management.create_encryption_wrapping_key("kid-1", config(bypass))
    end
  end
end
