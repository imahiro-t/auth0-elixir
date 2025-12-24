defmodule Auth0.Management.AttackProtection.BotDetection.Get do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Management.Http

  @type config :: Config.t()
  @type entity :: map()
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

  @endpoint "/api/v2/attack-protection/bot-detection"

  @doc """
  Retrieve details of the Bot Detection configuration of your tenant.

  ## see
  There is no public documentation for this endpoint yet, but it follows the standard pattern.
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
