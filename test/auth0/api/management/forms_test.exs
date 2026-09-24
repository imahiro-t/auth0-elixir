defmodule Auth0.Api.Management.FormsTest do
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

  describe "delete_form (A-106 DELETE /api/v2/forms/{id})" do
    test "sends the request and returns the decoded response", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        assert conn.method == "DELETE"
        assert conn.request_path == "/api/v2/forms/id%7C1%2Fa%20b"
        Plug.Conn.resp(conn, 204, "")
      end)

      assert {:ok, ""} = Management.delete_form("id|1/a b", config(bypass))
    end

    test "returns an error tuple on 4xx", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        Plug.Conn.resp(conn, 404, "{\"statusCode\":404}")
      end)

      assert {:error, 404, _} = Management.delete_form("id|1/a b", config(bypass))
    end
  end

  describe "get_forms (A-195 array query parameter `hydrate`)" do
    test "sends a list as repeated keys", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        assert conn.method == "GET"
        assert conn.request_path == "/api/v2/forms"
        assert conn.query_string == "hydrate=a&hydrate=b"
        Plug.Conn.resp(conn, 200, "[]")
      end)

      assert {:ok, _} = Management.get_forms(%{hydrate: ["a", "b"]}, config(bypass))
    end

    test "still sends a scalar value as a single key", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        assert conn.query_string == "hydrate=a"
        Plug.Conn.resp(conn, 200, "[]")
      end)

      assert {:ok, _} = Management.get_forms(%{hydrate: "a"}, config(bypass))
    end
  end

  describe "get_form (A-196 array query parameter `hydrate`)" do
    test "sends a list as repeated keys", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        assert conn.method == "GET"
        assert conn.request_path == "/api/v2/forms/ap_1"
        assert conn.query_string == "hydrate=a&hydrate=b"
        Plug.Conn.resp(conn, 200, "[]")
      end)

      assert {:ok, _} = Management.get_form("ap_1", %{hydrate: ["a", "b"]}, config(bypass))
    end

    test "still sends a scalar value as a single key", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        assert conn.query_string == "hydrate=a"
        Plug.Conn.resp(conn, 200, "[]")
      end)

      assert {:ok, _} = Management.get_form("ap_1", %{hydrate: "a"}, config(bypass))
    end
  end
end
