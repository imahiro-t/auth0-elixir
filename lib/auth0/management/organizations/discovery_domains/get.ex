defmodule Auth0.Management.Organizations.DiscoveryDomains.Get do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Util
  alias Auth0.Common.Management.Http

  @type id :: String.t()
  @type discovery_domain_id :: String.t()
  @type config :: Config.t()
  @type entity :: map()
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

  @endpoint "/api/v2/organizations/{id}/discovery-domains/{discovery_domain_id}"

  @doc """
  Retrieve an organization discovery domain by ID.

  Retrieve details about a single organization discovery domain specified by ID. This endpoint is subject to eventual consistency; newly created, updated, or deleted discovery domains may not immediately appear in the response.

  ## see
  https://auth0.com/docs/api/management/v2/organizations/get-discovery-domains-by-discovery-domain-id

  """
  @spec execute(id, discovery_domain_id, config) :: response
  def execute(id, discovery_domain_id, %Config{} = config) do
    Util.build_path(@endpoint, id: id, discovery_domain_id: discovery_domain_id)
    |> Http.get(config)
    |> case do
      {:ok, 200, body} -> {:ok, body |> Jason.decode!()}
      error -> error
    end
  end
end
