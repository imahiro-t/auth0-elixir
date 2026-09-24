defmodule Auth0.Management.Organizations.Groups.Roles.Assign do
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
  Assign roles to a group in an organization context.

  Assign one or more roles to a specified group in the context of an organization.

  ## see
  https://auth0.com/docs/api/management/v2/organizations/post-organization-group-roles

  """
  @spec execute(organization_id, group_id, params, config) :: response
  def execute(organization_id, group_id, %{} = params, %Config{} = config) do
    Util.build_path(@endpoint, organization_id: organization_id, group_id: group_id)
    |> Http.post(params, config)
    |> case do
      {:ok, 204, _body} -> {:ok, ""}
      error -> error
    end
  end
end
