defmodule Auth0.Api.Management.RolesTest do
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

  describe "get_role_groups (A-175 GET /api/v2/roles/{id}/groups)" do
    test "sends the request and returns the decoded response", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        assert conn.method == "GET"
        assert conn.request_path == "/api/v2/roles/id%7C1%2Fa%20b/groups"
        assert conn.query_string =~ "from=v1"
        Plug.Conn.resp(conn, 200, "{\"id\":\"x\"}")
      end)

      assert {:ok, %{"id" => "x"}} =
               Management.get_role_groups("id|1/a b", %{"from" => "v1"}, config(bypass))
    end

    test "returns an error tuple on 4xx", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        Plug.Conn.resp(conn, 404, "{\"statusCode\":404}")
      end)

      assert {:error, 404, _} =
               Management.get_role_groups("id|1/a b", %{"from" => "v1"}, config(bypass))
    end
  end

  describe "assign_role_groups (A-176 POST /api/v2/roles/{id}/groups)" do
    test "sends the request and returns an empty body", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        assert conn.method == "POST"
        assert conn.request_path == "/api/v2/roles/id%7C1%2Fa%20b/groups"
        {:ok, raw, conn} = Plug.Conn.read_body(conn)
        assert Jason.decode!(raw) == %{"name" => "test"}
        Plug.Conn.resp(conn, 204, "")
      end)

      assert {:ok, ""} =
               Management.assign_role_groups("id|1/a b", %{"name" => "test"}, config(bypass))
    end

    test "returns an error tuple on 4xx", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        Plug.Conn.resp(conn, 404, "{\"statusCode\":404}")
      end)

      assert {:error, 404, _} =
               Management.assign_role_groups("id|1/a b", %{"name" => "test"}, config(bypass))
    end
  end

  describe "remove_role_groups (A-177 DELETE /api/v2/roles/{id}/groups)" do
    test "sends the request and returns an empty body", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        assert conn.method == "DELETE"
        assert conn.request_path == "/api/v2/roles/id%7C1%2Fa%20b/groups"
        {:ok, raw, conn} = Plug.Conn.read_body(conn)
        assert Jason.decode!(raw) == %{"name" => "test"}
        Plug.Conn.resp(conn, 204, "")
      end)

      assert {:ok, ""} =
               Management.remove_role_groups("id|1/a b", %{"name" => "test"}, config(bypass))
    end

    test "returns an error tuple on 4xx", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        Plug.Conn.resp(conn, 404, "{\"statusCode\":404}")
      end)

      assert {:error, 404, _} =
               Management.remove_role_groups("id|1/a b", %{"name" => "test"}, config(bypass))
    end
  end
end
