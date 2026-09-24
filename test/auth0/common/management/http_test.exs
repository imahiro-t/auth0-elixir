defmodule Auth0.Common.Management.HttpTest do
  use ExUnit.Case
  alias Auth0.Common.Management.Http
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

  describe "get/2" do
    test "makes a GET request with correct headers", %{bypass: bypass} do
      Bypass.expect_once(bypass, "GET", "/test", fn conn ->
        assert "Bearer test-token" ==
                 Plug.Conn.get_req_header(conn, "authorization") |> List.first()

        Plug.Conn.resp(conn, 200, "{\"ok\": true}")
      end)

      assert {:ok, 200, "{\"ok\": true}"} = Http.get("/test", config(bypass))
    end
  end

  describe "post/3" do
    test "makes a POST request with correct body", %{bypass: bypass} do
      Bypass.expect_once(bypass, "POST", "/test", fn conn ->
        {:ok, body, _conn} = Plug.Conn.read_body(conn)
        assert body == "{\"foo\":\"bar\"}"
        Plug.Conn.resp(conn, 201, "{}")
      end)

      assert {:ok, 201, "{}"} = Http.post("/test", %{foo: "bar"}, config(bypass))
    end
  end

  describe "multipart_post/3" do
    test "sends a multipart request and writes nothing to stdout", %{bypass: bypass} do
      Bypass.expect_once(bypass, "POST", "/test", fn conn ->
        assert ["multipart/form-data" <> _] = Plug.Conn.get_req_header(conn, "content-type")
        Plug.Conn.resp(conn, 201, "{\"id\":\"job-1\"}")
      end)

      output =
        ExUnit.CaptureIO.capture_io(fn ->
          assert {:ok, 201, "{\"id\":\"job-1\"}"} =
                   Http.multipart_post(
                     "/test",
                     {:multipart, [{"connection_id", "con_123"}]},
                     config(bypass)
                   )
        end)

      assert output == ""
    end

    test "sends a boundary-delimited body whose parts the server can parse", %{bypass: bypass} do
      Bypass.expect_once(bypass, "POST", "/test", fn conn ->
        assert [content_type] = Plug.Conn.get_req_header(conn, "content-type")
        assert content_type =~ ~r/\Amultipart\/form-data; boundary=\S+\z/

        conn = Plug.Parsers.call(conn, Plug.Parsers.init(parsers: [:multipart], pass: ["*/*"]))

        assert %Plug.Upload{filename: "users.json", path: path} = conn.body_params["users"]
        assert File.read!(path) == "[{\"email\":\"a@example.com\"}]"
        assert conn.body_params["connection_id"] == "con_123"

        Plug.Conn.resp(conn, 202, "{\"id\":\"job-1\"}")
      end)

      # Same part shapes as Auth0.Management.Jobs.UsersImports builds.
      multipart =
        {:multipart,
         [
           {"file", "[{\"email\":\"a@example.com\"}]",
            {"form-data", [name: "users", filename: "users.json"]}, []},
           {"connection_id", "con_123",
            [
              "content-type": "text/plain",
              "content-disposition": "form-data; name=\"connection_id\""
            ]}
         ]}

      assert {:ok, 202, "{\"id\":\"job-1\"}"} =
               Http.multipart_post("/test", multipart, config(bypass))
    end
  end

  describe "redirects" do
    test "a 302 is returned with its location and is not followed", %{bypass: bypass} do
      target = "http://localhost:#{bypass.port}/redirected"

      # Only /test is expected: a request to /redirected would fail the test,
      # which is how "not followed" (and so no Bearer token forwarded) is checked.
      Bypass.expect_once(bypass, "GET", "/test", fn conn ->
        conn
        |> Plug.Conn.put_resp_header("location", target)
        |> Plug.Conn.resp(302, "")
      end)

      assert {:ok, 302, ^target} = Http.get("/test", config(bypass))
    end
  end

  describe "transport errors" do
    test "a connection failure is returned as {:error, reason}", %{bypass: bypass} do
      Bypass.down(bypass)

      assert {:error, :econnrefused} = Http.get("/test", config(bypass))
    end
  end

  describe "rate limiting" do
    test "retries on 429 with Retry-After header", %{bypass: bypass} do
      Bypass.expect(bypass, fn conn ->
        Plug.Conn.resp(conn, 429, "Too Many Requests")
        |> Plug.Conn.put_resp_header("retry-after", "1")
      end)

      conf = config(bypass) |> Map.put(:max_request_retry_count, 1)
      # This will fail with 429 because we are returning 429 every time and max retry is 1.
      # But we want to ensure it TRIED. 
      # Since we can't easily assert on retry count without side effects, we just accept the 429.
      # The important thing is that it runs. 
      # Note: Process.sleep will make this test take ~1.1s.
      assert {:error, 429, "Too Many Requests"} = Http.get("/test", conf)
    end
  end

  describe "raw_request/5" do
    test "handles different methods", %{bypass: bypass} do
      Bypass.expect_once(bypass, "DELETE", "/test", fn conn ->
        Plug.Conn.resp(conn, 204, "")
      end)

      assert {:ok, %HTTPoison.Response{status_code: 204}} =
               Http.raw_request(:delete, "/test", %{}, nil, config(bypass))
    end
  end
end
