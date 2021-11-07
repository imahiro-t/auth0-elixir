defmodule Auth0.Management.Actions.Execution do
  @moduledoc """
  Documentation for Auth0 Management Get an execution.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Actions/get_execution
  """

  alias Auth0.Config
  alias Auth0.Common.Management.Http
  alias Auth0.Entity.ActionExecution

  @type endpoint :: String.t()
  @type id :: String.t()
  @type config :: Config.t()
  @type entity :: ActionExecution.t()
  @type response_body :: String.t()
  @type response :: {:ok, entity, response_body} | {:error, integer, term} | {:error, term}

  @doc """
  Get an execution.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Actions/get_execution

  """
  @spec execute(endpoint, id, config) :: response
  def execute(endpoint, id, %Config{} = config) do
    endpoint
    |> String.replace("{id}", id)
    |> Http.get(config)
    |> case do
      {:ok, 200, body} -> {:ok, ActionExecution.from(body |> Jason.decode!()), body}
      error -> error
    end
  end
end
