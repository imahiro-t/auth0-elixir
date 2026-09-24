defmodule Auth0.Management.Connections.DirectoryProvisioning.Get do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Util
  alias Auth0.Common.Management.Http

  @type id :: String.t()
  @type config :: Config.t()
  @type entity :: map()
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

  @endpoint "/api/v2/connections/{id}/directory-provisioning"

  @doc """
  Get a directory provisioning configuration.

  Retrieve the directory provisioning configuration of a connection.

  ## see
  https://auth0.com/docs/api/management/v2/connections/get-directory-provisioning

  """
  @spec execute(id, config) :: response
  def execute(id, %Config{} = config) do
    Util.build_path(@endpoint, id: id)
    |> Http.get(config)
    |> case do
      {:ok, 200, body} -> {:ok, body |> Jason.decode!()}
      error -> error
    end
  end
end
