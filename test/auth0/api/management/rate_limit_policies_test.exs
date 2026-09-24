defmodule Auth0.Api.Management.RateLimitPoliciesTest do
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

  describe "get_rate_limit_policies (A-162 GET /api/v2/rate-limit-policies)" do
    test "sends the request and returns the decoded response", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        assert conn.method == "GET"
        assert conn.request_path == "/api/v2/rate-limit-policies"
        assert conn.query_string =~ "resource=v1"
        Plug.Conn.resp(conn, 200, "{\"id\":\"x\"}")
      end)

      assert {:ok, %{"id" => "x"}} =
               Management.get_rate_limit_policies(%{"resource" => "v1"}, config(bypass))
    end

    test "returns an error tuple on 4xx", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        Plug.Conn.resp(conn, 404, "{\"statusCode\":404}")
      end)

      assert {:error, 404, _} =
               Management.get_rate_limit_policies(%{"resource" => "v1"}, config(bypass))
    end
  end

  describe "create_rate_limit_policy (A-163 POST /api/v2/rate-limit-policies)" do
    test "sends the request and returns the decoded response", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        assert conn.method == "POST"
        assert conn.request_path == "/api/v2/rate-limit-policies"
        {:ok, raw, conn} = Plug.Conn.read_body(conn)
        assert Jason.decode!(raw) == %{"name" => "test"}
        Plug.Conn.resp(conn, 201, "{\"id\":\"x\"}")
      end)

      assert {:ok, %{"id" => "x"}} =
               Management.create_rate_limit_policy(%{"name" => "test"}, config(bypass))
    end

    test "returns an error tuple on 4xx", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        Plug.Conn.resp(conn, 404, "{\"statusCode\":404}")
      end)

      assert {:error, 404, _} =
               Management.create_rate_limit_policy(%{"name" => "test"}, config(bypass))
    end
  end

  describe "get_rate_limit_policy (A-164 GET /api/v2/rate-limit-policies/{id})" do
    test "sends the request and returns the decoded response", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        assert conn.method == "GET"
        assert conn.request_path == "/api/v2/rate-limit-policies/id%7C1%2Fa%20b"
        Plug.Conn.resp(conn, 200, "{\"id\":\"x\"}")
      end)

      assert {:ok, %{"id" => "x"}} = Management.get_rate_limit_policy("id|1/a b", config(bypass))
    end

    test "returns an error tuple on 4xx", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        Plug.Conn.resp(conn, 404, "{\"statusCode\":404}")
      end)

      assert {:error, 404, _} = Management.get_rate_limit_policy("id|1/a b", config(bypass))
    end
  end

  describe "update_rate_limit_policy (A-165 PATCH /api/v2/rate-limit-policies/{id})" do
    test "sends the request and returns the decoded response", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        assert conn.method == "PATCH"
        assert conn.request_path == "/api/v2/rate-limit-policies/id%7C1%2Fa%20b"
        {:ok, raw, conn} = Plug.Conn.read_body(conn)
        assert Jason.decode!(raw) == %{"name" => "test"}
        Plug.Conn.resp(conn, 200, "{\"id\":\"x\"}")
      end)

      assert {:ok, %{"id" => "x"}} =
               Management.update_rate_limit_policy(
                 "id|1/a b",
                 %{"name" => "test"},
                 config(bypass)
               )
    end

    test "returns an error tuple on 4xx", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        Plug.Conn.resp(conn, 404, "{\"statusCode\":404}")
      end)

      assert {:error, 404, _} =
               Management.update_rate_limit_policy(
                 "id|1/a b",
                 %{"name" => "test"},
                 config(bypass)
               )
    end
  end

  describe "delete_rate_limit_policy (A-166 DELETE /api/v2/rate-limit-policies/{id})" do
    test "sends the request and returns the decoded response", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        assert conn.method == "DELETE"
        assert conn.request_path == "/api/v2/rate-limit-policies/id%7C1%2Fa%20b"
        Plug.Conn.resp(conn, 204, "")
      end)

      assert {:ok, ""} = Management.delete_rate_limit_policy("id|1/a b", config(bypass))
    end

    test "returns an error tuple on 4xx", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        Plug.Conn.resp(conn, 404, "{\"statusCode\":404}")
      end)

      assert {:error, 404, _} = Management.delete_rate_limit_policy("id|1/a b", config(bypass))
    end
  end
end
