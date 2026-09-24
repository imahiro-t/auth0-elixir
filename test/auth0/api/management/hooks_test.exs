defmodule Auth0.Api.Management.HooksTest do
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

  describe "update_hook_secrets (C-001)" do
    test "sends PATCH to /secrets and accepts the empty 201 body", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        assert conn.method == "PATCH"
        assert conn.request_path == "/api/v2/hooks/h1/secrets"
        {:ok, raw, conn} = Plug.Conn.read_body(conn)
        assert Jason.decode!(raw) == %{"S" => "v"}
        Plug.Conn.resp(conn, 201, "")
      end)

      assert {:ok, ""} =
               Management.update_hook_secrets("h1", %{value: %{"S" => "v"}}, config(bypass))
    end

    test "still decodes a JSON body", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        assert conn.method == "PATCH"
        assert conn.request_path == "/api/v2/hooks/h1/secrets"
        Plug.Conn.resp(conn, 201, "{\"id\":\"x\"}")
      end)

      assert {:ok, %{"id" => "x"}} =
               Management.update_hook_secrets("h1", %{value: %{"S" => "v"}}, config(bypass))
    end

    test "returns an error tuple on 4xx", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn -> Plug.Conn.resp(conn, 404, "{}") end)

      assert {:error, 404, _} =
               Management.update_hook_secrets("h1", %{value: %{"S" => "v"}}, config(bypass))
    end
  end

  describe "add_hook_secrets (C-013)" do
    test "accepts the empty 201 body", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        assert conn.method == "POST"
        assert conn.request_path == "/api/v2/hooks/h1/secrets"
        {:ok, raw, conn} = Plug.Conn.read_body(conn)
        assert Jason.decode!(raw) == %{"S" => "v"}
        Plug.Conn.resp(conn, 201, "")
      end)

      assert {:ok, ""} =
               Management.add_hook_secrets("h1", %{value: %{"S" => "v"}}, config(bypass))
    end

    test "still decodes a JSON body", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        assert conn.method == "POST"
        assert conn.request_path == "/api/v2/hooks/h1/secrets"
        Plug.Conn.resp(conn, 201, "{\"id\":\"x\"}")
      end)

      assert {:ok, %{"id" => "x"}} =
               Management.add_hook_secrets("h1", %{value: %{"S" => "v"}}, config(bypass))
    end

    test "returns an error tuple on 4xx", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn -> Plug.Conn.resp(conn, 404, "{}") end)

      assert {:error, 404, _} =
               Management.add_hook_secrets("h1", %{value: %{"S" => "v"}}, config(bypass))
    end
  end

  describe "get_hooks (D-012 deprecated, behaviour unchanged)" do
    test "still works as before", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        assert conn.method == "GET"
        assert conn.request_path == "/api/v2/hooks"
        Plug.Conn.resp(conn, 200, "[]")
      end)

      assert {:ok, []} = Management.get_hooks(%{"enabled" => true}, config(bypass))
    end

    test "returns an error tuple on 4xx", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn -> Plug.Conn.resp(conn, 404, "{}") end)
      assert {:error, 404, _} = Management.get_hooks(%{"enabled" => true}, config(bypass))
    end
  end

  describe "create_hook (D-013 deprecated, behaviour unchanged)" do
    test "still works as before", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        assert conn.method == "POST"
        assert conn.request_path == "/api/v2/hooks"
        {:ok, raw, conn} = Plug.Conn.read_body(conn)
        assert Jason.decode!(raw) == %{"name" => "h"}
        Plug.Conn.resp(conn, 201, "{\"id\":\"x\"}")
      end)

      assert {:ok, %{"id" => "x"}} = Management.create_hook(%{"name" => "h"}, config(bypass))
    end

    test "returns an error tuple on 4xx", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn -> Plug.Conn.resp(conn, 404, "{}") end)
      assert {:error, 404, _} = Management.create_hook(%{"name" => "h"}, config(bypass))
    end
  end

  describe "get_hook (D-014 deprecated, behaviour unchanged)" do
    test "still works as before", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        assert conn.method == "GET"
        assert conn.request_path == "/api/v2/hooks/h1"
        Plug.Conn.resp(conn, 200, "{\"id\":\"x\"}")
      end)

      assert {:ok, %{"id" => "x"}} = Management.get_hook("h1", %{}, config(bypass))
    end

    test "returns an error tuple on 4xx", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn -> Plug.Conn.resp(conn, 404, "{}") end)
      assert {:error, 404, _} = Management.get_hook("h1", %{}, config(bypass))
    end
  end

  describe "delete_hook (D-015 deprecated, behaviour unchanged)" do
    test "still works as before", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        assert conn.method == "DELETE"
        assert conn.request_path == "/api/v2/hooks/h1"
        Plug.Conn.resp(conn, 204, "")
      end)

      assert {:ok, ""} = Management.delete_hook("h1", config(bypass))
    end

    test "returns an error tuple on 4xx", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn -> Plug.Conn.resp(conn, 404, "{}") end)
      assert {:error, 404, _} = Management.delete_hook("h1", config(bypass))
    end
  end

  describe "update_hook (D-016 deprecated, behaviour unchanged)" do
    test "still works as before", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        assert conn.method == "PATCH"
        assert conn.request_path == "/api/v2/hooks/h1"
        {:ok, raw, conn} = Plug.Conn.read_body(conn)
        assert Jason.decode!(raw) == %{"enabled" => false}
        Plug.Conn.resp(conn, 201, "{\"id\":\"x\"}")
      end)

      assert {:ok, %{"id" => "x"}} =
               Management.update_hook("h1", %{"enabled" => false}, config(bypass))
    end

    test "returns an error tuple on 4xx", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn -> Plug.Conn.resp(conn, 404, "{}") end)

      assert {:error, 404, _} =
               Management.update_hook("h1", %{"enabled" => false}, config(bypass))
    end
  end

  describe "get_hook_secrets (D-017 deprecated, behaviour unchanged)" do
    test "still works as before", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        assert conn.method == "GET"
        assert conn.request_path == "/api/v2/hooks/h1/secrets"
        Plug.Conn.resp(conn, 200, "{\"S\":\"_VALUE_NOT_SHOWN_\"}")
      end)

      assert {:ok, %{"S" => "_VALUE_NOT_SHOWN_"}} =
               Management.get_hook_secrets("h1", config(bypass))
    end

    test "returns an error tuple on 4xx", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn -> Plug.Conn.resp(conn, 404, "{}") end)
      assert {:error, 404, _} = Management.get_hook_secrets("h1", config(bypass))
    end
  end

  describe "delete_hook_secrets (D-018 deprecated, behaviour unchanged)" do
    test "still works as before", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        assert conn.method == "DELETE"
        assert conn.request_path == "/api/v2/hooks/h1/secrets"
        {:ok, raw, conn} = Plug.Conn.read_body(conn)
        assert Jason.decode!(raw) == ["S"]
        Plug.Conn.resp(conn, 204, "")
      end)

      assert {:ok, ""} = Management.delete_hook_secrets("h1", %{value: ["S"]}, config(bypass))
    end

    test "returns an error tuple on 4xx", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn -> Plug.Conn.resp(conn, 404, "{}") end)

      assert {:error, 404, _} =
               Management.delete_hook_secrets("h1", %{value: ["S"]}, config(bypass))
    end
  end
end
