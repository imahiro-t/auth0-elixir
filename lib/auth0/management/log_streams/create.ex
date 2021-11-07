defmodule Auth0.Management.LogStreams.Create do
  @moduledoc """
  Documentation for Auth0 Management Create a log stream.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Log_Streams/post_log_streams
  """

  alias Auth0.Config
  alias Auth0.Common.Util
  alias Auth0.Common.Management.Http
  alias Auth0.Entity.LogStream

  defmodule Params do
    defstruct name: nil,
              type: nil,
              sink: nil

    @type t :: %__MODULE__{
            name: String.t(),
            type: String.t(),
            sink: map
          }
  end

  @type endpoint :: String.t()
  @type params :: Params.t()
  @type config :: Config.t()
  @type entity :: LogStream.t()
  @type response_body :: String.t()
  @type response :: {:ok, entity, response_body} | {:error, integer, term} | {:error, term}

  @doc """
  Create a log stream.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Log_Streams/post_log_streams

  """
  @spec execute(endpoint, params, config) :: response
  def execute(endpoint, %Params{} = params, %Config{} = config) do
    body = params |> Util.to_map() |> Util.remove_nil()

    Http.post(endpoint, body, config)
    |> case do
      {:ok, 200, body} -> {:ok, LogStream.from(body |> Jason.decode!()), body}
      error -> error
    end
  end
end
