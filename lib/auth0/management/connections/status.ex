defmodule Auth0.Management.Connections.Status do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Management.Http

  @type id :: String.t()
  @type config :: Config.t()
  @type entity :: true
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

  @endpoint "/api/v2/connections/{id}/status"

  @doc """
  Check the status of a connection.

  ## see
  https://auth0.com/docs/api/management/v2/connections/get-test-connection
  """
  @spec execute(id, config) :: response
  def execute(id, %Config{} = config) do
    @endpoint
    |> String.replace("{id}", id)
    |> Http.get(config)
    |> case do
      # The specification defines no response body for 200 ("the connection is
      # online"), so the body is not decoded. Errors (e.g. 404 "Connection not
      # found.") are returned unchanged as {:error, status, body}.
      {:ok, 200, _body} -> {:ok, true}
      error -> error
    end
  end
end
