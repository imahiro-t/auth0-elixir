defmodule Auth0.Management.Users.EffectivePermissions.List do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Util
  alias Auth0.Common.Management.Http

  @type id :: String.t()
  @type params :: map()
  @type config :: Config.t()
  @type entity :: map()
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

  @endpoint "/api/v2/users/{id}/effective-permissions"

  @doc """
  List the permissions assigned to a user directly or through roles or groups.

  Returns the list of effective permissions for a user, taking into account permissions granted directly to the user, as well as those inherited through roles and group memberships.

  ## see
  https://auth0.com/docs/api/management/v2/users/get-user-effective-permissions

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
