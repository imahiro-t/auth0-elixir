defmodule Auth0.Api.Management.EventStreamsTest do
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

  describe "get_event_stream_deliveries (A-067 GET /api/v2/event-streams/{id}/deliveries)" do
    test "sends the request and returns the decoded response", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        assert conn.method == "GET"
        assert conn.request_path == "/api/v2/event-streams/id%7C1%2Fa%20b/deliveries"
        assert conn.query_string =~ "statuses=v1"
        Plug.Conn.resp(conn, 200, "{\"id\":\"x\"}")
      end)

      assert {:ok, %{"id" => "x"}} =
               Management.get_event_stream_deliveries(
                 "id|1/a b",
                 %{"statuses" => "v1"},
                 config(bypass)
               )
    end

    test "returns an error tuple on 4xx", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        Plug.Conn.resp(conn, 404, "{\"statusCode\":404}")
      end)

      assert {:error, 404, _} =
               Management.get_event_stream_deliveries(
                 "id|1/a b",
                 %{"statuses" => "v1"},
                 config(bypass)
               )
    end
  end

  describe "get_event_stream_delivery (A-068 GET /api/v2/event-streams/{id}/deliveries/{event_id})" do
    test "sends the request and returns the decoded response", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        assert conn.method == "GET"
        assert conn.request_path == "/api/v2/event-streams/id%7C1%2Fa%20b/deliveries/evt%7C1%2F2"
        Plug.Conn.resp(conn, 200, "{\"id\":\"x\"}")
      end)

      assert {:ok, %{"id" => "x"}} =
               Management.get_event_stream_delivery("id|1/a b", "evt|1/2", config(bypass))
    end

    test "returns an error tuple on 4xx", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        Plug.Conn.resp(conn, 404, "{\"statusCode\":404}")
      end)

      assert {:error, 404, _} =
               Management.get_event_stream_delivery("id|1/a b", "evt|1/2", config(bypass))
    end
  end

  describe "redeliver_event_stream_events (A-069 POST /api/v2/event-streams/{id}/redeliver)" do
    test "sends the request and returns the decoded response", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        assert conn.method == "POST"
        assert conn.request_path == "/api/v2/event-streams/id%7C1%2Fa%20b/redeliver"
        {:ok, raw, conn} = Plug.Conn.read_body(conn)
        assert Jason.decode!(raw) == %{"name" => "test"}
        Plug.Conn.resp(conn, 202, "{\"id\":\"x\"}")
      end)

      assert {:ok, %{"id" => "x"}} =
               Management.redeliver_event_stream_events(
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
               Management.redeliver_event_stream_events(
                 "id|1/a b",
                 %{"name" => "test"},
                 config(bypass)
               )
    end
  end

  describe "redeliver_event_stream_event (A-070 POST /api/v2/event-streams/{id}/redeliver/{event_id})" do
    test "sends the request and returns the decoded response", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        assert conn.method == "POST"
        assert conn.request_path == "/api/v2/event-streams/id%7C1%2Fa%20b/redeliver/evt%7C1%2F2"
        Plug.Conn.resp(conn, 202, "")
      end)

      assert {:ok, ""} =
               Management.redeliver_event_stream_event("id|1/a b", "evt|1/2", config(bypass))
    end

    test "returns an error tuple on 4xx", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        Plug.Conn.resp(conn, 404, "{\"statusCode\":404}")
      end)

      assert {:error, 404, _} =
               Management.redeliver_event_stream_event("id|1/a b", "evt|1/2", config(bypass))
    end
  end

  describe "test_event_stream (A-071 POST /api/v2/event-streams/{id}/test)" do
    test "sends the request and returns the decoded response", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        assert conn.method == "POST"
        assert conn.request_path == "/api/v2/event-streams/id%7C1%2Fa%20b/test"
        {:ok, raw, conn} = Plug.Conn.read_body(conn)
        assert Jason.decode!(raw) == %{"name" => "test"}
        Plug.Conn.resp(conn, 202, "{\"id\":\"x\"}")
      end)

      assert {:ok, %{"id" => "x"}} =
               Management.test_event_stream("id|1/a b", %{"name" => "test"}, config(bypass))
    end

    test "returns an error tuple on 4xx", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        Plug.Conn.resp(conn, 404, "{\"statusCode\":404}")
      end)

      assert {:error, 404, _} =
               Management.test_event_stream("id|1/a b", %{"name" => "test"}, config(bypass))
    end
  end
end
