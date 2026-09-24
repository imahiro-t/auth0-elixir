defmodule Auth0.Management.Organizations.Members.EffectiveRoles.Sources.Groups.List do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Util
  alias Auth0.Common.Management.Http

  @type id :: String.t()
  @type user_id :: String.t()
  @type params :: map()
  @type config :: Config.t()
  @type entity :: map()
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

  @endpoint "/api/v2/organizations/{id}/members/{user_id}/effective-roles/sources/groups"

  @doc """
  List organization member role group sources.

  Lists the groups which grant the org member a given role.

  ## see
  https://auth0.com/docs/api/management/v2/organizations/get-organization-member-role-source-groups

  """
  @spec execute(id, user_id, params, config) :: response
  def execute(id, user_id, %{} = params, %Config{} = config) do
    params
    |> Util.convert_to_query()
    |> Util.append_query(Util.build_path(@endpoint, id: id, user_id: user_id))
    |> Http.get(config)
    |> case do
      {:ok, 200, body} -> {:ok, body |> Jason.decode!()}
      error -> error
    end
  end
end
