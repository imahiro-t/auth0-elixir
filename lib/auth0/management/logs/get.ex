defmodule Auth0.Management.Logs.Get do
  @moduledoc """
  Documentation for Auth0 Management Get a log event by id.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Logs/get_logs_by_id
  """

  alias Auth0.Config
  alias Auth0.Common.Management.Http
  alias Auth0.Entity.Log

  @type endpoint :: String.t()
  @type id :: String.t()
  @type config :: Config.t()
  @type entity :: Log.t()
  @type response_body :: String.t()
  @type response :: {:ok, entity, response_body} | {:error, integer, term} | {:error, term}

  @doc """
  Get a log event by id.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Logs/get_logs_by_id

  """
  @spec execute(endpoint, id, config) :: response
  def execute(endpoint, id, %Config{} = config) do
    endpoint
    |> String.replace("{id}", id)
    |> Http.get(config)
    |> case do
      {:ok, 200, body} -> {:ok, Log.from(body |> Jason.decode!()), body}
      error -> error
    end
  end
end
