defmodule Auth0.Management.Organizations.EnabledConnections.Get do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Management.Http

  @type id :: String.t()
  @type connection_id :: String.t()
  @type config :: Config.t()
  @type entity :: map()
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

  @endpoint "/api/v2/organizations/{id}/enabled_connections/{connectionId}"

  @doc """
  Retrieve details about a specific connection currently enabled for an Organization. Information returned includes details such as connection ID, name, strategy, and whether the connection automatically grants membership upon login.

  ## see
  https://auth0.com/docs/api/management/v2/organizations/get-enabled-connections-by-connection-id

  """
  @spec execute(id, connection_id, config) :: response
  def execute(id, connection_id, %Config{} = config) do
    @endpoint
    |> String.replace("{id}", id)
    |> String.replace("{connectionId}", connection_id)
    |> Http.get(config)
    |> case do
      {:ok, 200, body} -> {:ok, body |> Jason.decode!()}
      error -> error
    end
  end
end
