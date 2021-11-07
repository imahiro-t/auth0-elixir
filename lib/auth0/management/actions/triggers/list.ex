defmodule Auth0.Management.Actions.Triggers.List do
  @moduledoc """
  Documentation for Auth0 Management Get triggers.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Actions/get_triggers
  """

  alias Auth0.Config
  alias Auth0.Common.Management.Http
  alias Auth0.Entity.ActionTriggers

  @type endpoint :: String.t()
  @type config :: Config.t()
  @type entity :: ActionTriggers.t()
  @type response_body :: String.t()
  @type response :: {:ok, entity, response_body} | {:error, integer, term} | {:error, term}

  @doc """
  Get triggers.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Actions/get_triggers

  """
  @spec execute(endpoint, config) :: response
  def execute(endpoint, %Config{} = config) do
    endpoint
    |> Http.get(config)
    |> case do
      {:ok, 200, body} -> {:ok, ActionTriggers.from(body |> Jason.decode!()), body}
      error -> error
    end
  end
end
