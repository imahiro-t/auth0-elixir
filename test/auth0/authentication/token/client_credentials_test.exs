defmodule Auth0.Authentication.Token.ClientCredentialsTest do
  use ExUnit.Case, async: true

  alias Auth0.Authentication.Token.ClientCredentials
  alias Auth0.Authentication.Token.ClientCredentials.Params
  alias Auth0.Config

  test "inspect/1 of Params does not expose client_secret" do
    params = %Params{
      audience: "https://example.auth0.com/api/v2/",
      client_id: "my-client-id",
      client_secret: "super-secret-value"
    }

    inspected = inspect(params)

    refute inspected =~ "super-secret-value"
    assert inspected =~ "my-client-id"
    assert inspected =~ "https://example.auth0.com/api/v2/"
  end

  describe "execute/2 over HTTP" do
    setup do
      bypass = Bypass.open()
      config = %Config{domain: "localhost:#{bypass.port}", http_protocol: "http"}
      params = %Params{audience: "aud", client_id: "cid", client_secret: "super-secret-value"}
      {:ok, bypass: bypass, config: config, params: params}
    end

    test "a 302 from the token endpoint is not followed, so the secret is sent only once",
         %{bypass: bypass, config: config, params: params} do
      other = Bypass.open()
      target = "http://localhost:#{other.port}/oauth/token"

      Bypass.expect_once(bypass, "POST", "/oauth/token", fn conn ->
        conn
        |> Plug.Conn.put_resp_header("location", target)
        |> Plug.Conn.resp(302, "")
      end)

      # `other` has no expectations: any request reaching it (which would carry
      # the client_secret in its body) fails the test.
      assert {:ok, 302, ^target} = ClientCredentials.execute(params, config)
    end

    test "a connection failure is returned as {:error, reason}",
         %{bypass: bypass, config: config, params: params} do
      Bypass.down(bypass)

      assert {:error, :econnrefused} = ClientCredentials.execute(params, config)
    end
  end
end
