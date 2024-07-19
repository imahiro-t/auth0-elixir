defmodule Auth0.Management.Actions.Deploy do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Management.Http

  @type endpoint :: String.t()
  @type id :: String.t()
  @type config :: Config.t()
  @type entity :: list() | map()
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

  @doc """
  Deploy an action.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Actions/post_deploy_action

  """
  @spec execute(endpoint, id, config) :: response
  def execute(endpoint, id, %Config{} = config) do
    endpoint
    |> String.replace("{id}", id)
    |> Http.post(%{}, config)
    |> case do
      {:ok, 202, body} -> {:ok, body |> Jason.decode!()}
      error -> error
    end
  end
end
