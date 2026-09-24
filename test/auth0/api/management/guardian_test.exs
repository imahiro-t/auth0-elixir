defmodule Auth0.Api.Management.GuardianTest do
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

  describe "get_guardian_duo_settings (A-114 GET /api/v2/guardian/factors/duo/settings)" do
    test "sends the request and returns the decoded response", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        assert conn.method == "GET"
        assert conn.request_path == "/api/v2/guardian/factors/duo/settings"
        Plug.Conn.resp(conn, 200, "{\"id\":\"x\"}")
      end)

      assert {:ok, %{"id" => "x"}} = Management.get_guardian_duo_settings(config(bypass))
    end

    test "returns an error tuple on 4xx", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        Plug.Conn.resp(conn, 404, "{\"statusCode\":404}")
      end)

      assert {:error, 404, _} = Management.get_guardian_duo_settings(config(bypass))
    end
  end

  describe "update_guardian_duo_settings (A-115 PUT /api/v2/guardian/factors/duo/settings)" do
    test "sends the request and returns the decoded response", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        assert conn.method == "PUT"
        assert conn.request_path == "/api/v2/guardian/factors/duo/settings"
        {:ok, raw, conn} = Plug.Conn.read_body(conn)
        assert Jason.decode!(raw) == %{"name" => "test"}
        Plug.Conn.resp(conn, 200, "{\"id\":\"x\"}")
      end)

      assert {:ok, %{"id" => "x"}} =
               Management.update_guardian_duo_settings(%{"name" => "test"}, config(bypass))
    end

    test "returns an error tuple on 4xx", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        Plug.Conn.resp(conn, 404, "{\"statusCode\":404}")
      end)

      assert {:error, 404, _} =
               Management.update_guardian_duo_settings(%{"name" => "test"}, config(bypass))
    end
  end

  describe "patch_guardian_duo_settings (A-116 PATCH /api/v2/guardian/factors/duo/settings)" do
    test "sends the request and returns the decoded response", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        assert conn.method == "PATCH"
        assert conn.request_path == "/api/v2/guardian/factors/duo/settings"
        {:ok, raw, conn} = Plug.Conn.read_body(conn)
        assert Jason.decode!(raw) == %{"name" => "test"}
        Plug.Conn.resp(conn, 200, "{\"id\":\"x\"}")
      end)

      assert {:ok, %{"id" => "x"}} =
               Management.patch_guardian_duo_settings(%{"name" => "test"}, config(bypass))
    end

    test "returns an error tuple on 4xx", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        Plug.Conn.resp(conn, 404, "{\"statusCode\":404}")
      end)

      assert {:error, 404, _} =
               Management.patch_guardian_duo_settings(%{"name" => "test"}, config(bypass))
    end
  end

  describe "get_guardian_email_settings (A-117 GET /api/v2/guardian/factors/email/settings)" do
    test "sends the request and returns the decoded response", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        assert conn.method == "GET"
        assert conn.request_path == "/api/v2/guardian/factors/email/settings"
        Plug.Conn.resp(conn, 200, "{\"id\":\"x\"}")
      end)

      assert {:ok, %{"id" => "x"}} = Management.get_guardian_email_settings(config(bypass))
    end

    test "returns an error tuple on 4xx", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        Plug.Conn.resp(conn, 404, "{\"statusCode\":404}")
      end)

      assert {:error, 404, _} = Management.get_guardian_email_settings(config(bypass))
    end
  end

  describe "update_guardian_email_settings (A-118 PUT /api/v2/guardian/factors/email/settings)" do
    test "sends the request and returns the decoded response", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        assert conn.method == "PUT"
        assert conn.request_path == "/api/v2/guardian/factors/email/settings"
        {:ok, raw, conn} = Plug.Conn.read_body(conn)
        assert Jason.decode!(raw) == %{"name" => "test"}
        Plug.Conn.resp(conn, 200, "{\"id\":\"x\"}")
      end)

      assert {:ok, %{"id" => "x"}} =
               Management.update_guardian_email_settings(%{"name" => "test"}, config(bypass))
    end

    test "returns an error tuple on 4xx", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        Plug.Conn.resp(conn, 404, "{\"statusCode\":404}")
      end)

      assert {:error, 404, _} =
               Management.update_guardian_email_settings(%{"name" => "test"}, config(bypass))
    end
  end

  describe "get_guardian_phone_settings (A-119 GET /api/v2/guardian/factors/phone/settings)" do
    test "sends the request and returns the decoded response", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        assert conn.method == "GET"
        assert conn.request_path == "/api/v2/guardian/factors/phone/settings"
        Plug.Conn.resp(conn, 200, "{\"id\":\"x\"}")
      end)

      assert {:ok, %{"id" => "x"}} = Management.get_guardian_phone_settings(config(bypass))
    end

    test "returns an error tuple on 4xx", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        Plug.Conn.resp(conn, 404, "{\"statusCode\":404}")
      end)

      assert {:error, 404, _} = Management.get_guardian_phone_settings(config(bypass))
    end
  end

  describe "update_guardian_phone_settings (A-120 PUT /api/v2/guardian/factors/phone/settings)" do
    test "sends the request and returns the decoded response", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        assert conn.method == "PUT"
        assert conn.request_path == "/api/v2/guardian/factors/phone/settings"
        {:ok, raw, conn} = Plug.Conn.read_body(conn)
        assert Jason.decode!(raw) == %{"name" => "test"}
        Plug.Conn.resp(conn, 200, "{\"id\":\"x\"}")
      end)

      assert {:ok, %{"id" => "x"}} =
               Management.update_guardian_phone_settings(%{"name" => "test"}, config(bypass))
    end

    test "returns an error tuple on 4xx", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        Plug.Conn.resp(conn, 404, "{\"statusCode\":404}")
      end)

      assert {:error, 404, _} =
               Management.update_guardian_phone_settings(%{"name" => "test"}, config(bypass))
    end
  end

  describe "get_guardian_settings (A-122 GET /api/v2/guardian/settings)" do
    test "sends the request and returns the decoded response", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        assert conn.method == "GET"
        assert conn.request_path == "/api/v2/guardian/settings"
        Plug.Conn.resp(conn, 200, "{\"id\":\"x\"}")
      end)

      assert {:ok, %{"id" => "x"}} = Management.get_guardian_settings(config(bypass))
    end

    test "returns an error tuple on 4xx", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        Plug.Conn.resp(conn, 404, "{\"statusCode\":404}")
      end)

      assert {:error, 404, _} = Management.get_guardian_settings(config(bypass))
    end
  end

  describe "update_guardian_settings (A-123 PUT /api/v2/guardian/settings)" do
    test "sends the request and returns the decoded response", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        assert conn.method == "PUT"
        assert conn.request_path == "/api/v2/guardian/settings"
        {:ok, raw, conn} = Plug.Conn.read_body(conn)
        assert Jason.decode!(raw) == %{"name" => "test"}
        Plug.Conn.resp(conn, 200, "{\"id\":\"x\"}")
      end)

      assert {:ok, %{"id" => "x"}} =
               Management.update_guardian_settings(%{"name" => "test"}, config(bypass))
    end

    test "returns an error tuple on 4xx", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        Plug.Conn.resp(conn, 404, "{\"statusCode\":404}")
      end)

      assert {:error, 404, _} =
               Management.update_guardian_settings(%{"name" => "test"}, config(bypass))
    end
  end

  describe "create_guardian_enrollment_ticket with the auth0-custom-domain header (A-008)" do
    test "sends the header when :custom_domain is given", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        assert conn.method == "POST"
        assert conn.request_path == "/api/v2/guardian/enrollments/ticket"
        assert Plug.Conn.get_req_header(conn, "auth0-custom-domain") == ["login.example.com"]
        Plug.Conn.resp(conn, 200, "{\"id\":\"x\"}")
      end)

      assert {:ok, _} =
               Management.create_guardian_enrollment_ticket(
                 %{"user_id" => "auth0|1"},
                 config(bypass),
                 custom_domain: "login.example.com"
               )
    end

    test "does not send the header by default (existing arity)", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        assert Plug.Conn.get_req_header(conn, "auth0-custom-domain") == []
        Plug.Conn.resp(conn, 200, "{\"id\":\"x\"}")
      end)

      assert {:ok, _} =
               Management.create_guardian_enrollment_ticket(
                 %{"user_id" => "auth0|1"},
                 config(bypass)
               )
    end

    test "rejects a value that is not a host name", %{bypass: bypass} do
      assert_raise ArgumentError, fn ->
        Management.create_guardian_enrollment_ticket(%{"user_id" => "auth0|1"}, config(bypass),
          custom_domain: "evil.example.com\r\nx-injected: 1"
        )
      end
    end
  end
end
