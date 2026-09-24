defmodule Auth0.Management.EventStreams.Redeliver.CreateById do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Util
  alias Auth0.Common.Management.Http

  @type id :: String.t()
  @type event_id :: String.t()
  @type config :: Config.t()
  @type entity :: String.t()
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

  @endpoint "/api/v2/event-streams/{id}/redeliver/{event_id}"

  @doc """
  Redeliver a single failed event by ID.

  ## see
  https://auth0.com/docs/api/management/v2/event-streams/post-redeliver-by-event-id

  """
  @spec execute(id, event_id, config) :: response
  def execute(id, event_id, %Config{} = config) do
    Util.build_path(@endpoint, id: id, event_id: event_id)
    |> Http.post(%{}, config)
    |> case do
      {:ok, 202, _body} -> {:ok, ""}
      error -> error
    end
  end
end
