defmodule Auth0.Management.LogStreams.Get do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Management.Http
  alias Auth0.Entity.LogStream

  @type endpoint :: String.t()
  @type id :: String.t()
  @type config :: Config.t()
  @type entity :: LogStream.t()
  @type response_body :: String.t()
  @type response :: {:ok, entity, response_body} | {:error, integer, term} | {:error, term}

  @doc """
  Get log stream by ID.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Log_Streams/get_log_streams_by_id

  """
  @spec execute(endpoint, id, config) :: response
  def execute(endpoint, id, %Config{} = config) do
    endpoint
    |> String.replace("{id}", id)
    |> Http.get(config)
    |> case do
      {:ok, 200, body} -> {:ok, LogStream.from(body |> Jason.decode!()), body}
      error -> error
    end
  end
end
