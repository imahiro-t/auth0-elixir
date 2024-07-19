defmodule Auth0.Management.Organizations do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Management.Organizations.List
  alias Auth0.Management.Organizations.Create
  alias Auth0.Management.Organizations.Get
  alias Auth0.Management.Organizations.Delete
  alias Auth0.Management.Organizations.Patch
  alias Auth0.Management.Organizations.Name
  alias Auth0.Management.Organizations.EnabledConnections
  alias Auth0.Management.Organizations.Invitations
  alias Auth0.Management.Organizations.Members

  @type config :: Config.t()
  @type id :: String.t()
  @type name :: String.t()
  @type invitation_id :: String.t()
  @type connection_id :: String.t()
  @type user_id :: String.t()
  @type error :: {:error, integer, term} | {:error, term}

  @endpoint "/api/v2/organizations"
  @endpoint_by_id "/api/v2/organizations/{id}"
  @endpoint_by_name "/api/v2/organizations/name/{name}"
  @endpoint_enabled_connections "/api/v2/organizations/{id}/enabled_connections"
  @endpoint_enabled_connections_by_id "/api/v2/organizations/{id}/enabled_connections/{connectionId}"
  @endpoint_invitations "/api/v2/organizations/{id}/invitations"
  @endpoint_invitations_by_id "/api/v2/organizations/{id}/invitations/{invitation_id}"
  @endpoint_members "/api/v2/organizations/{id}/members"
  @endpoint_roles "/api/v2/organizations/{id}/members/{user_id}/roles"

  @doc """
  Get organizations.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Organizations/get_organizations

  """
  @spec list(List.Params.t() | map, config) ::
          {:ok, list() | map()} | error
  def list(%{} = params, %Config{} = config) do
    List.execute(@endpoint, params, config)
  end

  @doc """
  Create an Organization.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Organizations/post_organizations

  """
  @spec create(Create.Params.t() | map, config) ::
          {:ok, list() | map()} | error
  def create(%{} = params, %Config{} = config) do
    Create.execute(@endpoint, params, config)
  end

  @doc """
  Get organization.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Organizations/get_organizations_by_id

  """
  @spec get(id, config) ::
          {:ok, list() | map()} | error
  def get(id, %Config{} = config) do
    Get.execute(@endpoint_by_id, id, config)
  end

  @doc """
  Delete organization.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Organizations/delete_organizations_by_id

  """
  @spec delete(id, config) :: {:ok, String.t()} | error
  def delete(id, %Config{} = config) do
    Delete.execute(@endpoint_by_id, id, config)
  end

  @doc """
  Modify an Organization.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Organizations/patch_organizations_by_id

  """
  @spec modify(id, Patch.Params.t() | map, config) ::
          {:ok, list() | map()} | error
  def modify(id, %{} = params, %Config{} = config) do
    Patch.execute(@endpoint_by_id, id, params, config)
  end

  @doc """
  Get organization by name.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Organizations/get_name_by_name

  """
  @spec get_by_name(name, config) ::
          {:ok, list() | map()} | error
  def get_by_name(name, %Config{} = config) do
    Name.Get.execute(@endpoint_by_name, name, config)
  end

  @doc """
  Get connections enabled for an organization.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Organizations/get_enabled_connections

  """
  @spec list_connections(id, EnabledConnections.List.Params.t() | map, config) ::
          {:ok, list() | map()} | error
  def list_connections(id, %{} = params, %Config{} = config) do
    EnabledConnections.List.execute(@endpoint_enabled_connections, id, params, config)
  end

  @doc """
  Add connections to an organization.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Organizations/post_enabled_connections

  """
  @spec add_connection(id, EnabledConnections.Create.Params.t() | map, config) ::
          {:ok, list() | map()} | error
  def add_connection(id, %{} = params, %Config{} = config) do
    EnabledConnections.Create.execute(@endpoint_enabled_connections, id, params, config)
  end

  @doc """
  Get an enabled connection for an organization.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Organizations/get_enabled_connections_by_connectionId

  """
  @spec get_connection(id, connection_id, config) ::
          {:ok, list() | map()} | error
  def get_connection(id, connection_id, %Config{} = config) do
    EnabledConnections.Get.execute(@endpoint_enabled_connections_by_id, id, connection_id, config)
  end

  @doc """
  Delete connections from an organization.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Organizations/delete_enabled_connections_by_connectionId

  """
  @spec delete_connection(id, connection_id, config) :: {:ok, String.t()} | error
  def delete_connection(id, connection_id, %Config{} = config) do
    EnabledConnections.Delete.execute(
      @endpoint_enabled_connections_by_id,
      id,
      connection_id,
      config
    )
  end

  @doc """
  Modify an Organizations Connection.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Organizations/patch_enabled_connections_by_connectionId

  """
  @spec modify_connection(id, connection_id, EnabledConnections.Patch.Params.t() | map, config) ::
          {:ok, list() | map()} | error
  def modify_connection(
        id,
        connection_id,
        %{} = params,
        %Config{} = config
      ) do
    EnabledConnections.Patch.execute(
      @endpoint_enabled_connections_by_id,
      id,
      connection_id,
      params,
      config
    )
  end

  @doc """
  Get invitations to organization.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Organizations/get_invitations

  """
  @spec list_invitations(id, Invitations.List.Params.t() | map, config) ::
          {:ok, list() | map()} | error
  def list_invitations(id, %{} = params, %Config{} = config) do
    Invitations.List.execute(@endpoint_invitations, id, params, config)
  end

  @doc """
  Create invitations to organization.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Organizations/post_invitations

  """
  @spec create_invitation(id, Invitations.Create.Params.t() | map, config) ::
          {:ok, list() | map()} | error
  def create_invitation(id, %{} = params, %Config{} = config) do
    Invitations.Create.execute(@endpoint_invitations, id, params, config)
  end

  @doc """
  Get an invitation to organization.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Organizations/get_invitations_by_invitation_id

  """
  @spec get_invitation(id, invitation_id, Invitations.Get.Params.t() | map, config) ::
          {:ok, list() | map()} | error
  def get_invitation(id, invitation_id, %{} = params, %Config{} = config) do
    Invitations.Get.execute(@endpoint_invitations_by_id, id, invitation_id, params, config)
  end

  @doc """
  Delete an invitation to organization.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Organizations/delete_invitations_by_invitation_id

  """
  @spec delete_invitation(id, invitation_id, config) :: {:ok, String.t()} | error
  def delete_invitation(id, invitation_id, %Config{} = config) do
    Invitations.Delete.execute(@endpoint_invitations_by_id, id, invitation_id, config)
  end

  @doc """
  Get members who belong to an organization.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Organizations/get_members

  """
  @spec list_members(id, Members.List.Params.t() | map, config) ::
          {:ok, list() | map()} | error
  def list_members(id, %{} = params, %Config{} = config) do
    Members.List.execute(@endpoint_members, id, params, config)
  end

  @doc """
  Delete members from an organization.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Organizations/delete_members

  """
  @spec delete_members(id, Members.Delete.Params.t() | map, config) ::
          {:ok, String.t()} | error
  def delete_members(id, %{} = params, %Config{} = config) do
    Members.Delete.execute(@endpoint_members, id, params, config)
  end

  @doc """
  Add members to an organization.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Organizations/post_members

  """
  @spec add_members(id, Members.Add.Params.t() | map, config) ::
          {:ok, String.t()} | error
  def add_members(id, %{} = params, %Config{} = config) do
    Members.Add.execute(@endpoint_members, id, params, config)
  end

  @doc """
  Get the roles assigned to an organization member.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Organizations/get_organization_member_roles

  """
  @spec list_roles(id, user_id, Members.Roles.List.Params.t() | map, config) ::
          {:ok, list() | map()} | error
  def list_roles(id, user_id, %{} = params, %Config{} = config) do
    Members.Roles.List.execute(@endpoint_roles, id, user_id, params, config)
  end

  @doc """
  Delete members from an organization.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Organizations/delete_members

  """
  @spec delete_roles(id, user_id, Members.Roles.Delete.Params.t() | map, config) ::
          {:ok, String.t()} | error
  def delete_roles(id, user_id, %{} = params, %Config{} = config) do
    Members.Roles.Delete.execute(@endpoint_roles, id, user_id, params, config)
  end

  @doc """
  Add members to an organization.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Organizations/post_members

  """
  @spec assign_roles(id, user_id, Members.Roles.Add.Params.t() | map, config) ::
          {:ok, String.t()} | error
  def assign_roles(id, user_id, %{} = params, %Config{} = config) do
    Members.Roles.Add.execute(@endpoint_roles, id, user_id, params, config)
  end
end
