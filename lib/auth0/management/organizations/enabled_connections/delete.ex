defmodule Auth0.Management.Organizations.EnabledConnections.Delete do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Management.Http

  @type id :: String.t()
  @type connection_id :: String.t()
  @type config :: Config.t()
  @type entity :: String.t()
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

  @endpoint "/api/v2/organizations/{id}/enabled_connections/{connectionId}"

  @doc """
  Disable a specific connection for an Organization. Once disabled, Organization members can no longer use that connection to authenticate.

  ## see
  https://auth0.com/docs/api/management/v2/organizations/delete-enabled-connections-by-connection-id

  """
  @spec execute(id, connection_id, config) :: response
  def execute(id, connection_id, %Config{} = config) do
    @endpoint
    |> String.replace("{id}", id)
    |> String.replace("{connectionId}", connection_id)
    |> Http.delete(config)
    |> case do
      {:ok, 204, _body} -> {:ok, ""}
      error -> error
    end
  end
end
