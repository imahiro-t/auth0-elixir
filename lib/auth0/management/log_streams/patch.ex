defmodule Auth0.Management.LogStreams.Patch do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Util
  alias Auth0.Common.Management.Http
  alias Auth0.Entity.LogStream

  defmodule Params do
    @moduledoc false
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
  @type id :: String.t()
  @type params :: Params.t() | map
  @type config :: Config.t()
  @type entity :: LogStream.t()
  @type response_body :: String.t()
  @type response :: {:ok, entity, response_body} | {:error, integer, term} | {:error, term}

  @doc """
  Update a log stream.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Log_Streams/patch_log_streams_by_id

  """
  @spec execute(endpoint, id, params, config) :: response
  def execute(endpoint, id, %Params{} = params, %Config{} = config) do
    execute(endpoint, id, params |> Util.to_map(), config)
  end

  def execute(endpoint, id, %{} = params, %Config{} = config) do
    body = params |> Util.remove_nil()

    endpoint
    |> String.replace("{id}", id)
    |> Http.patch(body, config)
    |> case do
      {:ok, 200, body} -> {:ok, LogStream.from(body |> Jason.decode!()), body}
      error -> error
    end
  end
end
