defmodule Auth0.Management.Organizations.DiscoveryDomains.GetByName do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Util
  alias Auth0.Common.Management.Http

  @type id :: String.t()
  @type discovery_domain :: String.t()
  @type config :: Config.t()
  @type entity :: map()
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

  @endpoint "/api/v2/organizations/{id}/discovery-domains/name/{discovery_domain}"

  @doc """
  Retrieve an organization discovery domain by domain name.

  Retrieve details about a single organization discovery domain specified by domain name. This endpoint is subject to eventual consistency; newly created, updated, or deleted discovery domains may not immediately appear in the response.

  ## see
  https://auth0.com/docs/api/management/v2/organizations/get-name-by-discovery-domain

  """
  @spec execute(id, discovery_domain, config) :: response
  def execute(id, discovery_domain, %Config{} = config) do
    Util.build_path(@endpoint, id: id, discovery_domain: discovery_domain)
    |> Http.get(config)
    |> case do
      {:ok, 200, body} -> {:ok, body |> Jason.decode!()}
      error -> error
    end
  end
end
