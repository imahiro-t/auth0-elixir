defmodule Auth0.Management.Organizations.Roles.Members.List do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Util
  alias Auth0.Common.Management.Http

  @type id :: String.t()
  @type role_id :: String.t()
  @type params :: map()
  @type config :: Config.t()
  @type entity :: map()
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

  @endpoint "/api/v2/organizations/{id}/roles/{role_id}/members"

  @doc """
  List the members assigned to a role in the context of an organization.

  List the organization members assigned a specific role within the context of an organization. Note: Returns only members with direct role assignments. For groups assigned to this role within the organization, use GET /api/v2/organizations/{organization_id}/roles/{role_id}/groups.

  **Early Access**: this endpoint is marked as Early Access (`x-release-lifecycle: EA`) in the Auth0 Management API specification and may not be available on every tenant.

  ## see
  https://auth0.com/docs/api/management/v2/organizations/get-organization-role-members

  """
  @spec execute(id, role_id, params, config) :: response
  def execute(id, role_id, %{} = params, %Config{} = config) do
    params
    |> Util.convert_to_query()
    |> Util.append_query(path(id, role_id))
    |> Http.get(config)
    |> case do
      {:ok, 200, body} -> {:ok, body |> Jason.decode!()}
      error -> error
    end
  end

  defp path(id, role_id) do
    @endpoint
    |> String.replace("{id}", Util.encode_path_param(id))
    |> String.replace("{role_id}", Util.encode_path_param(role_id))
  end
end
