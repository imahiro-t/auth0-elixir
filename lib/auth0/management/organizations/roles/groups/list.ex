defmodule Auth0.Management.Organizations.Roles.Groups.List do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Util
  alias Auth0.Common.Management.Http

  @type organization_id :: String.t()
  @type role_id :: String.t()
  @type params :: map()
  @type config :: Config.t()
  @type entity :: map()
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

  @endpoint "/api/v2/organizations/{organization_id}/roles/{role_id}/groups"

  @doc """
  List the groups assigned to a role in the context of an organization.

  Retrieve the list of groups assigned to a role in the context of an organization.

  **Early Access**: this endpoint is marked as Early Access (`x-release-lifecycle: EA`) in the Auth0 Management API specification and may not be available on every tenant.

  ## see
  https://auth0.com/docs/api/management/v2/organizations/get-organization-role-groups

  """
  @spec execute(organization_id, role_id, params, config) :: response
  def execute(organization_id, role_id, %{} = params, %Config{} = config) do
    params
    |> Util.convert_to_query()
    |> Util.append_query(
      Util.build_path(@endpoint, organization_id: organization_id, role_id: role_id)
    )
    |> Http.get(config)
    |> case do
      {:ok, 200, body} -> {:ok, body |> Jason.decode!()}
      error -> error
    end
  end
end
