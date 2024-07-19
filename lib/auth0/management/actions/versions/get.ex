defmodule Auth0.Management.Actions.Versions.Get do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Management.Http

  @type endpoint :: String.t()
  @type action_id :: String.t()
  @type id :: String.t()
  @type config :: Config.t()
  @type entity :: list() | map()
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

  @doc """
  Get a specific version of an action.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Actions/get_action_version

  """
  @spec execute(endpoint, action_id, id, config) :: response
  def execute(endpoint, action_id, id, %Config{} = config) do
    endpoint
    |> String.replace("{actionId}", action_id)
    |> String.replace("{id}", id)
    |> Http.get(config)
    |> case do
      {:ok, 200, body} -> {:ok, body |> Jason.decode!()}
      error -> error
    end
  end
end
