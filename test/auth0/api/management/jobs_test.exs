defmodule Auth0.Api.Management.JobsTest do
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

  describe "send_job_verification_email with the auth0-custom-domain header (A-009)" do
    test "sends the header when :custom_domain is given", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        assert conn.method == "POST"
        assert conn.request_path == "/api/v2/jobs/verification-email"
        assert Plug.Conn.get_req_header(conn, "auth0-custom-domain") == ["login.example.com"]
        Plug.Conn.resp(conn, 201, "{\"id\":\"x\"}")
      end)

      assert {:ok, _} =
               Management.send_job_verification_email(%{"user_id" => "auth0|1"}, config(bypass),
                 custom_domain: "login.example.com"
               )
    end

    test "does not send the header by default (existing arity)", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        assert Plug.Conn.get_req_header(conn, "auth0-custom-domain") == []
        Plug.Conn.resp(conn, 201, "{\"id\":\"x\"}")
      end)

      assert {:ok, _} =
               Management.send_job_verification_email(%{"user_id" => "auth0|1"}, config(bypass))
    end

    test "rejects a value that is not a host name", %{bypass: bypass} do
      assert_raise ArgumentError, fn ->
        Management.send_job_verification_email(%{"user_id" => "auth0|1"}, config(bypass),
          custom_domain: "evil.example.com\r\nx-injected: 1"
        )
      end
    end
  end

  describe "get_job_error (参考所見3)" do
    test "returns an empty string on 204 with an empty body", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        assert conn.method == "GET"
        assert conn.request_path == "/api/v2/jobs/job_1/errors"
        Plug.Conn.resp(conn, 204, "")
      end)

      assert {:ok, ""} = Management.get_job_error("job_1", config(bypass))
    end

    test "decodes the 200 body", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        assert conn.method == "GET"
        assert conn.request_path == "/api/v2/jobs/job_1/errors"
        Plug.Conn.resp(conn, 200, "[]")
      end)

      assert {:ok, []} = Management.get_job_error("job_1", config(bypass))
    end

    test "returns an error tuple on 4xx", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn -> Plug.Conn.resp(conn, 404, "{}") end)
      assert {:error, 404, _} = Management.get_job_error("job_1", config(bypass))
    end
  end
end
