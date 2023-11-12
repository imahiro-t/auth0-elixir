defmodule Auth0.Management.LogStreams.List do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Management.Http
  alias Auth0.Entity.LogStreams

  @type endpoint :: String.t()
  @type config :: Config.t()
  @type entity :: LogStreams.t()
  @type response_body :: String.t()
  @type response :: {:ok, entity, response_body} | {:error, integer, term} | {:error, term}

  @doc """
  Get log streams.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Log_Streams/get_log_streams

  """
  @spec execute(endpoint, config) :: response
  def execute(endpoint, %Config{} = config) do
    endpoint
    |> Http.get(config)
    |> case do
      {:ok, 200, body} -> {:ok, LogStreams.from(body |> Jason.decode!()), body}
      error -> error
    end
  end
end
