defmodule Auth0.Management.Organizations.Groups.Roles.List do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Util
  alias Auth0.Common.Management.Http

  @type organization_id :: String.t()
  @type group_id :: String.t()
  @type params :: map()
  @type config :: Config.t()
  @type entity :: map()
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

  @endpoint "/api/v2/organizations/{organization_id}/groups/{group_id}/roles"

  @doc """
  List the roles assigned to a group in the context of an organization.

  Lists the roles assigned to the specified group in the context of an organization.

  ## see
  https://auth0.com/docs/api/management/v2/organizations/get-organization-group-roles

  """
  @spec execute(organization_id, group_id, params, config) :: response
  def execute(organization_id, group_id, %{} = params, %Config{} = config) do
    params
    |> Util.convert_to_query()
    |> Util.append_query(
      Util.build_path(@endpoint, organization_id: organization_id, group_id: group_id)
    )
    |> Http.get(config)
    |> case do
      {:ok, 200, body} -> {:ok, body |> Jason.decode!()}
      error -> error
    end
  end
end
