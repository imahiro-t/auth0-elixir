defmodule Auth0.Management.ResourceServers do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Management.ResourceServers.List
  alias Auth0.Management.ResourceServers.Create
  alias Auth0.Management.ResourceServers.Get
  alias Auth0.Management.ResourceServers.Delete
  alias Auth0.Management.ResourceServers.Patch

  @type id :: String.t()
  @type config :: Config.t()
  @type error :: {:error, integer, term} | {:error, term}

  @endpoint "/api/v2/resource-servers"
  @endpoint_by_id "/api/v2/resource-servers/{id}"

  @doc """
  Get resource servers.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Resource_Servers/get_resource_servers

  """
  @spec list(List.Params.t() | map, config) ::
          {:ok, list() | map()} | error
  def list(%{} = params, %Config{} = config) do
    List.execute(@endpoint, params, config)
  end

  @doc """
  Create a resource server.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Resource_Servers/post_resource_servers

  """
  @spec create(Create.Params.t() | map, config) ::
          {:ok, list() | map()} | error
  def create(%{} = params, %Config{} = config) do
    Create.execute(@endpoint, params, config)
  end

  @doc """
  Get a resource server.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Resource_Servers/get_resource_servers_by_id

  """
  @spec get(id, Get.Params.t() | map, config) ::
          {:ok, list() | map()} | error
  def get(id, %{} = params, %Config{} = config) do
    Get.execute(@endpoint_by_id, id, params, config)
  end

  @doc """
  Delete a resource server.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Resource_Servers/delete_resource_servers_by_id

  """
  @spec delete(id, config) :: {:ok, String.t()} | error
  def delete(id, %Config{} = config) do
    Delete.execute(@endpoint_by_id, id, config)
  end

  @doc """
  Update a resource server.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Resource_Servers/get_resource_servers_by_id

  """
  @spec update(id, Patch.Params.t() | map, config) ::
          {:ok, list() | map()} | error
  def update(id, %{} = params, %Config{} = config) do
    Patch.execute(@endpoint_by_id, id, params, config)
  end
end
