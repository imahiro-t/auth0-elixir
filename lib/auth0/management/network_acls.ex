defmodule Auth0.Management.NetworkAcls do
  alias Auth0.Config
  alias Auth0.Management.NetworkAcls.List
  alias Auth0.Management.NetworkAcls.Create
  alias Auth0.Management.NetworkAcls.Get
  alias Auth0.Management.NetworkAcls.Delete
  alias Auth0.Management.NetworkAcls.Patch

  @type id :: String.t()
  @type config :: Config.t()
  @type error :: {:error, integer, term} | {:error, term}

  @doc """
  Retrieve a list of network ACLs.

  ## see
  https://auth0.com/docs/api/management/v2/network-acls/get-network-acls
  """
  @spec list(map(), config) :: {:ok, list(map())} | error
  def list(%{} = params, %Config{} = config) do
    List.execute(params, config)
  end

  @doc """
  Create a network ACL.

  ## see
  https://auth0.com/docs/api/management/v2/network-acls/post-network-acls
  """
  @spec create(map(), config) :: {:ok, map()} | error
  def create(%{} = params, %Config{} = config) do
    Create.execute(params, config)
  end

  @doc """
  Retrieve a network ACL by its ID.

  ## see
  https://auth0.com/docs/api/management/v2/network-acls/get-network-acls-by-id
  """
  @spec get(id, config) :: {:ok, map()} | error
  def get(id, %Config{} = config) do
    Get.execute(id, config)
  end

  @doc """
  Delete a network ACL.

  ## see
  https://auth0.com/docs/api/management/v2/network-acls/delete-network-acls-by-id
  """
  @spec delete(id, config) :: {:ok, String.t()} | error
  def delete(id, %Config{} = config) do
    Delete.execute(id, config)
  end

  @doc """
  Update a network ACL.

  ## see
  https://auth0.com/docs/api/management/v2/network-acls/patch-network-acls-by-id
  """
  @spec update(id, map(), config) :: {:ok, map()} | error
  def update(id, %{} = params, %Config{} = config) do
    Patch.execute(id, params, config)
  end
end
