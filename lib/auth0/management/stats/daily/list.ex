defmodule Auth0.Management.Stats.Daily.List do
  @moduledoc """
  Documentation for Auth0 Management Get daily stats.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Stats/get_daily
  """

  alias Auth0.Config
  alias Auth0.Common.Management.Http
  alias Auth0.Entity.DailyStats

  @type endpoint :: String.t()
  @type config :: Config.t()
  @type entity :: DailyStats.t()
  @type response_body :: String.t()
  @type response :: {:ok, entity, response_body} | {:error, integer, term} | {:error, term}

  @doc """
  Get daily stats.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Stats/get_daily

  """
  @spec execute(endpoint, config) :: response
  def execute(endpoint, %Config{} = config) do
    endpoint
    |> Http.get(config)
    |> case do
      {:ok, 200, body} -> {:ok, DailyStats.from(body |> Jason.decode!()), body}
      error -> error
    end
  end
end
