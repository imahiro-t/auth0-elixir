defmodule Auth0.Management.EventStreams.Deliveries.Get do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Util
  alias Auth0.Common.Management.Http

  @type id :: String.t()
  @type event_id :: String.t()
  @type config :: Config.t()
  @type entity :: map()
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

  @endpoint "/api/v2/event-streams/{id}/deliveries/{event_id}"

  @doc """
  Get a specific event's delivery history.

  ## see
  https://auth0.com/docs/api/management/v2/event-streams/get-deliveries-by-event-id

  """
  @spec execute(id, event_id, config) :: response
  def execute(id, event_id, %Config{} = config) do
    path(id, event_id)
    |> Http.get(config)
    |> case do
      {:ok, 200, body} -> {:ok, body |> Jason.decode!()}
      error -> error
    end
  end

  defp path(id, event_id) do
    @endpoint
    |> String.replace("{id}", Util.encode_path_param(id))
    |> String.replace("{event_id}", Util.encode_path_param(event_id))
  end
end
