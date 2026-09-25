defmodule Auth0.Management.EventStreams.Test do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Util
  alias Auth0.Common.Management.Http

  @type id :: String.t()
  @type params :: map()
  @type config :: Config.t()
  @type entity :: map()
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

  @endpoint "/api/v2/event-streams/{id}/test"

  @doc """
  Send a test event to an event stream.

  ## see
  https://auth0.com/docs/api/management/v2/event-streams/post-test-event

  """
  @spec execute(id, params, config) :: response
  def execute(id, %{} = params, %Config{} = config) do
    Util.build_path(@endpoint, id: id)
    |> Http.post(params, config)
    |> case do
      {:ok, 202, body} -> {:ok, body |> Jason.decode!()}
      error -> error
    end
  end
end
