defmodule Auth0.Management.Connections.DirectoryProvisioning.SynchronizedGroups.Delete do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Util
  alias Auth0.Common.Management.Http

  @type id :: String.t()
  @type params :: map()
  @type config :: Config.t()
  @type entity :: String.t()
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

  @endpoint "/api/v2/connections/{id}/directory-provisioning/synchronized-groups"

  @doc """
  Delete synchronized group selections for a directory provisioning configuration.

  ## see
  https://auth0.com/docs/api/management/v2/connections/delete-synchronized-groups

  """
  @spec execute(id, params, config) :: response
  def execute(id, %{} = params, %Config{} = config) do
    path(id)
    |> Http.delete(params, config)
    |> case do
      {:ok, 204, _body} -> {:ok, ""}
      error -> error
    end
  end

  defp path(id) do
    @endpoint
    |> String.replace("{id}", Util.encode_path_param(id))
  end
end
