defmodule Auth0.Api.Management.VerifiableCredentialsTest do
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

  describe "get_verifiable_credentials (C-004)" do
    test "lists the verification templates", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        assert conn.method == "GET"
        assert conn.request_path == "/api/v2/verifiable-credentials/verification/templates"
        Plug.Conn.resp(conn, 200, "[]")
      end)

      assert {:ok, []} = Management.get_verifiable_credentials(%{"take" => 5}, config(bypass))
    end

    test "returns an error tuple on 4xx", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn -> Plug.Conn.resp(conn, 404, "{}") end)

      assert {:error, 404, _} =
               Management.get_verifiable_credentials(%{"take" => 5}, config(bypass))
    end
  end

  describe "create_verifiable_credential (C-005)" do
    test "creates a verification template", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        assert conn.method == "POST"
        assert conn.request_path == "/api/v2/verifiable-credentials/verification/templates"
        {:ok, raw, conn} = Plug.Conn.read_body(conn)
        assert Jason.decode!(raw) == %{"name" => "t"}
        Plug.Conn.resp(conn, 201, "{\"id\":\"x\"}")
      end)

      assert {:ok, %{"id" => "x"}} =
               Management.create_verifiable_credential(%{"name" => "t"}, config(bypass))
    end

    test "returns an error tuple on 4xx", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn -> Plug.Conn.resp(conn, 404, "{}") end)

      assert {:error, 404, _} =
               Management.create_verifiable_credential(%{"name" => "t"}, config(bypass))
    end
  end

  describe "get_verifiable_credential (C-006)" do
    test "gets a verification template", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        assert conn.method == "GET"
        assert conn.request_path == "/api/v2/verifiable-credentials/verification/templates/vct_1"
        Plug.Conn.resp(conn, 200, "{\"id\":\"x\"}")
      end)

      assert {:ok, %{"id" => "x"}} = Management.get_verifiable_credential("vct_1", config(bypass))
    end

    test "returns an error tuple on 4xx", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn -> Plug.Conn.resp(conn, 404, "{}") end)
      assert {:error, 404, _} = Management.get_verifiable_credential("vct_1", config(bypass))
    end
  end

  describe "update_verifiable_credential (C-007)" do
    test "updates a verification template", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        assert conn.method == "PATCH"
        assert conn.request_path == "/api/v2/verifiable-credentials/verification/templates/vct_1"
        {:ok, raw, conn} = Plug.Conn.read_body(conn)
        assert Jason.decode!(raw) == %{"name" => "t2"}
        Plug.Conn.resp(conn, 200, "{\"id\":\"x\"}")
      end)

      assert {:ok, %{"id" => "x"}} =
               Management.update_verifiable_credential("vct_1", %{"name" => "t2"}, config(bypass))
    end

    test "returns an error tuple on 4xx", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn -> Plug.Conn.resp(conn, 404, "{}") end)

      assert {:error, 404, _} =
               Management.update_verifiable_credential("vct_1", %{"name" => "t2"}, config(bypass))
    end
  end

  describe "delete_verifiable_credential (C-008)" do
    test "deletes a verification template", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        assert conn.method == "DELETE"
        assert conn.request_path == "/api/v2/verifiable-credentials/verification/templates/vct_1"
        Plug.Conn.resp(conn, 204, "")
      end)

      assert {:ok, ""} = Management.delete_verifiable_credential("vct_1", config(bypass))
    end

    test "returns an error tuple on 4xx", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn -> Plug.Conn.resp(conn, 404, "{}") end)
      assert {:error, 404, _} = Management.delete_verifiable_credential("vct_1", config(bypass))
    end
  end
end
