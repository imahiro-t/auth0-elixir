defmodule Auth0.Management.Connections.DirectoryProvisioning.Delete do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Util
  alias Auth0.Common.Management.Http

  @type id :: String.t()
  @type config :: Config.t()
  @type entity :: String.t()
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

  @endpoint "/api/v2/connections/{id}/directory-provisioning"

  @doc """
  Delete a directory provisioning configuration.

  Delete the directory provisioning configuration of a connection.

  ## see
  https://auth0.com/docs/api/management/v2/connections/delete-directory-provisioning

  """
  @spec execute(id, config) :: response
  def execute(id, %Config{} = config) do
    Util.build_path(@endpoint, id: id)
    |> Http.delete(config)
    |> case do
      {:ok, 204, _body} -> {:ok, ""}
      error -> error
    end
  end
end
