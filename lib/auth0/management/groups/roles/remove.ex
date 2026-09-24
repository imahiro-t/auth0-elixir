defmodule Auth0.Management.Groups.Roles.Remove do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Util
  alias Auth0.Common.Management.Http

  @type id :: String.t()
  @type params :: map()
  @type config :: Config.t()
  @type entity :: String.t()
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

  @endpoint "/api/v2/groups/{id}/roles"

  @doc """
  Remove roles from a group.

  Unassign one or more [roles](https://auth0.com/docs/manage-users/access-control/rbac) from a specified group.

  ## see
  https://auth0.com/docs/api/management/v2/groups/delete-group-roles

  """
  @spec execute(id, params, config) :: response
  def execute(id, %{} = params, %Config{} = config) do
    Util.build_path(@endpoint, id: id)
    |> Http.delete(params, config)
    |> case do
      {:ok, 204, _body} -> {:ok, ""}
      error -> error
    end
  end
end
