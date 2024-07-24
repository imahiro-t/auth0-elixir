defmodule Auth0.Management.Actions.Versions.Rollback do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Util
  alias Auth0.Common.Management.Http

  @type action_id :: String.t()
  @type id :: String.t()
  @type params :: map()
  @type config :: Config.t()
  @type entity :: map()
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

  @endpoint "/api/v2/actions/actions/{actionId}/versions/{id}/deploy"

  @doc """
  Performs the equivalent of a roll-back of an action to an earlier, specified version. Creates a new, deployed action version that is identical to the specified version. If this action is currently bound to a trigger, the system will begin executing the newly-created version immediately.

  ## see
  https://auth0.com/docs/api/management/v2/actions/post-deploy-draft-version

  """
  def execute(action_id, id, %{} = params, %Config{} = config) do
    body = params |> Util.remove_nil()

    @endpoint
    |> String.replace("{actionId}", action_id)
    |> String.replace("{id}", id)
    |> Http.post(body, config)
    |> case do
      {:ok, 202, body} -> {:ok, body |> Jason.decode!()}
      error -> error
    end
  end
end
