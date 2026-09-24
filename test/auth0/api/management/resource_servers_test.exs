defmodule Auth0.Api.Management.ResourceServersTest do
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

  describe "search_resource_servers (A-170 GET /api/v2/resource-servers/search)" do
    test "sends the request and returns the decoded response", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        assert conn.method == "GET"
        assert conn.request_path == "/api/v2/resource-servers/search"
        assert conn.query_string =~ "q=v1"
        Plug.Conn.resp(conn, 200, "{\"id\":\"x\"}")
      end)

      assert {:ok, %{"id" => "x"}} =
               Management.search_resource_servers(%{"q" => "v1"}, config(bypass))
    end

    test "returns an error tuple on 4xx", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        Plug.Conn.resp(conn, 404, "{\"statusCode\":404}")
      end)

      assert {:error, 404, _} = Management.search_resource_servers(%{"q" => "v1"}, config(bypass))
    end
  end

  describe "get_resource_servers (A-197 array query parameter `identifiers`)" do
    test "sends a list as repeated keys", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        assert conn.method == "GET"
        assert conn.request_path == "/api/v2/resource-servers"
        assert conn.query_string == "identifiers=a&identifiers=b"
        Plug.Conn.resp(conn, 200, "[]")
      end)

      assert {:ok, _} =
               Management.get_resource_servers(%{identifiers: ["a", "b"]}, config(bypass))
    end

    test "still sends a scalar value as a single key", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        assert conn.query_string == "identifiers=a"
        Plug.Conn.resp(conn, 200, "[]")
      end)

      assert {:ok, _} = Management.get_resource_servers(%{identifiers: "a"}, config(bypass))
    end
  end
end
