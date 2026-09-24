defmodule Auth0.Api.Management.TicketsTest do
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

  describe "create_email_verification_ticket with the auth0-custom-domain header (A-013)" do
    test "sends the header when :custom_domain is given", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        assert conn.method == "POST"
        assert conn.request_path == "/api/v2/tickets/email-verification"
        assert Plug.Conn.get_req_header(conn, "auth0-custom-domain") == ["login.example.com"]
        Plug.Conn.resp(conn, 201, "{\"id\":\"x\"}")
      end)

      assert {:ok, _} =
               Management.create_email_verification_ticket(
                 %{"user_id" => "auth0|1"},
                 config(bypass),
                 custom_domain: "login.example.com"
               )
    end

    test "does not send the header by default (existing arity)", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        assert Plug.Conn.get_req_header(conn, "auth0-custom-domain") == []
        Plug.Conn.resp(conn, 201, "{\"id\":\"x\"}")
      end)

      assert {:ok, _} =
               Management.create_email_verification_ticket(
                 %{"user_id" => "auth0|1"},
                 config(bypass)
               )
    end

    test "rejects a value that is not a host name", %{bypass: bypass} do
      assert_raise ArgumentError, fn ->
        Management.create_email_verification_ticket(%{"user_id" => "auth0|1"}, config(bypass),
          custom_domain: "evil.example.com\r\nx-injected: 1"
        )
      end
    end
  end

  describe "create_password_change_ticket with the auth0-custom-domain header (A-014)" do
    test "sends the header when :custom_domain is given", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        assert conn.method == "POST"
        assert conn.request_path == "/api/v2/tickets/password-change"
        assert Plug.Conn.get_req_header(conn, "auth0-custom-domain") == ["login.example.com"]
        Plug.Conn.resp(conn, 201, "{\"id\":\"x\"}")
      end)

      assert {:ok, _} =
               Management.create_password_change_ticket(%{"user_id" => "auth0|1"}, config(bypass),
                 custom_domain: "login.example.com"
               )
    end

    test "does not send the header by default (existing arity)", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        assert Plug.Conn.get_req_header(conn, "auth0-custom-domain") == []
        Plug.Conn.resp(conn, 201, "{\"id\":\"x\"}")
      end)

      assert {:ok, _} =
               Management.create_password_change_ticket(%{"user_id" => "auth0|1"}, config(bypass))
    end

    test "rejects a value that is not a host name", %{bypass: bypass} do
      assert_raise ArgumentError, fn ->
        Management.create_password_change_ticket(%{"user_id" => "auth0|1"}, config(bypass),
          custom_domain: "evil.example.com\r\nx-injected: 1"
        )
      end
    end
  end
end
