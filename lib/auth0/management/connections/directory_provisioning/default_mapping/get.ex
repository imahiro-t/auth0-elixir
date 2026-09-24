defmodule Auth0.Management.Connections.DirectoryProvisioning.DefaultMapping.Get do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Util
  alias Auth0.Common.Management.Http

  @type id :: String.t()
  @type config :: Config.t()
  @type entity :: map()
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

  @endpoint "/api/v2/connections/{id}/directory-provisioning/default-mapping"

  @doc """
  Get a connection's default directory provisioning attribute mapping.

  Retrieve the directory provisioning default attribute mapping of a connection.

  ## see
  https://auth0.com/docs/api/management/v2/connections/get-directory-provisioning-default-mapping

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
