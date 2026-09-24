defmodule Auth0.Entity.TokenTest do
  use ExUnit.Case, async: true

  alias Auth0.Entity.Token

  test "inspect/1 does not expose access_token, refresh_token or id_token" do
    token = %Token{
      access_token: "secret-access-token-value",
      refresh_token: "secret-refresh-token-value",
      id_token: "secret-id-token-value",
      token_type: "Bearer",
      expires_in: 86_400,
      scope: "read:users"
    }

    inspected = inspect(token)

    refute inspected =~ "secret-access-token-value"
    refute inspected =~ "secret-refresh-token-value"
    refute inspected =~ "secret-id-token-value"

    assert inspected =~ "Bearer"
    assert inspected =~ "86400"
    assert inspected =~ "read:users"
  end

  test "masked fields are still accessible on the struct" do
    token = Token.from(%{"access_token" => "secret-access-token-value", "expires_in" => 60})

    assert token.access_token == "secret-access-token-value"
    assert token.expires_in == 60
  end
end
