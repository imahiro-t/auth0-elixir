defmodule Auth0.Api.Management.BrandingTest do
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

  describe "test_branding_phone_template with the auth0-custom-domain header (A-006)" do
    test "sends the header when :custom_domain is given", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        assert conn.method == "POST"
        assert conn.request_path == "/api/v2/branding/phone/templates/tem_1/try"
        assert Plug.Conn.get_req_header(conn, "auth0-custom-domain") == ["login.example.com"]
        Plug.Conn.resp(conn, 202, "{\"id\":\"x\"}")
      end)

      assert {:ok, _} =
               Management.test_branding_phone_template(
                 "tem_1",
                 %{"to" => "+15555550100"},
                 config(bypass),
                 custom_domain: "login.example.com"
               )
    end

    test "does not send the header by default (existing arity)", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        assert Plug.Conn.get_req_header(conn, "auth0-custom-domain") == []
        Plug.Conn.resp(conn, 202, "{\"id\":\"x\"}")
      end)

      assert {:ok, _} =
               Management.test_branding_phone_template(
                 "tem_1",
                 %{"to" => "+15555550100"},
                 config(bypass)
               )
    end

    test "rejects a value that is not a host name", %{bypass: bypass} do
      assert_raise ArgumentError, fn ->
        Management.test_branding_phone_template(
          "tem_1",
          %{"to" => "+15555550100"},
          config(bypass),
          custom_domain: "evil.example.com\r\nx-injected: 1"
        )
      end
    end
  end

  describe "delete_branding_phone_provider (C-009)" do
    test "returns an empty string on 204 (no JSON decode)", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        assert conn.method == "DELETE"
        assert conn.request_path == "/api/v2/branding/phone/providers/pro_1"
        Plug.Conn.resp(conn, 204, "")
      end)

      assert {:ok, ""} = Management.delete_branding_phone_provider("pro_1", config(bypass))
    end

    test "returns an error tuple on 4xx", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn -> Plug.Conn.resp(conn, 404, "{}") end)
      assert {:error, 404, _} = Management.delete_branding_phone_provider("pro_1", config(bypass))
    end
  end

  describe "delete_branding_phone_template (C-010)" do
    test "returns an empty string on 204 (no JSON decode)", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        assert conn.method == "DELETE"
        assert conn.request_path == "/api/v2/branding/phone/templates/tem_1"
        Plug.Conn.resp(conn, 204, "")
      end)

      assert {:ok, ""} = Management.delete_branding_phone_template("tem_1", config(bypass))
    end

    test "returns an error tuple on 4xx", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn -> Plug.Conn.resp(conn, 404, "{}") end)
      assert {:error, 404, _} = Management.delete_branding_phone_template("tem_1", config(bypass))
    end
  end
end
