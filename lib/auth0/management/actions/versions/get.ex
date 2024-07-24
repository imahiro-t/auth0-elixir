defmodule Auth0.Management.Actions.Versions.Get do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Management.Http

  @type action_id :: String.t()
  @type id :: String.t()
  @type config :: Config.t()
  @type entity :: map()
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

  @endpoint "/api/v2/actions/actions/{actionId}/versions/{id}"

  @doc """
  Retrieve a specific version of an action. An action version is created whenever an action is deployed. An action version is immutable, once created.

  ## see
  https://auth0.com/docs/api/management/v2/actions/get-action-version

  """
  @spec execute(action_id, id, config) :: response
  def execute(action_id, id, %Config{} = config) do
    @endpoint
    |> String.replace("{actionId}", action_id)
    |> String.replace("{id}", id)
    |> Http.get(config)
    |> case do
      {:ok, 200, body} -> {:ok, body |> Jason.decode!()}
      error -> error
    end
  end
end
