defmodule Auth0.Api.ManagementTest do
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

  describe "get_users/2" do
    test "lists users", %{bypass: bypass} do
      Bypass.expect_once(bypass, "GET", "/api/v2/users", fn conn ->
        params = Plug.Conn.fetch_query_params(conn).query_params
        assert params["page"] == "0"
        assert params["per_page"] == "50"
        Plug.Conn.resp(conn, 200, "[{\"email\":\"test@example.com\"}]")
      end)

      assert {:ok, body} = Management.get_users(%{page: 0, per_page: 50}, config(bypass))
      assert body |> List.first() |> Map.get("email") == "test@example.com"
    end
  end

  describe "get_user/3" do
    test "gets a user by id", %{bypass: bypass} do
      user_id = "auth0|123456"
      # The library encodes the path parameter, so expectation should match the encoded version
      encoded_user_id = URI.encode_www_form(user_id)
      
      Bypass.expect_once(bypass, "GET", "/api/v2/users/" <> encoded_user_id, fn conn ->
        Plug.Conn.resp(conn, 200, "{\"user_id\":\"#{user_id}\"}")
      end)

      assert {:ok, body} = Management.get_user(user_id, %{}, config(bypass))
      assert body |> Map.get("user_id") == user_id
    end
  end
end
