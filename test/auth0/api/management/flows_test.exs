defmodule Auth0.Api.Management.FlowsTest do
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

  describe "get_flows_vault_connections (A-097 GET /api/v2/flows/vault/connections)" do
    test "sends the request and returns the decoded response", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        assert conn.method == "GET"
        assert conn.request_path == "/api/v2/flows/vault/connections"
        assert conn.query_string =~ "page=v1"
        Plug.Conn.resp(conn, 200, "{\"id\":\"x\"}")
      end)

      assert {:ok, %{"id" => "x"}} =
               Management.get_flows_vault_connections(%{"page" => "v1"}, config(bypass))
    end

    test "returns an error tuple on 4xx", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        Plug.Conn.resp(conn, 404, "{\"statusCode\":404}")
      end)

      assert {:error, 404, _} =
               Management.get_flows_vault_connections(%{"page" => "v1"}, config(bypass))
    end
  end

  describe "create_flows_vault_connection (A-098 POST /api/v2/flows/vault/connections)" do
    test "sends the request and returns the decoded response", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        assert conn.method == "POST"
        assert conn.request_path == "/api/v2/flows/vault/connections"
        {:ok, raw, conn} = Plug.Conn.read_body(conn)
        assert Jason.decode!(raw) == %{"name" => "test"}
        Plug.Conn.resp(conn, 201, "{\"id\":\"x\"}")
      end)

      assert {:ok, %{"id" => "x"}} =
               Management.create_flows_vault_connection(%{"name" => "test"}, config(bypass))
    end

    test "returns an error tuple on 4xx", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        Plug.Conn.resp(conn, 404, "{\"statusCode\":404}")
      end)

      assert {:error, 404, _} =
               Management.create_flows_vault_connection(%{"name" => "test"}, config(bypass))
    end
  end

  describe "get_flows_vault_connection (A-099 GET /api/v2/flows/vault/connections/{id})" do
    test "sends the request and returns the decoded response", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        assert conn.method == "GET"
        assert conn.request_path == "/api/v2/flows/vault/connections/id%7C1%2Fa%20b"
        Plug.Conn.resp(conn, 200, "{\"id\":\"x\"}")
      end)

      assert {:ok, %{"id" => "x"}} =
               Management.get_flows_vault_connection("id|1/a b", config(bypass))
    end

    test "returns an error tuple on 4xx", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        Plug.Conn.resp(conn, 404, "{\"statusCode\":404}")
      end)

      assert {:error, 404, _} = Management.get_flows_vault_connection("id|1/a b", config(bypass))
    end
  end

  describe "update_flows_vault_connection (A-100 PATCH /api/v2/flows/vault/connections/{id})" do
    test "sends the request and returns the decoded response", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        assert conn.method == "PATCH"
        assert conn.request_path == "/api/v2/flows/vault/connections/id%7C1%2Fa%20b"
        {:ok, raw, conn} = Plug.Conn.read_body(conn)
        assert Jason.decode!(raw) == %{"name" => "test"}
        Plug.Conn.resp(conn, 200, "{\"id\":\"x\"}")
      end)

      assert {:ok, %{"id" => "x"}} =
               Management.update_flows_vault_connection(
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
               Management.update_flows_vault_connection(
                 "id|1/a b",
                 %{"name" => "test"},
                 config(bypass)
               )
    end
  end

  describe "delete_flows_vault_connection (A-101 DELETE /api/v2/flows/vault/connections/{id})" do
    test "sends the request and returns an empty body", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        assert conn.method == "DELETE"
        assert conn.request_path == "/api/v2/flows/vault/connections/id%7C1%2Fa%20b"
        Plug.Conn.resp(conn, 204, "")
      end)

      assert {:ok, ""} = Management.delete_flows_vault_connection("id|1/a b", config(bypass))
    end

    test "returns an error tuple on 4xx", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        Plug.Conn.resp(conn, 404, "{\"statusCode\":404}")
      end)

      assert {:error, 404, _} =
               Management.delete_flows_vault_connection("id|1/a b", config(bypass))
    end
  end

  describe "get_flow_executions (A-102 GET /api/v2/flows/{flow_id}/executions)" do
    test "sends the request and returns the decoded response", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        assert conn.method == "GET"
        assert conn.request_path == "/api/v2/flows/af_1%2F2/executions"
        assert conn.query_string =~ "page=v1"
        Plug.Conn.resp(conn, 200, "{\"id\":\"x\"}")
      end)

      assert {:ok, %{"id" => "x"}} =
               Management.get_flow_executions("af_1/2", %{"page" => "v1"}, config(bypass))
    end

    test "returns an error tuple on 4xx", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        Plug.Conn.resp(conn, 404, "{\"statusCode\":404}")
      end)

      assert {:error, 404, _} =
               Management.get_flow_executions("af_1/2", %{"page" => "v1"}, config(bypass))
    end
  end

  describe "get_flow_execution (A-103 GET /api/v2/flows/{flow_id}/executions/{execution_id})" do
    test "sends the request and returns the decoded response", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        assert conn.method == "GET"
        assert conn.request_path == "/api/v2/flows/af_1%2F2/executions/ex%7C1"
        assert conn.query_string =~ "hydrate=x&hydrate=y"
        Plug.Conn.resp(conn, 200, "{\"id\":\"x\"}")
      end)

      assert {:ok, %{"id" => "x"}} =
               Management.get_flow_execution(
                 "af_1/2",
                 "ex|1",
                 %{"hydrate" => ["x", "y"]},
                 config(bypass)
               )
    end

    test "returns an error tuple on 4xx", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        Plug.Conn.resp(conn, 404, "{\"statusCode\":404}")
      end)

      assert {:error, 404, _} =
               Management.get_flow_execution(
                 "af_1/2",
                 "ex|1",
                 %{"hydrate" => ["x", "y"]},
                 config(bypass)
               )
    end
  end

  describe "delete_flow_execution (A-104 DELETE /api/v2/flows/{flow_id}/executions/{execution_id})" do
    test "sends the request and returns an empty body", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        assert conn.method == "DELETE"
        assert conn.request_path == "/api/v2/flows/af_1%2F2/executions/ex%7C1"
        Plug.Conn.resp(conn, 204, "")
      end)

      assert {:ok, ""} = Management.delete_flow_execution("af_1/2", "ex|1", config(bypass))
    end

    test "returns an error tuple on 4xx", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        Plug.Conn.resp(conn, 404, "{\"statusCode\":404}")
      end)

      assert {:error, 404, _} = Management.delete_flow_execution("af_1/2", "ex|1", config(bypass))
    end
  end

  describe "delete_flow (A-105 DELETE /api/v2/flows/{id})" do
    test "sends the request and returns an empty body", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        assert conn.method == "DELETE"
        assert conn.request_path == "/api/v2/flows/id%7C1%2Fa%20b"
        Plug.Conn.resp(conn, 204, "")
      end)

      assert {:ok, ""} = Management.delete_flow("id|1/a b", config(bypass))
    end

    test "returns an error tuple on 4xx", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        Plug.Conn.resp(conn, 404, "{\"statusCode\":404}")
      end)

      assert {:error, 404, _} = Management.delete_flow("id|1/a b", config(bypass))
    end
  end

  describe "get_flows (A-193 array query parameter `hydrate`)" do
    test "sends a list as repeated keys", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        assert conn.method == "GET"
        assert conn.request_path == "/api/v2/flows"
        assert conn.query_string == "hydrate=a&hydrate=b"
        Plug.Conn.resp(conn, 200, "[]")
      end)

      assert {:ok, _} = Management.get_flows(%{hydrate: ["a", "b"]}, config(bypass))
    end

    test "still sends a scalar value as a single key", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        assert conn.query_string == "hydrate=a"
        Plug.Conn.resp(conn, 200, "[]")
      end)

      assert {:ok, _} = Management.get_flows(%{hydrate: "a"}, config(bypass))
    end
  end

  describe "get_flow (A-194 array query parameter `hydrate`)" do
    test "sends a list as repeated keys", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        assert conn.method == "GET"
        assert conn.request_path == "/api/v2/flows/af_1"
        assert conn.query_string == "hydrate=a&hydrate=b"
        Plug.Conn.resp(conn, 200, "[]")
      end)

      assert {:ok, _} = Management.get_flow("af_1", %{hydrate: ["a", "b"]}, config(bypass))
    end

    test "still sends a scalar value as a single key", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        assert conn.query_string == "hydrate=a"
        Plug.Conn.resp(conn, 200, "[]")
      end)

      assert {:ok, _} = Management.get_flow("af_1", %{hydrate: "a"}, config(bypass))
    end
  end
end
