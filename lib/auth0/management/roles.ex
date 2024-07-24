defmodule Auth0.Management.Roles do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Management.Roles.List
  alias Auth0.Management.Roles.Create
  alias Auth0.Management.Roles.Get
  alias Auth0.Management.Roles.Delete
  alias Auth0.Management.Roles.Patch
  alias Auth0.Management.Roles.Permissions
  alias Auth0.Management.Roles.Users

  @type id :: String.t()
  @type config :: Config.t()
  @type error :: {:error, integer, term} | {:error, term}

  @doc """
  Retrieve detailed list of user roles created in your tenant.

  ## see
  https://auth0.com/docs/api/management/v2/roles/get-roles

  """
  @spec list(map(), config) ::
          {:ok, list(map()) | map()} | error
  def list(%{} = params, %Config{} = config) do
    List.execute(params, config)
  end

  @doc """
  Create a user role for Role-Based Access Control.

  ## see
  https://auth0.com/docs/api/management/v2/roles/post-roles

  """
  @spec create(map(), config) ::
          {:ok, map()} | error
  def create(%{} = params, %Config{} = config) do
    Create.execute(params, config)
  end

  @doc """
  Retrieve details about a specific user role specified by ID.

  ## see
  https://auth0.com/docs/api/management/v2/roles/get-roles-by-id

  """
  @spec get(id, config) ::
          {:ok, map()} | error
  def get(id, %Config{} = config) do
    Get.execute(id, config)
  end

  @doc """
  Delete a specific user role from your tenant. Once deleted, it is removed from any user who was previously assigned that role. This action cannot be undone.

  ## see
  https://auth0.com/docs/api/management/v2/roles/delete-roles-by-id

  """
  @spec delete(id, config) :: {:ok, String.t()} | error
  def delete(id, %Config{} = config) do
    Delete.execute(id, config)
  end

  @doc """
  Modify the details of a specific user role specified by ID.

  ## see
  https://auth0.com/docs/api/management/v2/roles/patch-roles-by-id

  """
  @spec update(id, map(), config) ::
          {:ok, map()} | error
  def update(id, %{} = params, %Config{} = config) do
    Patch.execute(id, params, config)
  end

  @doc """
  Retrieve detailed list (name, description, resource server) of permissions granted by a specified user role.

  ## see
  https://auth0.com/docs/api/management/v2/roles/get-role-permission

  """
  @spec list_permissions(id, map(), config) ::
          {:ok, list(map()) | map()} | error
  def list_permissions(id, %{} = params, %Config{} = config) do
    Permissions.List.execute(id, params, config)
  end

  @doc """
  Remove one or more permissions from a specified user role.

  ## see
  https://auth0.com/docs/api/management/v2/roles/delete-role-permission-assignment

  """
  @spec remove_permissions(id, map(), config) ::
          {:ok, String.t()} | error
  def remove_permissions(id, %{} = params, %Config{} = config) do
    Permissions.Remove.execute(id, params, config)
  end

  @doc """
  Add one or more permissions to a specified user role.

  ## see
  https://auth0.com/docs/api/management/v2/roles/post-role-permission-assignment

  """
  @spec associate_permissions(id, map(), config) ::
          {:ok, String.t()} | error
  def associate_permissions(id, %{} = params, %Config{} = config) do
    Permissions.Associate.execute(id, params, config)
  end

  @doc """
  Retrieve list of users associated with a specific role.

  ## see
  https://auth0.com/docs/api/management/v2/roles/get-role-user

  """
  @spec list_users(id, map(), config) ::
          {:ok, list(map()) | map()} | error
  def list_users(id, %{} = params, %Config{} = config) do
    Users.List.execute(id, params, config)
  end

  @doc """
  Assign one or more users to an existing user role.

  ## see
  https://auth0.com/docs/api/management/v2/roles/post-role-users

  """
  @spec assign_users(id, map(), config) ::
          {:ok, String.t()} | error
  def assign_users(id, %{} = params, %Config{} = config) do
    Users.Assign.execute(id, params, config)
  end
end
