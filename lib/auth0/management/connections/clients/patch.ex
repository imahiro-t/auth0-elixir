defmodule Auth0.Management.Connections.Clients.Patch do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Util
  alias Auth0.Common.Management.Http

  @type id :: String.t()
  @type params :: list(map())
  @type config :: Config.t()
  @type entity :: String.t()
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

  @endpoint "/api/v2/connections/{id}/clients"

  @doc """
  Update enabled clients for a connection.

  ## see
  https://auth0.com/docs/api/management/v2/connections/patch-clients

  """
  @spec execute(id, params, config) :: response
  def execute(id, params, %Config{} = config) when is_list(params) do
    Util.build_path(@endpoint, id: id)
    |> Http.patch(params, config)
    |> case do
      {:ok, 204, _body} -> {:ok, ""}
      error -> error
    end
  end
end
