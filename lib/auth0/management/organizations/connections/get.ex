defmodule Auth0.Management.Organizations.Connections.Get do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Util
  alias Auth0.Common.Management.Http

  @type id :: String.t()
  @type connection_id :: String.t()
  @type config :: Config.t()
  @type entity :: map()
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

  @endpoint "/api/v2/organizations/{id}/connections/{connection_id}"

  @doc """
  Get a specific connection associated with an organization.

  **Early Access**: this endpoint is marked as Early Access (`x-release-lifecycle: EA`) in the Auth0 Management API specification and may not be available on every tenant.

  ## see
  https://auth0.com/docs/api/management/v2/organizations/get-organization-connection

  """
  @spec execute(id, connection_id, config) :: response
  def execute(id, connection_id, %Config{} = config) do
    path(id, connection_id)
    |> Http.get(config)
    |> case do
      {:ok, 200, body} -> {:ok, body |> Jason.decode!()}
      error -> error
    end
  end

  defp path(id, connection_id) do
    @endpoint
    |> String.replace("{id}", Util.encode_path_param(id))
    |> String.replace("{connection_id}", Util.encode_path_param(connection_id))
  end
end
