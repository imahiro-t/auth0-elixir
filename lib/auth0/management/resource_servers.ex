defmodule Auth0.Management.ResourceServers do
  alias Auth0.Config
  alias Auth0.Management.ResourceServers.List
  alias Auth0.Management.ResourceServers.Create
  alias Auth0.Management.ResourceServers.Get
  alias Auth0.Management.ResourceServers.Delete
  alias Auth0.Management.ResourceServers.Patch

  @type id :: String.t()
  @type config :: Config.t()
  @type error :: {:error, integer, term} | {:error, term}

  @doc """
  Retrieve details of all APIs associated with your tenant.

  ## see
  https://auth0.com/docs/api/management/v2/resource-servers/get-resource-servers

  """
  @spec list(map(), config) ::
          {:ok, list(map()) | map()} | error
  def list(%{} = params, %Config{} = config) do
    List.execute(params, config)
  end

  @doc """
  Create a new API associated with your tenant. Note that all new APIs must be registered with Auth0.

  ## see
  https://auth0.com/docs/api/management/v2/resource-servers/post-resource-servers

  """
  @spec create(map(), config) ::
          {:ok, map()} | error
  def create(%{} = params, %Config{} = config) do
    Create.execute(params, config)
  end

  @doc """
  Retrieve API details with the given ID.

  ## see
  https://auth0.com/docs/api/management/v2/resource-servers/get-resource-servers-by-id

  """
  @spec get(id, map(), config) ::
          {:ok, map()} | error
  def get(id, %{} = params, %Config{} = config) do
    Get.execute(id, params, config)
  end

  @doc """
  Delete an existing API by ID.

  ## see
  https://auth0.com/docs/api/management/v2/resource-servers/delete-resource-servers-by-id

  """
  @spec delete(id, config) :: {:ok, String.t()} | error
  def delete(id, %Config{} = config) do
    Delete.execute(id, config)
  end

  @doc """
  Change an existing API setting by resource server ID.

  ## see
  https://auth0.com/docs/api/management/v2/resource-servers/patch-resource-servers-by-id

  """
  @spec update(id, map(), config) ::
          {:ok, map()} | error
  def update(id, %{} = params, %Config{} = config) do
    Patch.execute(id, params, config)
  end
end
