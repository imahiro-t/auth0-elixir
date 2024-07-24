defmodule Auth0.Management.Actions.Versions.List do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Util
  alias Auth0.Common.Management.Http

  @type action_id :: String.t()
  @type params :: map()
  @type config :: Config.t()
  @type entity :: map()
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

  @endpoint "/api/v2/actions/actions/{actionId}/versions"

  @doc """
  Retrieve all of an action's versions. An action version is created whenever an action is deployed. An action version is immutable, once created.

  ## see
  https://auth0.com/docs/api/management/v2/actions/get-action-versions

  """
  @spec execute(action_id, params, config) :: response
  def execute(action_id, %{} = params, %Config{} = config) do
    params
    |> Util.convert_to_query()
    |> Util.append_query(@endpoint |> String.replace("{actionId}", action_id))
    |> Http.get(config)
    |> case do
      {:ok, 200, body} -> {:ok, body |> Jason.decode!()}
      error -> error
    end
  end
end
