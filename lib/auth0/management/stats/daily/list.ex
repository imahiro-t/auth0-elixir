defmodule Auth0.Management.Stats.Daily.List do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Management.Http

  @type config :: Config.t()
  @type entity :: list(map())
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

  @endpoint "/api/v2/stats/daily"

  @doc """
  Retrieve the number of logins, signups and breached-password detections (subscription required) that occurred each day within a specified date range.

  ## see
  https://auth0.com/docs/api/management/v2/stats/get-daily

  """
  @spec execute(config) :: response
  def execute(%Config{} = config) do
    @endpoint
    |> Http.get(config)
    |> case do
      {:ok, 200, body} -> {:ok, body |> Jason.decode!()}
      error -> error
    end
  end
end
