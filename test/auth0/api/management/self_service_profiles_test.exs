defmodule Auth0.Api.Management.SelfServiceProfilesTest do
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

  describe "get_self_service_profile_custom_text (A-178 GET /api/v2/self-service-profiles/{id}/custom-text/{language}/{page})" do
    test "sends the request and returns the decoded response", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        assert conn.method == "GET"

        assert conn.request_path ==
                 "/api/v2/self-service-profiles/id%7C1%2Fa%20b/custom-text/en%2FUS/get-started"

        Plug.Conn.resp(conn, 200, "{\"id\":\"x\"}")
      end)

      assert {:ok, %{"id" => "x"}} =
               Management.get_self_service_profile_custom_text(
                 "id|1/a b",
                 "en/US",
                 "get-started",
                 config(bypass)
               )
    end

    test "returns an error tuple on 4xx", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        Plug.Conn.resp(conn, 404, "{\"statusCode\":404}")
      end)

      assert {:error, 404, _} =
               Management.get_self_service_profile_custom_text(
                 "id|1/a b",
                 "en/US",
                 "get-started",
                 config(bypass)
               )
    end
  end

  describe "set_self_service_profile_custom_text (A-179 PUT /api/v2/self-service-profiles/{id}/custom-text/{language}/{page})" do
    test "sends the request and returns the decoded response", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        assert conn.method == "PUT"

        assert conn.request_path ==
                 "/api/v2/self-service-profiles/id%7C1%2Fa%20b/custom-text/en%2FUS/get-started"

        {:ok, raw, conn} = Plug.Conn.read_body(conn)
        assert Jason.decode!(raw) == %{"name" => "test"}
        Plug.Conn.resp(conn, 200, "{\"id\":\"x\"}")
      end)

      assert {:ok, %{"id" => "x"}} =
               Management.set_self_service_profile_custom_text(
                 "id|1/a b",
                 "en/US",
                 "get-started",
                 %{"name" => "test"},
                 config(bypass)
               )
    end

    test "returns an error tuple on 4xx", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        Plug.Conn.resp(conn, 404, "{\"statusCode\":404}")
      end)

      assert {:error, 404, _} =
               Management.set_self_service_profile_custom_text(
                 "id|1/a b",
                 "en/US",
                 "get-started",
                 %{"name" => "test"},
                 config(bypass)
               )
    end
  end

  describe "revoke_self_service_profile_sso_ticket (A-180 POST /api/v2/self-service-profiles/{profileId}/sso-ticket/{id}/revoke)" do
    test "sends the request and returns the decoded response", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        assert conn.method == "POST"

        assert conn.request_path ==
                 "/api/v2/self-service-profiles/ssp%7C1%2F2/sso-ticket/id%7C1%2Fa%20b/revoke"

        Plug.Conn.resp(conn, 202, "")
      end)

      assert {:ok, ""} =
               Management.revoke_self_service_profile_sso_ticket(
                 "ssp|1/2",
                 "id|1/a b",
                 config(bypass)
               )
    end

    test "returns an error tuple on 4xx", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        Plug.Conn.resp(conn, 404, "{\"statusCode\":404}")
      end)

      assert {:error, 404, _} =
               Management.revoke_self_service_profile_sso_ticket(
                 "ssp|1/2",
                 "id|1/a b",
                 config(bypass)
               )
    end
  end

  describe "create_self_service_profile_sso_ticket with the auth0-custom-domain header (A-011)" do
    test "sends the header when :custom_domain is given", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        assert conn.method == "POST"
        assert conn.request_path == "/api/v2/self-service-profiles/ssp_1/sso-ticket"
        assert Plug.Conn.get_req_header(conn, "auth0-custom-domain") == ["login.example.com"]
        Plug.Conn.resp(conn, 201, "{\"id\":\"x\"}")
      end)

      assert {:ok, _} =
               Management.create_self_service_profile_sso_ticket("ssp_1", %{}, config(bypass),
                 custom_domain: "login.example.com"
               )
    end

    test "does not send the header by default (existing arity)", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        assert Plug.Conn.get_req_header(conn, "auth0-custom-domain") == []
        Plug.Conn.resp(conn, 201, "{\"id\":\"x\"}")
      end)

      assert {:ok, _} =
               Management.create_self_service_profile_sso_ticket("ssp_1", %{}, config(bypass))
    end

    test "rejects a value that is not a host name", %{bypass: bypass} do
      assert_raise ArgumentError, fn ->
        Management.create_self_service_profile_sso_ticket("ssp_1", %{}, config(bypass),
          custom_domain: "evil.example.com\r\nx-injected: 1"
        )
      end
    end
  end

  describe "delete_self_service_profile (C-011)" do
    test "returns an empty string on 204 (no JSON decode)", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        assert conn.method == "DELETE"
        assert conn.request_path == "/api/v2/self-service-profiles/ssp_1"
        Plug.Conn.resp(conn, 204, "")
      end)

      assert {:ok, ""} = Management.delete_self_service_profile("ssp_1", config(bypass))
    end

    test "returns an error tuple on 4xx", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn -> Plug.Conn.resp(conn, 404, "{}") end)
      assert {:error, 404, _} = Management.delete_self_service_profile("ssp_1", config(bypass))
    end
  end
end
