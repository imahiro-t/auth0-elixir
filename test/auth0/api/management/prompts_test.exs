defmodule Auth0.Api.Management.PromptsTest do
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

  describe "get_prompt_renderings (A-160 GET /api/v2/prompts/rendering)" do
    test "sends the request and returns the decoded response", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        assert conn.method == "GET"
        assert conn.request_path == "/api/v2/prompts/rendering"
        assert conn.query_string =~ "fields=v1"
        Plug.Conn.resp(conn, 200, "{\"id\":\"x\"}")
      end)

      assert {:ok, %{"id" => "x"}} =
               Management.get_prompt_renderings(%{"fields" => "v1"}, config(bypass))
    end

    test "returns an error tuple on 4xx", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        Plug.Conn.resp(conn, 404, "{\"statusCode\":404}")
      end)

      assert {:error, 404, _} =
               Management.get_prompt_renderings(%{"fields" => "v1"}, config(bypass))
    end
  end

  describe "bulk_update_prompt_renderings (A-161 PATCH /api/v2/prompts/rendering)" do
    test "sends the request and returns the decoded response", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        assert conn.method == "PATCH"
        assert conn.request_path == "/api/v2/prompts/rendering"
        {:ok, raw, conn} = Plug.Conn.read_body(conn)
        assert Jason.decode!(raw) == %{"name" => "test"}
        Plug.Conn.resp(conn, 200, "{\"id\":\"x\"}")
      end)

      assert {:ok, %{"id" => "x"}} =
               Management.bulk_update_prompt_renderings(%{"name" => "test"}, config(bypass))
    end

    test "returns an error tuple on 4xx", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        Plug.Conn.resp(conn, 404, "{\"statusCode\":404}")
      end)

      assert {:error, 404, _} =
               Management.bulk_update_prompt_renderings(%{"name" => "test"}, config(bypass))
    end
  end

  describe "get_prompt_rendering (A-003)" do
    test "sends GET /api/v2/prompts/login-id/screen/login-id/rendering", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        assert conn.method == "GET"
        assert conn.request_path == "/api/v2/prompts/login-id/screen/login-id/rendering"
        Plug.Conn.resp(conn, 200, "{\"id\":\"x\"}")
      end)

      assert {:ok, %{"id" => "x"}} =
               Management.get_prompt_rendering("login-id", "login-id", config(bypass))
    end

    test "returns an error tuple on 4xx", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn -> Plug.Conn.resp(conn, 400, "{}") end)

      assert {:error, 400, _} =
               Management.get_prompt_rendering("login-id", "login-id", config(bypass))
    end
  end

  describe "update_prompt_rendering (A-004)" do
    test "sends PATCH /api/v2/prompts/login-id/screen/login-id/rendering", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        assert conn.method == "PATCH"
        assert conn.request_path == "/api/v2/prompts/login-id/screen/login-id/rendering"
        {:ok, raw, conn} = Plug.Conn.read_body(conn)
        assert Jason.decode!(raw) == %{"rendering_mode" => "advanced"}
        Plug.Conn.resp(conn, 200, "{\"id\":\"x\"}")
      end)

      assert {:ok, %{"id" => "x"}} =
               Management.update_prompt_rendering(
                 "login-id",
                 "login-id",
                 %{"rendering_mode" => "advanced"},
                 config(bypass)
               )
    end

    test "returns an error tuple on 4xx", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn -> Plug.Conn.resp(conn, 400, "{}") end)

      assert {:error, 400, _} =
               Management.update_prompt_rendering(
                 "login-id",
                 "login-id",
                 %{"rendering_mode" => "advanced"},
                 config(bypass)
               )
    end
  end
end
