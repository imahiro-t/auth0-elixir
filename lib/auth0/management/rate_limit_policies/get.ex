defmodule Auth0.Management.RateLimitPolicies.Get do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Util
  alias Auth0.Common.Management.Http

  @type id :: String.t()
  @type config :: Config.t()
  @type entity :: map()
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

  @endpoint "/api/v2/rate-limit-policies/{id}"

  @doc """
  Get a rate limit policy.

  **Early Access**: this endpoint is marked as Early Access (`x-release-lifecycle: EA`) in the Auth0 Management API specification and may not be available on every tenant.

  ## see
  https://auth0.com/docs/api/management/v2/rate-limit-policies/get-rate-limit-policies-by-id

  """
  @spec execute(id, config) :: response
  def execute(id, %Config{} = config) do
    Util.build_path(@endpoint, id: id)
    |> Http.get(config)
    |> case do
      {:ok, 200, body} -> {:ok, body |> Jason.decode!()}
      error -> error
    end
  end
end
