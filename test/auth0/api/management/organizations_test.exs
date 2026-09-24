defmodule Auth0.Api.Management.OrganizationsTest do
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

  describe "search_organizations (A-132 GET /api/v2/organizations/search)" do
    test "sends the request and returns the decoded response", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        assert conn.method == "GET"
        assert conn.request_path == "/api/v2/organizations/search"
        assert conn.query_string =~ "q=v1"
        Plug.Conn.resp(conn, 200, "{\"id\":\"x\"}")
      end)

      assert {:ok, %{"id" => "x"}} =
               Management.search_organizations(%{"q" => "v1"}, config(bypass))
    end

    test "returns an error tuple on 4xx", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        Plug.Conn.resp(conn, 404, "{\"statusCode\":404}")
      end)

      assert {:error, 404, _} = Management.search_organizations(%{"q" => "v1"}, config(bypass))
    end
  end

  describe "get_organization_client_grants (A-133 GET /api/v2/organizations/{id}/client-grants)" do
    test "sends the request and returns the decoded response", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        assert conn.method == "GET"
        assert conn.request_path == "/api/v2/organizations/id%7C1%2Fa%20b/client-grants"
        assert conn.query_string =~ "audience=v1"
        assert conn.query_string =~ "grant_ids=x&grant_ids=y"
        Plug.Conn.resp(conn, 200, "{\"id\":\"x\"}")
      end)

      assert {:ok, %{"id" => "x"}} =
               Management.get_organization_client_grants(
                 "id|1/a b",
                 %{"audience" => "v1", "grant_ids" => ["x", "y"]},
                 config(bypass)
               )
    end

    test "returns an error tuple on 4xx", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        Plug.Conn.resp(conn, 404, "{\"statusCode\":404}")
      end)

      assert {:error, 404, _} =
               Management.get_organization_client_grants(
                 "id|1/a b",
                 %{"audience" => "v1", "grant_ids" => ["x", "y"]},
                 config(bypass)
               )
    end
  end

  describe "associate_organization_client_grant (A-134 POST /api/v2/organizations/{id}/client-grants)" do
    test "sends the request and returns the decoded response", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        assert conn.method == "POST"
        assert conn.request_path == "/api/v2/organizations/id%7C1%2Fa%20b/client-grants"
        {:ok, raw, conn} = Plug.Conn.read_body(conn)
        assert Jason.decode!(raw) == %{"name" => "test"}
        Plug.Conn.resp(conn, 201, "{\"id\":\"x\"}")
      end)

      assert {:ok, %{"id" => "x"}} =
               Management.associate_organization_client_grant(
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
               Management.associate_organization_client_grant(
                 "id|1/a b",
                 %{"name" => "test"},
                 config(bypass)
               )
    end
  end

  describe "delete_organization_client_grant (A-135 DELETE /api/v2/organizations/{id}/client-grants/{grant_id})" do
    test "sends the request and returns the decoded response", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        assert conn.method == "DELETE"

        assert conn.request_path ==
                 "/api/v2/organizations/id%7C1%2Fa%20b/client-grants/cgr%7C1%2F2"

        Plug.Conn.resp(conn, 204, "")
      end)

      assert {:ok, ""} =
               Management.delete_organization_client_grant("id|1/a b", "cgr|1/2", config(bypass))
    end

    test "returns an error tuple on 4xx", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        Plug.Conn.resp(conn, 404, "{\"statusCode\":404}")
      end)

      assert {:error, 404, _} =
               Management.delete_organization_client_grant("id|1/a b", "cgr|1/2", config(bypass))
    end
  end

  describe "get_organization_clients (A-136 GET /api/v2/organizations/{id}/clients)" do
    test "sends the request and returns the decoded response", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        assert conn.method == "GET"
        assert conn.request_path == "/api/v2/organizations/id%7C1%2Fa%20b/clients"
        assert conn.query_string =~ "from=v1"
        Plug.Conn.resp(conn, 200, "{\"id\":\"x\"}")
      end)

      assert {:ok, %{"id" => "x"}} =
               Management.get_organization_clients("id|1/a b", %{"from" => "v1"}, config(bypass))
    end

    test "returns an error tuple on 4xx", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        Plug.Conn.resp(conn, 404, "{\"statusCode\":404}")
      end)

      assert {:error, 404, _} =
               Management.get_organization_clients("id|1/a b", %{"from" => "v1"}, config(bypass))
    end
  end

  describe "add_organization_clients (A-137 POST /api/v2/organizations/{id}/clients)" do
    test "sends the request and returns the decoded response", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        assert conn.method == "POST"
        assert conn.request_path == "/api/v2/organizations/id%7C1%2Fa%20b/clients"
        {:ok, raw, conn} = Plug.Conn.read_body(conn)
        assert Jason.decode!(raw) == %{"name" => "test"}
        Plug.Conn.resp(conn, 201, "[{\"id\":\"x\"}]")
      end)

      assert {:ok, [%{"id" => "x"}]} =
               Management.add_organization_clients(
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
               Management.add_organization_clients(
                 "id|1/a b",
                 %{"name" => "test"},
                 config(bypass)
               )
    end
  end

  describe "delete_organization_clients (A-138 DELETE /api/v2/organizations/{id}/clients)" do
    test "sends the request and returns the decoded response", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        assert conn.method == "DELETE"
        assert conn.request_path == "/api/v2/organizations/id%7C1%2Fa%20b/clients"
        {:ok, raw, conn} = Plug.Conn.read_body(conn)
        assert Jason.decode!(raw) == %{"name" => "test"}
        Plug.Conn.resp(conn, 204, "")
      end)

      assert {:ok, ""} =
               Management.delete_organization_clients(
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
               Management.delete_organization_clients(
                 "id|1/a b",
                 %{"name" => "test"},
                 config(bypass)
               )
    end
  end

  describe "get_organization_client (A-139 GET /api/v2/organizations/{id}/clients/{client_id})" do
    test "sends the request and returns the decoded response", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        assert conn.method == "GET"
        assert conn.request_path == "/api/v2/organizations/id%7C1%2Fa%20b/clients/cli%7C1%2F2"
        Plug.Conn.resp(conn, 200, "{\"id\":\"x\"}")
      end)

      assert {:ok, %{"id" => "x"}} =
               Management.get_organization_client("id|1/a b", "cli|1/2", config(bypass))
    end

    test "returns an error tuple on 4xx", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        Plug.Conn.resp(conn, 404, "{\"statusCode\":404}")
      end)

      assert {:error, 404, _} =
               Management.get_organization_client("id|1/a b", "cli|1/2", config(bypass))
    end
  end

  describe "update_organization_client (A-140 PATCH /api/v2/organizations/{id}/clients/{client_id})" do
    test "sends the request and returns the decoded response", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        assert conn.method == "PATCH"
        assert conn.request_path == "/api/v2/organizations/id%7C1%2Fa%20b/clients/cli%7C1%2F2"
        {:ok, raw, conn} = Plug.Conn.read_body(conn)
        assert Jason.decode!(raw) == %{"name" => "test"}
        Plug.Conn.resp(conn, 200, "{\"id\":\"x\"}")
      end)

      assert {:ok, %{"id" => "x"}} =
               Management.update_organization_client(
                 "id|1/a b",
                 "cli|1/2",
                 %{"name" => "test"},
                 config(bypass)
               )
    end

    test "returns an error tuple on 4xx", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        Plug.Conn.resp(conn, 404, "{\"statusCode\":404}")
      end)

      assert {:error, 404, _} =
               Management.update_organization_client(
                 "id|1/a b",
                 "cli|1/2",
                 %{"name" => "test"},
                 config(bypass)
               )
    end
  end

  describe "get_organization_associated_connections (A-141 GET /api/v2/organizations/{id}/connections)" do
    test "sends the request and returns the decoded response", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        assert conn.method == "GET"
        assert conn.request_path == "/api/v2/organizations/id%7C1%2Fa%20b/connections"
        assert conn.query_string =~ "page=v1"
        Plug.Conn.resp(conn, 200, "{\"id\":\"x\"}")
      end)

      assert {:ok, %{"id" => "x"}} =
               Management.get_organization_associated_connections(
                 "id|1/a b",
                 %{"page" => "v1"},
                 config(bypass)
               )
    end

    test "returns an error tuple on 4xx", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        Plug.Conn.resp(conn, 404, "{\"statusCode\":404}")
      end)

      assert {:error, 404, _} =
               Management.get_organization_associated_connections(
                 "id|1/a b",
                 %{"page" => "v1"},
                 config(bypass)
               )
    end
  end

  describe "add_organization_associated_connection (A-142 POST /api/v2/organizations/{id}/connections)" do
    test "sends the request and returns the decoded response", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        assert conn.method == "POST"
        assert conn.request_path == "/api/v2/organizations/id%7C1%2Fa%20b/connections"
        {:ok, raw, conn} = Plug.Conn.read_body(conn)
        assert Jason.decode!(raw) == %{"name" => "test"}
        Plug.Conn.resp(conn, 201, "{\"id\":\"x\"}")
      end)

      assert {:ok, %{"id" => "x"}} =
               Management.add_organization_associated_connection(
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
               Management.add_organization_associated_connection(
                 "id|1/a b",
                 %{"name" => "test"},
                 config(bypass)
               )
    end
  end

  describe "get_organization_associated_connection (A-143 GET /api/v2/organizations/{id}/connections/{connection_id})" do
    test "sends the request and returns the decoded response", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        assert conn.method == "GET"
        assert conn.request_path == "/api/v2/organizations/id%7C1%2Fa%20b/connections/con%7C1%2F2"
        Plug.Conn.resp(conn, 200, "{\"id\":\"x\"}")
      end)

      assert {:ok, %{"id" => "x"}} =
               Management.get_organization_associated_connection(
                 "id|1/a b",
                 "con|1/2",
                 config(bypass)
               )
    end

    test "returns an error tuple on 4xx", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        Plug.Conn.resp(conn, 404, "{\"statusCode\":404}")
      end)

      assert {:error, 404, _} =
               Management.get_organization_associated_connection(
                 "id|1/a b",
                 "con|1/2",
                 config(bypass)
               )
    end
  end

  describe "update_organization_associated_connection (A-144 PATCH /api/v2/organizations/{id}/connections/{connection_id})" do
    test "sends the request and returns the decoded response", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        assert conn.method == "PATCH"
        assert conn.request_path == "/api/v2/organizations/id%7C1%2Fa%20b/connections/con%7C1%2F2"
        {:ok, raw, conn} = Plug.Conn.read_body(conn)
        assert Jason.decode!(raw) == %{"name" => "test"}
        Plug.Conn.resp(conn, 200, "{\"id\":\"x\"}")
      end)

      assert {:ok, %{"id" => "x"}} =
               Management.update_organization_associated_connection(
                 "id|1/a b",
                 "con|1/2",
                 %{"name" => "test"},
                 config(bypass)
               )
    end

    test "returns an error tuple on 4xx", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        Plug.Conn.resp(conn, 404, "{\"statusCode\":404}")
      end)

      assert {:error, 404, _} =
               Management.update_organization_associated_connection(
                 "id|1/a b",
                 "con|1/2",
                 %{"name" => "test"},
                 config(bypass)
               )
    end
  end

  describe "delete_organization_associated_connection (A-145 DELETE /api/v2/organizations/{id}/connections/{connection_id})" do
    test "sends the request and returns the decoded response", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        assert conn.method == "DELETE"
        assert conn.request_path == "/api/v2/organizations/id%7C1%2Fa%20b/connections/con%7C1%2F2"
        Plug.Conn.resp(conn, 204, "")
      end)

      assert {:ok, ""} =
               Management.delete_organization_associated_connection(
                 "id|1/a b",
                 "con|1/2",
                 config(bypass)
               )
    end

    test "returns an error tuple on 4xx", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        Plug.Conn.resp(conn, 404, "{\"statusCode\":404}")
      end)

      assert {:error, 404, _} =
               Management.delete_organization_associated_connection(
                 "id|1/a b",
                 "con|1/2",
                 config(bypass)
               )
    end
  end

  describe "get_organization_discovery_domains (A-146 GET /api/v2/organizations/{id}/discovery-domains)" do
    test "sends the request and returns the decoded response", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        assert conn.method == "GET"
        assert conn.request_path == "/api/v2/organizations/id%7C1%2Fa%20b/discovery-domains"
        assert conn.query_string =~ "from=v1"
        Plug.Conn.resp(conn, 200, "{\"id\":\"x\"}")
      end)

      assert {:ok, %{"id" => "x"}} =
               Management.get_organization_discovery_domains(
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
               Management.get_organization_discovery_domains(
                 "id|1/a b",
                 %{"from" => "v1"},
                 config(bypass)
               )
    end
  end

  describe "create_organization_discovery_domain (A-147 POST /api/v2/organizations/{id}/discovery-domains)" do
    test "sends the request and returns the decoded response", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        assert conn.method == "POST"
        assert conn.request_path == "/api/v2/organizations/id%7C1%2Fa%20b/discovery-domains"
        {:ok, raw, conn} = Plug.Conn.read_body(conn)
        assert Jason.decode!(raw) == %{"name" => "test"}
        Plug.Conn.resp(conn, 201, "{\"id\":\"x\"}")
      end)

      assert {:ok, %{"id" => "x"}} =
               Management.create_organization_discovery_domain(
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
               Management.create_organization_discovery_domain(
                 "id|1/a b",
                 %{"name" => "test"},
                 config(bypass)
               )
    end
  end

  describe "get_organization_discovery_domain_by_name (A-148 GET /api/v2/organizations/{id}/discovery-domains/name/{discovery_domain})" do
    test "sends the request and returns the decoded response", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        assert conn.method == "GET"

        assert conn.request_path ==
                 "/api/v2/organizations/id%7C1%2Fa%20b/discovery-domains/name/login.example.com%2Fx"

        Plug.Conn.resp(conn, 200, "{\"id\":\"x\"}")
      end)

      assert {:ok, %{"id" => "x"}} =
               Management.get_organization_discovery_domain_by_name(
                 "id|1/a b",
                 "login.example.com/x",
                 config(bypass)
               )
    end

    test "returns an error tuple on 4xx", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        Plug.Conn.resp(conn, 404, "{\"statusCode\":404}")
      end)

      assert {:error, 404, _} =
               Management.get_organization_discovery_domain_by_name(
                 "id|1/a b",
                 "login.example.com/x",
                 config(bypass)
               )
    end
  end

  describe "get_organization_discovery_domain (A-149 GET /api/v2/organizations/{id}/discovery-domains/{discovery_domain_id})" do
    test "sends the request and returns the decoded response", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        assert conn.method == "GET"

        assert conn.request_path ==
                 "/api/v2/organizations/id%7C1%2Fa%20b/discovery-domains/dd%7C1%2F2"

        Plug.Conn.resp(conn, 200, "{\"id\":\"x\"}")
      end)

      assert {:ok, %{"id" => "x"}} =
               Management.get_organization_discovery_domain("id|1/a b", "dd|1/2", config(bypass))
    end

    test "returns an error tuple on 4xx", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        Plug.Conn.resp(conn, 404, "{\"statusCode\":404}")
      end)

      assert {:error, 404, _} =
               Management.get_organization_discovery_domain("id|1/a b", "dd|1/2", config(bypass))
    end
  end

  describe "update_organization_discovery_domain (A-150 PATCH /api/v2/organizations/{id}/discovery-domains/{discovery_domain_id})" do
    test "sends the request and returns the decoded response", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        assert conn.method == "PATCH"

        assert conn.request_path ==
                 "/api/v2/organizations/id%7C1%2Fa%20b/discovery-domains/dd%7C1%2F2"

        {:ok, raw, conn} = Plug.Conn.read_body(conn)
        assert Jason.decode!(raw) == %{"name" => "test"}
        Plug.Conn.resp(conn, 200, "{\"id\":\"x\"}")
      end)

      assert {:ok, %{"id" => "x"}} =
               Management.update_organization_discovery_domain(
                 "id|1/a b",
                 "dd|1/2",
                 %{"name" => "test"},
                 config(bypass)
               )
    end

    test "returns an error tuple on 4xx", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        Plug.Conn.resp(conn, 404, "{\"statusCode\":404}")
      end)

      assert {:error, 404, _} =
               Management.update_organization_discovery_domain(
                 "id|1/a b",
                 "dd|1/2",
                 %{"name" => "test"},
                 config(bypass)
               )
    end
  end

  describe "delete_organization_discovery_domain (A-151 DELETE /api/v2/organizations/{id}/discovery-domains/{discovery_domain_id})" do
    test "sends the request and returns the decoded response", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        assert conn.method == "DELETE"

        assert conn.request_path ==
                 "/api/v2/organizations/id%7C1%2Fa%20b/discovery-domains/dd%7C1%2F2"

        Plug.Conn.resp(conn, 204, "")
      end)

      assert {:ok, ""} =
               Management.delete_organization_discovery_domain(
                 "id|1/a b",
                 "dd|1/2",
                 config(bypass)
               )
    end

    test "returns an error tuple on 4xx", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        Plug.Conn.resp(conn, 404, "{\"statusCode\":404}")
      end)

      assert {:error, 404, _} =
               Management.delete_organization_discovery_domain(
                 "id|1/a b",
                 "dd|1/2",
                 config(bypass)
               )
    end
  end

  describe "get_organization_member_effective_roles (A-152 GET /api/v2/organizations/{id}/members/{user_id}/effective-roles)" do
    test "sends the request and returns the decoded response", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        assert conn.method == "GET"

        assert conn.request_path ==
                 "/api/v2/organizations/id%7C1%2Fa%20b/members/auth0%7C123%2F4/effective-roles"

        assert conn.query_string =~ "from=v1"
        Plug.Conn.resp(conn, 200, "{\"id\":\"x\"}")
      end)

      assert {:ok, %{"id" => "x"}} =
               Management.get_organization_member_effective_roles(
                 "id|1/a b",
                 "auth0|123/4",
                 %{"from" => "v1"},
                 config(bypass)
               )
    end

    test "returns an error tuple on 4xx", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        Plug.Conn.resp(conn, 404, "{\"statusCode\":404}")
      end)

      assert {:error, 404, _} =
               Management.get_organization_member_effective_roles(
                 "id|1/a b",
                 "auth0|123/4",
                 %{"from" => "v1"},
                 config(bypass)
               )
    end
  end

  describe "get_organization_member_effective_role_group_sources (A-153 GET /api/v2/organizations/{id}/members/{user_id}/effective-roles/sources/groups)" do
    test "sends the request and returns the decoded response", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        assert conn.method == "GET"

        assert conn.request_path ==
                 "/api/v2/organizations/id%7C1%2Fa%20b/members/auth0%7C123%2F4/effective-roles/sources/groups"

        assert conn.query_string =~ "from=v1"
        Plug.Conn.resp(conn, 200, "{\"id\":\"x\"}")
      end)

      assert {:ok, %{"id" => "x"}} =
               Management.get_organization_member_effective_role_group_sources(
                 "id|1/a b",
                 "auth0|123/4",
                 %{"from" => "v1"},
                 config(bypass)
               )
    end

    test "returns an error tuple on 4xx", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        Plug.Conn.resp(conn, 404, "{\"statusCode\":404}")
      end)

      assert {:error, 404, _} =
               Management.get_organization_member_effective_role_group_sources(
                 "id|1/a b",
                 "auth0|123/4",
                 %{"from" => "v1"},
                 config(bypass)
               )
    end
  end

  describe "get_organization_role_members (A-154 GET /api/v2/organizations/{id}/roles/{role_id}/members)" do
    test "sends the request and returns the decoded response", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        assert conn.method == "GET"

        assert conn.request_path ==
                 "/api/v2/organizations/id%7C1%2Fa%20b/roles/rol%7C1%2F2/members"

        assert conn.query_string =~ "from=v1"
        Plug.Conn.resp(conn, 200, "{\"id\":\"x\"}")
      end)

      assert {:ok, %{"id" => "x"}} =
               Management.get_organization_role_members(
                 "id|1/a b",
                 "rol|1/2",
                 %{"from" => "v1"},
                 config(bypass)
               )
    end

    test "returns an error tuple on 4xx", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        Plug.Conn.resp(conn, 404, "{\"statusCode\":404}")
      end)

      assert {:error, 404, _} =
               Management.get_organization_role_members(
                 "id|1/a b",
                 "rol|1/2",
                 %{"from" => "v1"},
                 config(bypass)
               )
    end
  end

  describe "get_organization_groups (A-155 GET /api/v2/organizations/{organization_id}/groups)" do
    test "sends the request and returns the decoded response", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        assert conn.method == "GET"
        assert conn.request_path == "/api/v2/organizations/org%7C1%2F2/groups"
        assert conn.query_string =~ "from=v1"
        Plug.Conn.resp(conn, 200, "{\"id\":\"x\"}")
      end)

      assert {:ok, %{"id" => "x"}} =
               Management.get_organization_groups("org|1/2", %{"from" => "v1"}, config(bypass))
    end

    test "returns an error tuple on 4xx", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        Plug.Conn.resp(conn, 404, "{\"statusCode\":404}")
      end)

      assert {:error, 404, _} =
               Management.get_organization_groups("org|1/2", %{"from" => "v1"}, config(bypass))
    end
  end

  describe "get_organization_group_roles (A-156 GET /api/v2/organizations/{organization_id}/groups/{group_id}/roles)" do
    test "sends the request and returns the decoded response", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        assert conn.method == "GET"
        assert conn.request_path == "/api/v2/organizations/org%7C1%2F2/groups/grp%7C1%2F2/roles"
        assert conn.query_string =~ "from=v1"
        Plug.Conn.resp(conn, 200, "{\"id\":\"x\"}")
      end)

      assert {:ok, %{"id" => "x"}} =
               Management.get_organization_group_roles(
                 "org|1/2",
                 "grp|1/2",
                 %{"from" => "v1"},
                 config(bypass)
               )
    end

    test "returns an error tuple on 4xx", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        Plug.Conn.resp(conn, 404, "{\"statusCode\":404}")
      end)

      assert {:error, 404, _} =
               Management.get_organization_group_roles(
                 "org|1/2",
                 "grp|1/2",
                 %{"from" => "v1"},
                 config(bypass)
               )
    end
  end

  describe "assign_organization_group_roles (A-157 POST /api/v2/organizations/{organization_id}/groups/{group_id}/roles)" do
    test "sends the request and returns the decoded response", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        assert conn.method == "POST"
        assert conn.request_path == "/api/v2/organizations/org%7C1%2F2/groups/grp%7C1%2F2/roles"
        {:ok, raw, conn} = Plug.Conn.read_body(conn)
        assert Jason.decode!(raw) == %{"name" => "test"}
        Plug.Conn.resp(conn, 204, "")
      end)

      assert {:ok, ""} =
               Management.assign_organization_group_roles(
                 "org|1/2",
                 "grp|1/2",
                 %{"name" => "test"},
                 config(bypass)
               )
    end

    test "returns an error tuple on 4xx", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        Plug.Conn.resp(conn, 404, "{\"statusCode\":404}")
      end)

      assert {:error, 404, _} =
               Management.assign_organization_group_roles(
                 "org|1/2",
                 "grp|1/2",
                 %{"name" => "test"},
                 config(bypass)
               )
    end
  end

  describe "remove_organization_group_roles (A-158 DELETE /api/v2/organizations/{organization_id}/groups/{group_id}/roles)" do
    test "sends the request and returns the decoded response", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        assert conn.method == "DELETE"
        assert conn.request_path == "/api/v2/organizations/org%7C1%2F2/groups/grp%7C1%2F2/roles"
        {:ok, raw, conn} = Plug.Conn.read_body(conn)
        assert Jason.decode!(raw) == %{"name" => "test"}
        Plug.Conn.resp(conn, 204, "")
      end)

      assert {:ok, ""} =
               Management.remove_organization_group_roles(
                 "org|1/2",
                 "grp|1/2",
                 %{"name" => "test"},
                 config(bypass)
               )
    end

    test "returns an error tuple on 4xx", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        Plug.Conn.resp(conn, 404, "{\"statusCode\":404}")
      end)

      assert {:error, 404, _} =
               Management.remove_organization_group_roles(
                 "org|1/2",
                 "grp|1/2",
                 %{"name" => "test"},
                 config(bypass)
               )
    end
  end

  describe "get_organization_role_groups (A-159 GET /api/v2/organizations/{organization_id}/roles/{role_id}/groups)" do
    test "sends the request and returns the decoded response", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        assert conn.method == "GET"
        assert conn.request_path == "/api/v2/organizations/org%7C1%2F2/roles/rol%7C1%2F2/groups"
        assert conn.query_string =~ "from=v1"
        Plug.Conn.resp(conn, 200, "{\"id\":\"x\"}")
      end)

      assert {:ok, %{"id" => "x"}} =
               Management.get_organization_role_groups(
                 "org|1/2",
                 "rol|1/2",
                 %{"from" => "v1"},
                 config(bypass)
               )
    end

    test "returns an error tuple on 4xx", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        Plug.Conn.resp(conn, 404, "{\"statusCode\":404}")
      end)

      assert {:error, 404, _} =
               Management.get_organization_role_groups(
                 "org|1/2",
                 "rol|1/2",
                 %{"from" => "v1"},
                 config(bypass)
               )
    end
  end

  describe "create_organization_invitation with the auth0-custom-domain header (A-010)" do
    test "sends the header when :custom_domain is given", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        assert conn.method == "POST"
        assert conn.request_path == "/api/v2/organizations/org_1/invitations"
        assert Plug.Conn.get_req_header(conn, "auth0-custom-domain") == ["login.example.com"]
        Plug.Conn.resp(conn, 200, "{\"id\":\"x\"}")
      end)

      assert {:ok, _} =
               Management.create_organization_invitation(
                 "org_1",
                 %{"client_id" => "c"},
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
               Management.create_organization_invitation(
                 "org_1",
                 %{"client_id" => "c"},
                 config(bypass)
               )
    end

    test "rejects a value that is not a host name", %{bypass: bypass} do
      assert_raise ArgumentError, fn ->
        Management.create_organization_invitation("org_1", %{"client_id" => "c"}, config(bypass),
          custom_domain: "evil.example.com\r\nx-injected: 1"
        )
      end
    end
  end

  describe "delete_organization_invitation (C-016)" do
    test "returns an empty string on 204 like the other DELETE functions", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        assert conn.method == "DELETE"
        assert conn.request_path == "/api/v2/organizations/org_1/invitations/uinv_1"
        Plug.Conn.resp(conn, 204, "")
      end)

      assert {:ok, ""} =
               Management.delete_organization_invitation("org_1", "uinv_1", config(bypass))
    end

    test "returns an error tuple on 4xx", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn -> Plug.Conn.resp(conn, 404, "{}") end)

      assert {:error, 404, _} =
               Management.delete_organization_invitation("org_1", "uinv_1", config(bypass))
    end
  end
end
