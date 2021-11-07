defmodule Auth0.Management.Organizations.EnabledConnections.Delete do
  @moduledoc """
  Documentation for Auth0 Management Delete connections from an organization.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Organizations/delete_enabled_connections_by_connectionId
  """

  alias Auth0.Config
  alias Auth0.Common.Management.Http

  @type endpoint :: String.t()
  @type id :: String.t()
  @type connection_id :: String.t()
  @type config :: Config.t()
  @type entity :: String.t()
  @type response_body :: String.t()
  @type response :: {:ok, entity, response_body} | {:error, integer, term} | {:error, term}

  @doc """
  Delete connections from an organization.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Organizations/delete_enabled_connections_by_connectionId

  """
  @spec execute(endpoint, id, connection_id, config) :: response
  def execute(endpoint, id, connection_id, %Config{} = config) do
    endpoint
    |> String.replace("{id}", id)
    |> String.replace("{connectionId}", connection_id)
    |> Http.delete(config)
    |> case do
      {:ok, 204, body} -> {:ok, "", body}
      error -> error
    end
  end
end
