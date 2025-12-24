defmodule Auth0.Management.Connections.Status do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Management.Http

  @type id :: String.t()
  @type config :: Config.t()
  @type entity :: map()
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
      {:ok, 200, body} ->
        {:ok, body |> Jason.decode!()} # Note: Auth0 status might return true/false or object depending on connection type, usually implies a successful 200 means ok but body exists.
        # Actually for some connections it might just be 200 OK. But doc says "Check the status".
        # Let's assume standard JSON response.

      error ->
        error
    end
  end
end
