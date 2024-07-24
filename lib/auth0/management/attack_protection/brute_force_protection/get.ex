defmodule Auth0.Management.AttackProtection.BruteForceProtection.Get do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Management.Http

  @type config :: Config.t()
  @type entity :: map()
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

  @endpoint "/api/v2/attack-protection/brute-force-protection"

  @doc """
  Retrieve details of the Brute-force Protection configuration of your tenant.

  ## see
  https://auth0.com/docs/api/management/v2/attack-protection/get-brute-force-protection

  """
  @spec execute(config) :: response
  def execute(%Config{} = config) do
    Http.get(@endpoint, config)
    |> case do
      {:ok, 200, body} ->
        {:ok, body |> Jason.decode!()}

      error ->
        error
    end
  end
end
