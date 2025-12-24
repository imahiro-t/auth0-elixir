defmodule Auth0.Management.AttackProtection.BotDetection.Patch do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Management.Http

  @type params :: map()
  @type config :: Config.t()
  @type entity :: map()
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

  @endpoint "/api/v2/attack-protection/bot-detection"

  @doc """
  Update details of the Bot Detection configuration of your tenant.

  ## see
  There is no public documentation for this endpoint yet, but it follows the standard pattern.
  """
  @spec execute(params, config) :: response
  def execute(%{} = params, %Config{} = config) do
    Http.patch(@endpoint, params, config)
    |> case do
      {:ok, 200, body} ->
        {:ok, body |> Jason.decode!()}

      error ->
        error
    end
  end
end
