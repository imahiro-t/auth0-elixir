defmodule Auth0.Management.Connections.Users.Delete do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Util
  alias Auth0.Common.Management.Http

  @type id :: String.t()
  @type params :: map()
  @type config :: Config.t()
  @type entity :: String.t()
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

  @endpoint "/api/v2/connections/{id}/users"

  @doc """
  Deletes a specified connection user by its email (you cannot delete all users from specific connection). Currently, only Database Connections are supported.

  ## see
  https://auth0.com/docs/api/management/v2/connections/delete-users-by-email

  """
  @spec execute(id, params, config) :: response
  def execute(id, %{} = params, %Config{} = config) do
    params
    |> Util.convert_to_query()
    |> Util.append_query(@endpoint |> String.replace("{id}", id))
    |> Http.delete(config)
    |> case do
      {:ok, 204, _body} -> {:ok, ""}
      error -> error
    end
  end
end
