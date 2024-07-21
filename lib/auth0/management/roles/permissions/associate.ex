defmodule Auth0.Management.Roles.Permissions.Associate do
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
  Add one or more permissions to a specified user role.

  ## see
  https://auth0.com/docs/api/management/v2/roles/post-role-permission-assignment

  """
  @spec execute(id, params, config) :: response
  def execute(id, %{} = params, %Config{} = config) do
    body = params |> Util.remove_nil()

    @endpoint
    |> String.replace("{id}", id)
    |> Http.post(body, config)
    |> case do
      {:ok, 201, _body} -> {:ok, ""}
      error -> error
    end
  end
end
