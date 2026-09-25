defmodule Auth0.Api.Management.ConnectionsTest do
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

  describe "get_connections_directory_provisionings (A-046 GET /api/v2/connections-directory-provisionings)" do
    test "sends the request and returns the decoded response", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        assert conn.method == "GET"
        assert conn.request_path == "/api/v2/connections-directory-provisionings"
        assert conn.query_string =~ "from=v1"
        Plug.Conn.resp(conn, 200, "{\"id\":\"x\"}")
      end)

      assert {:ok, %{"id" => "x"}} =
               Management.get_connections_directory_provisionings(
                 %{"from" => "v1"},
                 config(bypass)
               )
    end

    test "returns an error tuple on 4xx", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        Plug.Conn.resp(conn, 404, "{\"statusCode\":404}")
      end)

      assert {:error, 404, _} =
               Management.get_connections_directory_provisionings(
                 %{"from" => "v1"},
                 config(bypass)
               )
    end
  end

  describe "get_connections_scim_configurations (A-047 GET /api/v2/connections-scim-configurations)" do
    test "sends the request and returns the decoded response", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        assert conn.method == "GET"
        assert conn.request_path == "/api/v2/connections-scim-configurations"
        assert conn.query_string =~ "from=v1"
        Plug.Conn.resp(conn, 200, "{\"id\":\"x\"}")
      end)

      assert {:ok, %{"id" => "x"}} =
               Management.get_connections_scim_configurations(%{"from" => "v1"}, config(bypass))
    end

    test "returns an error tuple on 4xx", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        Plug.Conn.resp(conn, 404, "{\"statusCode\":404}")
      end)

      assert {:error, 404, _} =
               Management.get_connections_scim_configurations(%{"from" => "v1"}, config(bypass))
    end
  end

  describe "get_connection_clients (A-048 GET /api/v2/connections/{id}/clients)" do
    test "sends the request and returns the decoded response", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        assert conn.method == "GET"
        assert conn.request_path == "/api/v2/connections/id%7C1%2Fa%20b/clients"
        assert conn.query_string =~ "take=v1"
        Plug.Conn.resp(conn, 200, "{\"id\":\"x\"}")
      end)

      assert {:ok, %{"id" => "x"}} =
               Management.get_connection_clients("id|1/a b", %{"take" => "v1"}, config(bypass))
    end

    test "returns an error tuple on 4xx", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        Plug.Conn.resp(conn, 404, "{\"statusCode\":404}")
      end)

      assert {:error, 404, _} =
               Management.get_connection_clients("id|1/a b", %{"take" => "v1"}, config(bypass))
    end
  end

  describe "update_connection_clients (A-049 PATCH /api/v2/connections/{id}/clients)" do
    test "sends the request and returns an empty body", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        assert conn.method == "PATCH"
        assert conn.request_path == "/api/v2/connections/id%7C1%2Fa%20b/clients"
        {:ok, raw, conn} = Plug.Conn.read_body(conn)
        assert Jason.decode!(raw) == [%{"client_id" => "c1", "status" => true}]
        Plug.Conn.resp(conn, 204, "")
      end)

      assert {:ok, ""} =
               Management.update_connection_clients(
                 "id|1/a b",
                 [%{"client_id" => "c1", "status" => true}],
                 config(bypass)
               )
    end

    test "returns an error tuple on 4xx", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        Plug.Conn.resp(conn, 404, "{\"statusCode\":404}")
      end)

      assert {:error, 404, _} =
               Management.update_connection_clients(
                 "id|1/a b",
                 [%{"client_id" => "c1", "status" => true}],
                 config(bypass)
               )
    end
  end

  describe "get_connection_directory_provisioning (A-050 GET /api/v2/connections/{id}/directory-provisioning)" do
    test "sends the request and returns the decoded response", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        assert conn.method == "GET"
        assert conn.request_path == "/api/v2/connections/id%7C1%2Fa%20b/directory-provisioning"
        Plug.Conn.resp(conn, 200, "{\"id\":\"x\"}")
      end)

      assert {:ok, %{"id" => "x"}} =
               Management.get_connection_directory_provisioning("id|1/a b", config(bypass))
    end

    test "returns an error tuple on 4xx", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        Plug.Conn.resp(conn, 404, "{\"statusCode\":404}")
      end)

      assert {:error, 404, _} =
               Management.get_connection_directory_provisioning("id|1/a b", config(bypass))
    end
  end

  describe "create_connection_directory_provisioning (A-051 POST /api/v2/connections/{id}/directory-provisioning)" do
    test "sends the request and returns the decoded response", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        assert conn.method == "POST"
        assert conn.request_path == "/api/v2/connections/id%7C1%2Fa%20b/directory-provisioning"
        {:ok, raw, conn} = Plug.Conn.read_body(conn)
        assert Jason.decode!(raw) == %{"name" => "test"}
        Plug.Conn.resp(conn, 201, "{\"id\":\"x\"}")
      end)

      assert {:ok, %{"id" => "x"}} =
               Management.create_connection_directory_provisioning(
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
               Management.create_connection_directory_provisioning(
                 "id|1/a b",
                 %{"name" => "test"},
                 config(bypass)
               )
    end
  end

  describe "update_connection_directory_provisioning (A-052 PATCH /api/v2/connections/{id}/directory-provisioning)" do
    test "sends the request and returns the decoded response", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        assert conn.method == "PATCH"
        assert conn.request_path == "/api/v2/connections/id%7C1%2Fa%20b/directory-provisioning"
        {:ok, raw, conn} = Plug.Conn.read_body(conn)
        assert Jason.decode!(raw) == %{"name" => "test"}
        Plug.Conn.resp(conn, 200, "{\"id\":\"x\"}")
      end)

      assert {:ok, %{"id" => "x"}} =
               Management.update_connection_directory_provisioning(
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
               Management.update_connection_directory_provisioning(
                 "id|1/a b",
                 %{"name" => "test"},
                 config(bypass)
               )
    end
  end

  describe "delete_connection_directory_provisioning (A-053 DELETE /api/v2/connections/{id}/directory-provisioning)" do
    test "sends the request and returns an empty body", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        assert conn.method == "DELETE"
        assert conn.request_path == "/api/v2/connections/id%7C1%2Fa%20b/directory-provisioning"
        Plug.Conn.resp(conn, 204, "")
      end)

      assert {:ok, ""} =
               Management.delete_connection_directory_provisioning("id|1/a b", config(bypass))
    end

    test "returns an error tuple on 4xx", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        Plug.Conn.resp(conn, 404, "{\"statusCode\":404}")
      end)

      assert {:error, 404, _} =
               Management.delete_connection_directory_provisioning("id|1/a b", config(bypass))
    end
  end

  describe "get_connection_directory_provisioning_default_mapping (A-054 GET /api/v2/connections/{id}/directory-provisioning/default-mapping)" do
    test "sends the request and returns the decoded response", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        assert conn.method == "GET"

        assert conn.request_path ==
                 "/api/v2/connections/id%7C1%2Fa%20b/directory-provisioning/default-mapping"

        Plug.Conn.resp(conn, 200, "{\"id\":\"x\"}")
      end)

      assert {:ok, %{"id" => "x"}} =
               Management.get_connection_directory_provisioning_default_mapping(
                 "id|1/a b",
                 config(bypass)
               )
    end

    test "returns an error tuple on 4xx", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        Plug.Conn.resp(conn, 404, "{\"statusCode\":404}")
      end)

      assert {:error, 404, _} =
               Management.get_connection_directory_provisioning_default_mapping(
                 "id|1/a b",
                 config(bypass)
               )
    end
  end

  describe "create_connection_directory_provisioning_synchronization (A-055 POST /api/v2/connections/{id}/directory-provisioning/synchronizations)" do
    test "sends the request and returns the decoded response", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        assert conn.method == "POST"

        assert conn.request_path ==
                 "/api/v2/connections/id%7C1%2Fa%20b/directory-provisioning/synchronizations"

        Plug.Conn.resp(conn, 201, "{\"id\":\"x\"}")
      end)

      assert {:ok, %{"id" => "x"}} =
               Management.create_connection_directory_provisioning_synchronization(
                 "id|1/a b",
                 config(bypass)
               )
    end

    test "returns an error tuple on 4xx", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        Plug.Conn.resp(conn, 404, "{\"statusCode\":404}")
      end)

      assert {:error, 404, _} =
               Management.create_connection_directory_provisioning_synchronization(
                 "id|1/a b",
                 config(bypass)
               )
    end
  end

  describe "get_connection_directory_provisioning_synchronized_groups (A-056 GET /api/v2/connections/{id}/directory-provisioning/synchronized-groups)" do
    test "sends the request and returns the decoded response", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        assert conn.method == "GET"

        assert conn.request_path ==
                 "/api/v2/connections/id%7C1%2Fa%20b/directory-provisioning/synchronized-groups"

        assert conn.query_string =~ "from=v1"
        Plug.Conn.resp(conn, 200, "{\"id\":\"x\"}")
      end)

      assert {:ok, %{"id" => "x"}} =
               Management.get_connection_directory_provisioning_synchronized_groups(
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
               Management.get_connection_directory_provisioning_synchronized_groups(
                 "id|1/a b",
                 %{"from" => "v1"},
                 config(bypass)
               )
    end
  end

  describe "add_connection_directory_provisioning_synchronized_groups (A-057 POST /api/v2/connections/{id}/directory-provisioning/synchronized-groups)" do
    test "sends the request and returns an empty body", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        assert conn.method == "POST"

        assert conn.request_path ==
                 "/api/v2/connections/id%7C1%2Fa%20b/directory-provisioning/synchronized-groups"

        {:ok, raw, conn} = Plug.Conn.read_body(conn)
        assert Jason.decode!(raw) == %{"name" => "test"}
        Plug.Conn.resp(conn, 204, "")
      end)

      assert {:ok, ""} =
               Management.add_connection_directory_provisioning_synchronized_groups(
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
               Management.add_connection_directory_provisioning_synchronized_groups(
                 "id|1/a b",
                 %{"name" => "test"},
                 config(bypass)
               )
    end
  end

  describe "set_connection_directory_provisioning_synchronized_groups (A-058 PUT /api/v2/connections/{id}/directory-provisioning/synchronized-groups)" do
    test "sends the request and returns an empty body", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        assert conn.method == "PUT"

        assert conn.request_path ==
                 "/api/v2/connections/id%7C1%2Fa%20b/directory-provisioning/synchronized-groups"

        {:ok, raw, conn} = Plug.Conn.read_body(conn)
        assert Jason.decode!(raw) == %{"name" => "test"}
        Plug.Conn.resp(conn, 204, "")
      end)

      assert {:ok, ""} =
               Management.set_connection_directory_provisioning_synchronized_groups(
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
               Management.set_connection_directory_provisioning_synchronized_groups(
                 "id|1/a b",
                 %{"name" => "test"},
                 config(bypass)
               )
    end
  end

  describe "delete_connection_directory_provisioning_synchronized_groups (A-059 DELETE /api/v2/connections/{id}/directory-provisioning/synchronized-groups)" do
    test "sends the request and returns an empty body", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        assert conn.method == "DELETE"

        assert conn.request_path ==
                 "/api/v2/connections/id%7C1%2Fa%20b/directory-provisioning/synchronized-groups"

        {:ok, raw, conn} = Plug.Conn.read_body(conn)
        assert Jason.decode!(raw) == %{"name" => "test"}
        Plug.Conn.resp(conn, 204, "")
      end)

      assert {:ok, ""} =
               Management.delete_connection_directory_provisioning_synchronized_groups(
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
               Management.delete_connection_directory_provisioning_synchronized_groups(
                 "id|1/a b",
                 %{"name" => "test"},
                 config(bypass)
               )
    end
  end

  describe "get_connection_keys (A-060 GET /api/v2/connections/{id}/keys)" do
    test "sends the request and returns the decoded response", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        assert conn.method == "GET"
        assert conn.request_path == "/api/v2/connections/id%7C1%2Fa%20b/keys"
        Plug.Conn.resp(conn, 200, "[{\"id\":\"x\"}]")
      end)

      assert {:ok, [%{"id" => "x"}]} = Management.get_connection_keys("id|1/a b", config(bypass))
    end

    test "returns an error tuple on 4xx", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        Plug.Conn.resp(conn, 404, "{\"statusCode\":404}")
      end)

      assert {:error, 404, _} = Management.get_connection_keys("id|1/a b", config(bypass))
    end
  end

  describe "create_connection_keys (A-061 POST /api/v2/connections/{id}/keys)" do
    test "sends the request and returns the decoded response", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        assert conn.method == "POST"
        assert conn.request_path == "/api/v2/connections/id%7C1%2Fa%20b/keys"
        {:ok, raw, conn} = Plug.Conn.read_body(conn)
        assert Jason.decode!(raw) == %{"name" => "test"}
        Plug.Conn.resp(conn, 201, "[{\"id\":\"x\"}]")
      end)

      assert {:ok, [%{"id" => "x"}]} =
               Management.create_connection_keys("id|1/a b", %{"name" => "test"}, config(bypass))
    end

    test "returns an error tuple on 4xx", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        Plug.Conn.resp(conn, 404, "{\"statusCode\":404}")
      end)

      assert {:error, 404, _} =
               Management.create_connection_keys("id|1/a b", %{"name" => "test"}, config(bypass))
    end
  end

  describe "rotate_connection_keys (A-062 POST /api/v2/connections/{id}/keys/rotate)" do
    test "sends the request and returns the decoded response", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        assert conn.method == "POST"
        assert conn.request_path == "/api/v2/connections/id%7C1%2Fa%20b/keys/rotate"
        {:ok, raw, conn} = Plug.Conn.read_body(conn)
        assert Jason.decode!(raw) == %{"name" => "test"}
        Plug.Conn.resp(conn, 201, "{\"id\":\"x\"}")
      end)

      assert {:ok, %{"id" => "x"}} =
               Management.rotate_connection_keys("id|1/a b", %{"name" => "test"}, config(bypass))
    end

    test "returns an error tuple on 4xx", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        Plug.Conn.resp(conn, 404, "{\"statusCode\":404}")
      end)

      assert {:error, 404, _} =
               Management.rotate_connection_keys("id|1/a b", %{"name" => "test"}, config(bypass))
    end
  end

  describe "get_connections (A-192 array query parameter `strategy`)" do
    test "sends a list as repeated keys", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        assert conn.method == "GET"
        assert conn.request_path == "/api/v2/connections"
        assert conn.query_string == "strategy=a&strategy=b"
        Plug.Conn.resp(conn, 200, "[]")
      end)

      assert {:ok, _} = Management.get_connections(%{strategy: ["a", "b"]}, config(bypass))
    end

    test "still sends a scalar value as a single key", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        assert conn.query_string == "strategy=a"
        Plug.Conn.resp(conn, 200, "[]")
      end)

      assert {:ok, _} = Management.get_connections(%{strategy: "a"}, config(bypass))
    end
  end

  describe "get_connection_status (C-012)" do
    test "returns {:ok, true} on 200 with an empty body", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        assert conn.method == "GET"
        assert conn.request_path == "/api/v2/connections/con_1/status"
        Plug.Conn.resp(conn, 200, "")
      end)

      assert {:ok, true} = Management.get_connection_status("con_1", config(bypass))
    end

    test "returns {:ok, true} on 200 even if a body is present", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        assert conn.method == "GET"
        assert conn.request_path == "/api/v2/connections/con_1/status"
        Plug.Conn.resp(conn, 200, "{\"id\":\"x\"}")
      end)

      assert {:ok, true} = Management.get_connection_status("con_1", config(bypass))
    end

    test "returns an error tuple on 4xx", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn -> Plug.Conn.resp(conn, 404, "{}") end)
      assert {:error, 404, _} = Management.get_connection_status("con_1", config(bypass))
    end
  end
end
