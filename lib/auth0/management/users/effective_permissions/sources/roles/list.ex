defmodule Auth0.Management.Users.EffectivePermissions.Sources.Roles.List do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Util
  alias Auth0.Common.Management.Http

  @type id :: String.t()
  @type params :: map()
  @type config :: Config.t()
  @type entity :: map()
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

  @endpoint "/api/v2/users/{id}/effective-permissions/sources/effective-roles"

  @doc """
  List the roles which grant the user a given permission (whether directly or through groups).

  Lists the roles which grant the user a given permission, including roles assigned directly to the user and those inherited through group memberships.

  ## see
  https://auth0.com/docs/api/management/v2/users/get-user-effective-permission-role-sources

  """
  @spec execute(id, params, config) :: response
  def execute(id, %{} = params, %Config{} = config) do
    params
    |> Util.convert_to_query()
    |> Util.append_query(Util.build_path(@endpoint, id: id))
    |> Http.get(config)
    |> case do
      {:ok, 200, body} -> {:ok, body |> Jason.decode!()}
      error -> error
    end
  end
end
