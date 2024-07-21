defmodule Auth0.Management.Organizations.EnabledConnections.Patch do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Util
  alias Auth0.Common.Management.Http

  @type id :: String.t()
  @type connection_id :: String.t()
  @type params :: map()
  @type config :: Config.t()
  @type entity :: list() | map()
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

  @endpoint "/api/v2/organizations/{id}/enabled_connections/{connectionId}"

  @doc """
  Modify the details of a specific connection currently enabled for an Organization.

  ## see
  https://auth0.com/docs/api/management/v2/organizations/patch-enabled-connections-by-connection-id

  """
  def execute(id, connection_id, %{} = params, %Config{} = config) do
    body = params |> Util.remove_nil()

    @endpoint
    |> String.replace("{id}", id)
    |> String.replace("{connectionId}", connection_id)
    |> Http.patch(body, config)
    |> case do
      {:ok, 200, body} -> {:ok, body |> Jason.decode!()}
      error -> error
    end
  end
end
