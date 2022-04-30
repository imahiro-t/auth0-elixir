defmodule Auth0.Management.Roles do
  @moduledoc """
  Documentation for Auth0 Management API of Roles.

  ## endpoint
  - /api/v2/roles
  - /api/v2/roles/{id}
  - /api/v2/roles/{id}/permissions
  - /api/v2/roles/{id}/users
  """

  alias Auth0.Config
  alias Auth0.Entity
  alias Auth0.Management.Roles.List
  alias Auth0.Management.Roles.Create
  alias Auth0.Management.Roles.Get
  alias Auth0.Management.Roles.Delete
  alias Auth0.Management.Roles.Patch
  alias Auth0.Management.Roles.Permissions
  alias Auth0.Management.Roles.Users

  @type id :: String.t()
  @type config :: Config.t()
  @type response_body :: String.t()
  @type error :: {:error, integer, term} | {:error, term}

  @endpoint "/api/v2/roles"
  @endpoint_by_id "/api/v2/roles/{id}"
  @endpoint_permissions "/api/v2/roles/{id}/permissions"
  @endpoint_users "/api/v2/roles/{id}/users"

  @doc """
  Get roles.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Roles/get_roles

  """
  @spec list(List.Params.t() | map, config) :: {:ok, Entity.Roles.t(), response_body} | error
  def list(%{} = params, %Config{} = config) do
    List.execute(@endpoint, params, config)
  end

  @doc """
  Create a role.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Roles/post_roles

  """
  @spec create(Create.Params.t() | map, config) ::
          {:ok, Entity.Role.t(), response_body} | error
  def create(%{} = params, %Config{} = config) do
    Create.execute(@endpoint, params, config)
  end

  @doc """
  Get a role.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Roles/get_roles_by_id

  """
  @spec get(id, config) :: {:ok, Entity.Role.t(), response_body} | error
  def get(id, %Config{} = config) do
    Get.execute(@endpoint_by_id, id, config)
  end

  @doc """
  Delete a role.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Roles/delete_roles_by_id

  """
  @spec delete(id, config) :: {:ok, String.t(), response_body} | error
  def delete(id, %Config{} = config) do
    Delete.execute(@endpoint_by_id, id, config)
  end

  @doc """
  Update a role.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Roles/patch_roles_by_id

  """
  @spec update(id, Patch.Params.t() | map, config) ::
          {:ok, Entity.Role.t(), response_body} | error
  def update(id, %{} = params, %Config{} = config) do
    Patch.execute(@endpoint_by_id, id, params, config)
  end

  @doc """
  Get permissions granted by role.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Roles/get_role_permission

  """
  @spec list_permissions(id, Permissions.List.Params.t() | map, config) ::
          {:ok, Entity.Permissions.t(), response_body} | error
  def list_permissions(id, %{} = params, %Config{} = config) do
    Permissions.List.execute(@endpoint_permissions, id, params, config)
  end

  @doc """
  Remove permissions from a role.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Roles/delete_role_permission_assignment

  """
  @spec remove_permissions(id, Permissions.Remove.Params.t() | map, config) ::
          {:ok, String.t(), response_body} | error
  def remove_permissions(id, %{} = params, %Config{} = config) do
    Permissions.Remove.execute(@endpoint_permissions, id, params, config)
  end

  @doc """
  Associate permissions with a role.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Roles/post_role_permission_assignment

  """
  @spec associate_permissions(id, Permissions.Associate.Params.t() | map, config) ::
          {:ok, String.t(), response_body} | error
  def associate_permissions(id, %{} = params, %Config{} = config) do
    Permissions.Associate.execute(@endpoint_permissions, id, params, config)
  end

  @doc """
  Get a role's users.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Roles/get_role_user

  """
  @spec list_users(id, Users.List.Params.t() | map, config) ::
          {:ok, Entity.Users.t(), response_body} | error
  def list_users(id, %{} = params, %Config{} = config) do
    Users.List.execute(@endpoint_users, id, params, config)
  end

  @doc """
  Assign users to a role.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Roles/post_role_users

  """
  @spec assign_users(id, Users.Assign.Params.t() | map, config) ::
          {:ok, String.t(), response_body} | error
  def assign_users(id, %{} = params, %Config{} = config) do
    Users.Assign.execute(@endpoint_users, id, params, config)
  end
end
