defmodule Auth0.Api.Management.UsersTest do
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

  describe "get_user_connected_accounts (A-185 GET /api/v2/users/{id}/connected-accounts)" do
    test "sends the request and returns the decoded response", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        assert conn.method == "GET"
        assert conn.request_path == "/api/v2/users/id%7C1%2Fa%20b/connected-accounts"
        assert conn.query_string =~ "from=v1"
        Plug.Conn.resp(conn, 200, "{\"id\":\"x\"}")
      end)

      assert {:ok, %{"id" => "x"}} =
               Management.get_user_connected_accounts(
                 "id|1/a b",
                 %{"from" => "v1"},
                 config(bypass)
               )
    end

    test "returns an error tuple on 4xx", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        Plug.Conn.resp(conn, 404, "{\"statusCode\":404}")
      end)

      assert {:error, 404, _} =
               Management.get_user_connected_accounts(
                 "id|1/a b",
                 %{"from" => "v1"},
                 config(bypass)
               )
    end
  end

  describe "get_user_effective_permissions (A-186 GET /api/v2/users/{id}/effective-permissions)" do
    test "sends the request and returns the decoded response", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        assert conn.method == "GET"
        assert conn.request_path == "/api/v2/users/id%7C1%2Fa%20b/effective-permissions"
        assert conn.query_string =~ "from=v1"
        Plug.Conn.resp(conn, 200, "{\"id\":\"x\"}")
      end)

      assert {:ok, %{"id" => "x"}} =
               Management.get_user_effective_permissions(
                 "id|1/a b",
                 %{"from" => "v1"},
                 config(bypass)
               )
    end

    test "returns an error tuple on 4xx", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        Plug.Conn.resp(conn, 404, "{\"statusCode\":404}")
      end)

      assert {:error, 404, _} =
               Management.get_user_effective_permissions(
                 "id|1/a b",
                 %{"from" => "v1"},
                 config(bypass)
               )
    end
  end

  describe "get_user_effective_permission_role_sources (A-187 GET /api/v2/users/{id}/effective-permissions/sources/effective-roles)" do
    test "sends the request and returns the decoded response", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        assert conn.method == "GET"

        assert conn.request_path ==
                 "/api/v2/users/id%7C1%2Fa%20b/effective-permissions/sources/effective-roles"

        assert conn.query_string =~ "from=v1"
        Plug.Conn.resp(conn, 200, "{\"id\":\"x\"}")
      end)

      assert {:ok, %{"id" => "x"}} =
               Management.get_user_effective_permission_role_sources(
                 "id|1/a b",
                 %{"from" => "v1"},
                 config(bypass)
               )
    end

    test "returns an error tuple on 4xx", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        Plug.Conn.resp(conn, 404, "{\"statusCode\":404}")
      end)

      assert {:error, 404, _} =
               Management.get_user_effective_permission_role_sources(
                 "id|1/a b",
                 %{"from" => "v1"},
                 config(bypass)
               )
    end
  end

  describe "get_user_effective_roles (A-188 GET /api/v2/users/{id}/effective-roles)" do
    test "sends the request and returns the decoded response", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        assert conn.method == "GET"
        assert conn.request_path == "/api/v2/users/id%7C1%2Fa%20b/effective-roles"
        assert conn.query_string =~ "from=v1"
        Plug.Conn.resp(conn, 200, "{\"id\":\"x\"}")
      end)

      assert {:ok, %{"id" => "x"}} =
               Management.get_user_effective_roles("id|1/a b", %{"from" => "v1"}, config(bypass))
    end

    test "returns an error tuple on 4xx", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        Plug.Conn.resp(conn, 404, "{\"statusCode\":404}")
      end)

      assert {:error, 404, _} =
               Management.get_user_effective_roles("id|1/a b", %{"from" => "v1"}, config(bypass))
    end
  end

  describe "get_user_effective_role_group_sources (A-189 GET /api/v2/users/{id}/effective-roles/sources/groups)" do
    test "sends the request and returns the decoded response", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        assert conn.method == "GET"
        assert conn.request_path == "/api/v2/users/id%7C1%2Fa%20b/effective-roles/sources/groups"
        assert conn.query_string =~ "role_id=v1"
        Plug.Conn.resp(conn, 200, "{\"id\":\"x\"}")
      end)

      assert {:ok, %{"id" => "x"}} =
               Management.get_user_effective_role_group_sources(
                 "id|1/a b",
                 %{"role_id" => "v1"},
                 config(bypass)
               )
    end

    test "returns an error tuple on 4xx", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        Plug.Conn.resp(conn, 404, "{\"statusCode\":404}")
      end)

      assert {:error, 404, _} =
               Management.get_user_effective_role_group_sources(
                 "id|1/a b",
                 %{"role_id" => "v1"},
                 config(bypass)
               )
    end
  end

  describe "get_user_groups (A-190 GET /api/v2/users/{id}/groups)" do
    test "sends the request and returns the decoded response", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        assert conn.method == "GET"
        assert conn.request_path == "/api/v2/users/id%7C1%2Fa%20b/groups"
        assert conn.query_string =~ "fields=v1"
        Plug.Conn.resp(conn, 200, "{\"id\":\"x\"}")
      end)

      assert {:ok, %{"id" => "x"}} =
               Management.get_user_groups("id|1/a b", %{"fields" => "v1"}, config(bypass))
    end

    test "returns an error tuple on 4xx", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        Plug.Conn.resp(conn, 404, "{\"statusCode\":404}")
      end)

      assert {:error, 404, _} =
               Management.get_user_groups("id|1/a b", %{"fields" => "v1"}, config(bypass))
    end
  end

  describe "clear_user_risk_assessments (A-191 POST /api/v2/users/{id}/risk-assessments/clear)" do
    test "sends the request and returns the decoded response", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        assert conn.method == "POST"
        assert conn.request_path == "/api/v2/users/id%7C1%2Fa%20b/risk-assessments/clear"
        {:ok, raw, conn} = Plug.Conn.read_body(conn)
        assert Jason.decode!(raw) == %{"name" => "test"}
        Plug.Conn.resp(conn, 204, "")
      end)

      assert {:ok, ""} =
               Management.clear_user_risk_assessments(
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
               Management.clear_user_risk_assessments(
                 "id|1/a b",
                 %{"name" => "test"},
                 config(bypass)
               )
    end
  end
end
