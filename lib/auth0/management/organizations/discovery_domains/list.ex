defmodule Auth0.Management.Organizations.DiscoveryDomains.List do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Util
  alias Auth0.Common.Management.Http

  @type id :: String.t()
  @type params :: map()
  @type config :: Config.t()
  @type entity :: map()
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

  @endpoint "/api/v2/organizations/{id}/discovery-domains"

  @doc """
  Retrieve all organization discovery domains.

  Retrieve list of all organization discovery domains associated with the specified organization. This endpoint is subject to eventual consistency; newly created, updated, or deleted discovery domains may not immediately appear in the response.

  ## see
  https://auth0.com/docs/api/management/v2/organizations/get-discovery-domains

  """
  @spec execute(id, params, config) :: response
  def execute(id, %{} = params, %Config{} = config) do
    params
    |> Util.convert_to_query()
    |> Util.append_query(Util.build_path(@endpoint, id: id))
    |> Http.get(config)
    |> case do
      {:ok, 200, body} -> {:ok, body |> Jason.decode!()}
      error -> error
    end
  end
end
