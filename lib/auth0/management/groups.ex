defmodule Auth0.Management.Groups do
  @moduledoc """
  Facade for the Auth0 Management API Groups.
  """

  alias Auth0.Config
  alias Auth0.Management.Groups.List, as: GroupsList
  alias Auth0.Management.Groups.Get, as: GroupsGet
  alias Auth0.Management.Groups.Delete, as: GroupsDelete
  alias Auth0.Management.Groups.Members.List, as: GroupsMembersList
  alias Auth0.Management.Groups.Roles.List, as: GroupsRolesList
  alias Auth0.Management.Groups.Roles.Assign, as: GroupsRolesAssign
  alias Auth0.Management.Groups.Roles.Remove, as: GroupsRolesRemove

  @type config :: Config.t()
  @type error :: {:error, integer, term} | {:error, term}

  @doc """
  Get all Groups.

  List all groups in your tenant.

  ## see
  https://auth0.com/docs/api/management/v2/groups/get-groups

  """
  @spec list(map(), config) :: {:ok, map() | list(map())} | error
  def list(%{} = params, %Config{} = config) do
    GroupsList.execute(params, config)
  end

  @doc """
  Get a Group.

  Retrieve a group by its ID.

  ## see
  https://auth0.com/docs/api/management/v2/groups/get-group

  """
  @spec get(String.t(), config) :: {:ok, map()} | error
  def get(id, %Config{} = config) do
    GroupsGet.execute(id, config)
  end

  @doc """
  Delete a Group.

  Delete a group by its ID.

  ## see
  https://auth0.com/docs/api/management/v2/groups/delete-group

  """
  @spec delete(String.t(), config) :: {:ok, String.t()} | error
  def delete(id, %Config{} = config) do
    GroupsDelete.execute(id, config)
  end

  @doc """
  Get Group Members.

  List all users that are a member of this group.

  ## see
  https://auth0.com/docs/api/management/v2/groups/get-group-members

  """
  @spec list_members(String.t(), map(), config) :: {:ok, map()} | error
  def list_members(id, %{} = params, %Config{} = config) do
    GroupsMembersList.execute(id, params, config)
  end

  @doc """
  Get a group's roles.

  Lists the [roles](https://auth0.com/docs/manage-users/access-control/rbac) assigned to a group.

  ## see
  https://auth0.com/docs/api/management/v2/groups/get-group-roles

  """
  @spec list_roles(String.t(), map(), config) :: {:ok, map()} | error
  def list_roles(id, %{} = params, %Config{} = config) do
    GroupsRolesList.execute(id, params, config)
  end

  @doc """
  Assign roles to a group.

  Assign one or more [roles](https://auth0.com/docs/manage-users/access-control/rbac) to a specified group.

  ## see
  https://auth0.com/docs/api/management/v2/groups/post-group-roles

  """
  @spec assign_roles(String.t(), map(), config) :: {:ok, String.t()} | error
  def assign_roles(id, %{} = params, %Config{} = config) do
    GroupsRolesAssign.execute(id, params, config)
  end

  @doc """
  Remove roles from a group.

  Unassign one or more [roles](https://auth0.com/docs/manage-users/access-control/rbac) from a specified group.

  ## see
  https://auth0.com/docs/api/management/v2/groups/delete-group-roles

  """
  @spec remove_roles(String.t(), map(), config) :: {:ok, String.t()} | error
  def remove_roles(id, %{} = params, %Config{} = config) do
    GroupsRolesRemove.execute(id, params, config)
  end
end
