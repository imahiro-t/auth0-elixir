defmodule Auth0.Management.Organizations.DiscoveryDomains.Patch do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Util
  alias Auth0.Common.Management.Http

  @type id :: String.t()
  @type discovery_domain_id :: String.t()
  @type params :: map()
  @type config :: Config.t()
  @type entity :: map()
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

  @endpoint "/api/v2/organizations/{id}/discovery-domains/{discovery_domain_id}"

  @doc """
  Update an organization discovery domain.

  Update the verification status and/or use_for_organization_discovery for an organization discovery domain. The `status` field must be either `pending` or `verified`. The `use_for_organization_discovery` field can be `true` or `false` (default: `true`).

  ## see
  https://auth0.com/docs/api/management/v2/organizations/patch-discovery-domains-by-discovery-domain-id

  """
  @spec execute(id, discovery_domain_id, params, config) :: response
  def execute(id, discovery_domain_id, %{} = params, %Config{} = config) do
    path(id, discovery_domain_id)
    |> Http.patch(params, config)
    |> case do
      {:ok, 200, body} -> {:ok, body |> Jason.decode!()}
      error -> error
    end
  end

  defp path(id, discovery_domain_id) do
    @endpoint
    |> String.replace("{id}", Util.encode_path_param(id))
    |> String.replace("{discovery_domain_id}", Util.encode_path_param(discovery_domain_id))
  end
end
