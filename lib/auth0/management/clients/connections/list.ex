defmodule Auth0.Management.Clients.Connections.List do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Util
  alias Auth0.Common.Management.Http

  @type id :: String.t()
  @type params :: map()
  @type config :: Config.t()
  @type entity :: map()
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

  @endpoint "/api/v2/clients/{id}/connections"

  @doc """
  Get enabled connections for a client.

  Retrieve all connections that are enabled for the specified [Application](https://www.auth0.com/docs/get-started/applications), using checkpoint pagination. A list of fields to include or exclude for each connection may also be specified.

  ## see
  https://auth0.com/docs/api/management/v2/clients/get-client-connections

  """
  @spec execute(id, params, config) :: response
  def execute(id, %{} = params, %Config{} = config) do
    params
    |> Util.convert_to_query()
    |> Util.append_query(path(id))
    |> Http.get(config)
    |> case do
      {:ok, 200, body} -> {:ok, body |> Jason.decode!()}
      error -> error
    end
  end

  defp path(id) do
    @endpoint
    |> String.replace("{id}", Util.encode_path_param(id))
  end
end
