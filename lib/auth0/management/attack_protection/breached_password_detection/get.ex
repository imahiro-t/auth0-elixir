defmodule Auth0.Management.AttackProtection.BreachedPasswordDetection.Get do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Management.Http

  @type config :: Config.t()
  @type entity :: list() | map()
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

  @endpoint "/api/v2/attack-protection/breached-password-detection"

  @doc """
  Retrieve details of the Breached Password Detection configuration of your tenant.

  ## see
  https://auth0.com/docs/api/management/v2/attack-protection/get-breached-password-detection

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
