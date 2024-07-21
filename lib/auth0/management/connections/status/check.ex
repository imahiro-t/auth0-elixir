defmodule Auth0.Management.Connections.Status.Check do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Management.Http

  @type id :: String.t()
  @type config :: Config.t()
  @type entity :: boolean
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

  @endpoint "/api/v2/connections/{id}/status"

  @doc """
  Retrieves the status of an ad/ldap connection referenced by its ID. 200 OK http status code response is returned when the connection is online, otherwise a 404 status code is returned along with an error message

  ## see
  https://auth0.com/docs/api/management/v2/connections/get-status

  """
  @spec execute(id, config) :: response
  def execute(id, %Config{} = config) do
    @endpoint
    |> String.replace("{id}", id)
    |> Http.get(config)
    |> case do
      {:ok, 200, _body} -> {:ok, true}
      {:error, 404, _body} -> {:ok, false}
      error -> error
    end
  end
end
