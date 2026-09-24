defmodule Auth0.Management.Organizations.Groups.List do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Util
  alias Auth0.Common.Management.Http

  @type organization_id :: String.t()
  @type params :: map()
  @type config :: Config.t()
  @type entity :: map()
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

  @endpoint "/api/v2/organizations/{organization_id}/groups"

  @doc """
  List the groups that are assigned to the organization.

  Lists the groups that are assigned to the specified organization.

  ## see
  https://auth0.com/docs/api/management/v2/organizations/get-organization-groups

  """
  @spec execute(organization_id, params, config) :: response
  def execute(organization_id, %{} = params, %Config{} = config) do
    params
    |> Util.convert_to_query()
    |> Util.append_query(path(organization_id))
    |> Http.get(config)
    |> case do
      {:ok, 200, body} -> {:ok, body |> Jason.decode!()}
      error -> error
    end
  end

  defp path(organization_id) do
    @endpoint
    |> String.replace("{organization_id}", Util.encode_path_param(organization_id))
  end
end
