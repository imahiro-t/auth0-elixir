defmodule Auth0.Api.Management.SupplementalSignalsTest do
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

  describe "get_supplemental_signals (A-181 GET /api/v2/supplemental-signals)" do
    test "sends the request and returns the decoded response", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        assert conn.method == "GET"
        assert conn.request_path == "/api/v2/supplemental-signals"
        Plug.Conn.resp(conn, 200, "{\"id\":\"x\"}")
      end)

      assert {:ok, %{"id" => "x"}} = Management.get_supplemental_signals(config(bypass))
    end

    test "returns an error tuple on 4xx", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        Plug.Conn.resp(conn, 404, "{\"statusCode\":404}")
      end)

      assert {:error, 404, _} = Management.get_supplemental_signals(config(bypass))
    end
  end

  describe "update_supplemental_signals (A-182 PATCH /api/v2/supplemental-signals)" do
    test "sends the request and returns the decoded response", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        assert conn.method == "PATCH"
        assert conn.request_path == "/api/v2/supplemental-signals"
        {:ok, raw, conn} = Plug.Conn.read_body(conn)
        assert Jason.decode!(raw) == %{"name" => "test"}
        Plug.Conn.resp(conn, 200, "{\"id\":\"x\"}")
      end)

      assert {:ok, %{"id" => "x"}} =
               Management.update_supplemental_signals(%{"name" => "test"}, config(bypass))
    end

    test "returns an error tuple on 4xx", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        Plug.Conn.resp(conn, 404, "{\"statusCode\":404}")
      end)

      assert {:error, 404, _} =
               Management.update_supplemental_signals(%{"name" => "test"}, config(bypass))
    end
  end

  describe "create_supplemental_signal (D-010 deprecated, behaviour unchanged)" do
    test "still works as before", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        assert conn.method == "POST"
        assert conn.request_path == "/api/v2/supplemental-signals"
        {:ok, raw, conn} = Plug.Conn.read_body(conn)
        assert Jason.decode!(raw) == %{"a" => 1}
        Plug.Conn.resp(conn, 201, "{\"id\":\"x\"}")
      end)

      assert {:ok, %{"id" => "x"}} =
               Management.create_supplemental_signal(%{"a" => 1}, config(bypass))
    end

    test "returns an error tuple on 4xx", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn -> Plug.Conn.resp(conn, 404, "{}") end)
      assert {:error, 404, _} = Management.create_supplemental_signal(%{"a" => 1}, config(bypass))
    end
  end

  describe "get_supplemental_signal (D-011 deprecated, behaviour unchanged)" do
    test "still works as before", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        assert conn.method == "GET"
        assert conn.request_path == "/api/v2/supplemental-signals/s1"
        Plug.Conn.resp(conn, 200, "{\"id\":\"x\"}")
      end)

      assert {:ok, %{"id" => "x"}} = Management.get_supplemental_signal("s1", config(bypass))
    end

    test "returns an error tuple on 4xx", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn -> Plug.Conn.resp(conn, 404, "{}") end)
      assert {:error, 404, _} = Management.get_supplemental_signal("s1", config(bypass))
    end
  end
end
