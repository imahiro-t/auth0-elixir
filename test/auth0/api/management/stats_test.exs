defmodule Auth0.Api.Management.StatsTest do
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

  describe "get_daily_stats with query parameters (A-012)" do
    test "(params) sends the query with the default config", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        assert conn.request_path == "/api/v2/stats/daily"
        assert conn.query_string == "from=v1"
        Plug.Conn.resp(conn, 200, "[]")
      end)

      assert {:ok, []} = Management.get_daily_stats(%{from: "v1"}, config(bypass))
    end

    test "(config) keeps working without a query string", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        assert conn.request_path == "/api/v2/stats/daily"
        assert conn.query_string == ""
        Plug.Conn.resp(conn, 200, "[]")
      end)

      assert {:ok, []} = Management.get_daily_stats(config(bypass))
    end

    test "returns an error tuple on 4xx", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn -> Plug.Conn.resp(conn, 403, "{}") end)
      assert {:error, 403, _} = Management.get_daily_stats(%{from: "v1"}, config(bypass))
    end
  end
end
