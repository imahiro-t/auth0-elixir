defmodule Auth0.Management.Roles.Permissions.Remove do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Util
  alias Auth0.Common.Management.Http

  @type id :: String.t()
  @type params :: map()
  @type config :: Config.t()
  @type entity :: String.t()
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

  @endpoint "/api/v2/roles/{id}/permissions"

  @doc """
  Remove one or more permissions from a specified user role.

  ## see
  https://auth0.com/docs/api/management/v2/roles/delete-role-permission-assignment

  """
  @spec execute(id, params, config) :: response
  def execute(id, %{} = params, %Config{} = config) do
    body = params |> Util.remove_nil()

    @endpoint
    |> String.replace("{id}", id)
    |> Http.delete(body, config)
    |> case do
      {:ok, 200, _body} -> {:ok, ""}
      error -> error
    end
  end
end
