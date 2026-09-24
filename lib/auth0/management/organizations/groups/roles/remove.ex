defmodule Auth0.Management.Organizations.Groups.Roles.Remove do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Util
  alias Auth0.Common.Management.Http

  @type organization_id :: String.t()
  @type group_id :: String.t()
  @type params :: map()
  @type config :: Config.t()
  @type entity :: String.t()
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

  @endpoint "/api/v2/organizations/{organization_id}/groups/{group_id}/roles"

  @doc """
  Remove roles assigned to a group in an organization context.

  Unassign one or more roles from a specified group in the context of an organization.

  ## see
  https://auth0.com/docs/api/management/v2/organizations/delete-organization-group-roles

  """
  @spec execute(organization_id, group_id, params, config) :: response
  def execute(organization_id, group_id, %{} = params, %Config{} = config) do
    path(organization_id, group_id)
    |> Http.delete(params, config)
    |> case do
      {:ok, 204, _body} -> {:ok, ""}
      error -> error
    end
  end

  defp path(organization_id, group_id) do
    @endpoint
    |> String.replace("{organization_id}", Util.encode_path_param(organization_id))
    |> String.replace("{group_id}", Util.encode_path_param(group_id))
  end
end
