defmodule Auth0.Management.Actions.Deploy do
  @moduledoc """
  Documentation for Auth0 Management Deploy an action.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Actions/post_deploy_action
  """

  alias Auth0.Config
  alias Auth0.Common.Management.Http
  alias Auth0.Entity.ActionVersion

  @type endpoint :: String.t()
  @type id :: String.t()
  @type config :: Config.t()
  @type entity :: ActionVersion.t()
  @type response_body :: String.t()
  @type response :: {:ok, entity, response_body} | {:error, integer, term} | {:error, term}

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
      {:ok, 202, body} -> {:ok, ActionVersion.from(body |> Jason.decode!()), body}
      error -> error
    end
  end
end
