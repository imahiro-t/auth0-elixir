defmodule Auth0.Management.Actions.Deploy do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Management.Http

  @type id :: String.t()
  @type config :: Config.t()
  @type entity :: list() | map()
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

  @endpoint "/api/v2/actions/actions/{id}/deploy"

  @doc """
  Deploy an action. Deploying an action will create a new immutable version of the action. If the action is currently bound to a trigger, then the system will begin executing the newly deployed version of the action immediately. Otherwise, the action will only be executed as a part of a flow once it is bound to that flow.

  ## see
  https://auth0.com/docs/api/management/v2/actions/post-deploy-action

  """
  @spec execute(id, config) :: response
  def execute(id, %Config{} = config) do
    @endpoint
    |> String.replace("{id}", id)
    |> Http.post(%{}, config)
    |> case do
      {:ok, 202, body} -> {:ok, body |> Jason.decode!()}
      error -> error
    end
  end
end
