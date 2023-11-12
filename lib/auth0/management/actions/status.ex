defmodule Auth0.Management.Actions.Status do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Management.Http
  alias Auth0.Entity.ActionStatus

  @type endpoint :: String.t()
  @type config :: Config.t()
  @type entity :: ActionStatus.t()
  @type response_body :: String.t()
  @type response :: {:ok, entity, response_body} | {:error, integer, term} | {:error, term}

  @doc """
  Get actions service status.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Actions/get_service_status

  """
  @spec execute(endpoint, config) :: response
  def execute(endpoint, %Config{} = config) do
    endpoint
    |> Http.get(config)
    |> case do
      {:ok, 200, body} -> {:ok, ActionStatus.from(body |> Jason.decode!()), body}
      error -> error
    end
  end
end
