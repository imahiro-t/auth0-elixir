defmodule Auth0.Management.Organizations do
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

  @doc """
  Retrive detailed list of all Organizations available in your tenant.

  ## see
  https://auth0.com/docs/api/management/v2/organizations/get-organizations

  """
  @spec list(map(), config) ::
          {:ok, list(map()) | map()} | error
  def list(%{} = params, %Config{} = config) do
    List.execute(params, config)
  end

  @doc """
  Create a new Organization within your tenant.

  ## see
  https://auth0.com/docs/api/management/v2/organizations/post-organizations

  """
  @spec create(map(), config) ::
          {:ok, map()} | error
  def create(%{} = params, %Config{} = config) do
    Create.execute(params, config)
  end

  @doc """
  Retrieve details about a single Organization specified by name.

  ## see
  https://auth0.com/docs/api/management/v2/organizations/get-name-by-name

  """
  @spec get_by_name(name, config) ::
          {:ok, map()} | error
  def get_by_name(name, %Config{} = config) do
    Name.Get.execute(name, config)
  end

  @doc """
  Retrieve details about a single Organization specified by ID.

  ## see
  https://auth0.com/docs/api/management/v2/organizations/get-organizations-by-id

  """
  @spec get(id, config) ::
          {:ok, map()} | error
  def get(id, %Config{} = config) do
    Get.execute(id, config)
  end

  @doc """
  Remove an Organization from your tenant. This action cannot be undone.

  ## see
  https://auth0.com/docs/api/management/v2/organizations/delete-organizations-by-id

  """
  @spec delete(id, config) :: {:ok, String.t()} | error
  def delete(id, %Config{} = config) do
    Delete.execute(id, config)
  end

  @doc """
  Update the details of a specific Organization, such as name and display name, branding options, and metadata.

  ## see
  https://auth0.com/docs/api/management/v2/organizations/patch-organizations-by-id

  """
  @spec modify(id, map(), config) ::
          {:ok, map()} | error
  def modify(id, %{} = params, %Config{} = config) do
    Patch.execute(id, params, config)
  end

  @doc """
  Retrieve details about a specific connection currently enabled for an Organization. Information returned includes details such as connection ID, name, strategy, and whether the connection automatically grants membership upon login.

  ## see
  https://auth0.com/docs/api/management/v2/organizations/get-enabled-connections

  """
  @spec list_connections(id, map(), config) ::
          {:ok, list(map()) | map()} | error
  def list_connections(id, %{} = params, %Config{} = config) do
    EnabledConnections.List.execute(id, params, config)
  end

  @doc """
  Enable a specific connection for a given Organization. To enable a connection, it must already exist within your tenant; connections cannot be created through this action.

  ## see
  https://auth0.com/docs/api/management/v2/organizations/post-enabled-connections

  """
  @spec add_connection(id, map(), config) ::
          {:ok, map()} | error
  def add_connection(id, %{} = params, %Config{} = config) do
    EnabledConnections.Create.execute(id, params, config)
  end

  @doc """
  Retrieve details about a specific connection currently enabled for an Organization. Information returned includes details such as connection ID, name, strategy, and whether the connection automatically grants membership upon login.

  ## see
  https://auth0.com/docs/api/management/v2/organizations/get-enabled-connections-by-connection-id

  """
  @spec get_connection(id, connection_id, config) ::
          {:ok, map()} | error
  def get_connection(id, connection_id, %Config{} = config) do
    EnabledConnections.Get.execute(id, connection_id, config)
  end

  @doc """
  Disable a specific connection for an Organization. Once disabled, Organization members can no longer use that connection to authenticate.

  ## see
  https://auth0.com/docs/api/management/v2/organizations/delete-enabled-connections-by-connection-id

  """
  @spec delete_connection(id, connection_id, config) :: {:ok, String.t()} | error
  def delete_connection(id, connection_id, %Config{} = config) do
    EnabledConnections.Delete.execute(
      id,
      connection_id,
      config
    )
  end

  @doc """
  Modify the details of a specific connection currently enabled for an Organization.

  ## see
  https://auth0.com/docs/api/management/v2/organizations/patch-enabled-connections-by-connection-id

  """
  @spec modify_connection(id, connection_id, map(), config) ::
          {:ok, map()} | error
  def modify_connection(
        id,
        connection_id,
        %{} = params,
        %Config{} = config
      ) do
    EnabledConnections.Patch.execute(
      id,
      connection_id,
      params,
      config
    )
  end

  @doc """
  Retrieve a detailed list of invitations sent to users for a specific Organization. The list includes details such as inviter and invitee information, invitation URLs, and dates of creation and expiration.

  ## see
  https://auth0.com/docs/api/management/v2/organizations/get-invitations

  """
  @spec list_invitations(id, map(), config) ::
          {:ok, list(map()) | map()} | error
  def list_invitations(id, %{} = params, %Config{} = config) do
    Invitations.List.execute(id, params, config)
  end

  @doc """
  Create a user invitation for a specific Organization. Upon creation, the listed user receives an email inviting them to join the Organization.

  ## see
  https://auth0.com/docs/api/management/v2/organizations/post-invitations

  """
  @spec create_invitation(id, map(), config) ::
          {:ok, map()} | error
  def create_invitation(id, %{} = params, %Config{} = config) do
    Invitations.Create.execute(id, params, config)
  end

  @doc """
  Get a specific invitation to an Organization

  ## see
  https://auth0.com/docs/api/management/v2/organizations/get-invitations-by-invitation-id

  """
  @spec get_invitation(id, invitation_id, map(), config) ::
          {:ok, map()} | error
  def get_invitation(id, invitation_id, %{} = params, %Config{} = config) do
    Invitations.Get.execute(id, invitation_id, params, config)
  end

  @doc """
  Delete an invitation to an Organization

  ## see
  https://auth0.com/docs/api/management/v2/organizations/delete-invitations-by-invitation-id

  """
  @spec delete_invitation(id, invitation_id, config) :: {:ok, String.t()} | error
  def delete_invitation(id, invitation_id, %Config{} = config) do
    Invitations.Delete.execute(id, invitation_id, config)
  end

  @doc """
  List organization members.

  ## see
  https://auth0.com/docs/api/management/v2/organizations/get-members

  """
  @spec list_members(id, map(), config) ::
          {:ok, list(map()) | map()} | error
  def list_members(id, %{} = params, %Config{} = config) do
    Members.List.execute(id, params, config)
  end

  @doc """
  Delete members from an organization

  ## see
  https://auth0.com/docs/api/management/v2/organizations/delete-members

  """
  @spec delete_members(id, map(), config) ::
          {:ok, String.t()} | error
  def delete_members(id, %{} = params, %Config{} = config) do
    Members.Delete.execute(id, params, config)
  end

  @doc """
  Set one or more existing users as members of a specific Organization.

  ## see
  https://auth0.com/docs/api/management/v2/organizations/post-members

  """
  @spec add_members(id, map(), config) ::
          {:ok, String.t()} | error
  def add_members(id, %{} = params, %Config{} = config) do
    Members.Add.execute(id, params, config)
  end

  @doc """
  Retrieve detailed list of roles assigned to a given user within the context of a specific Organization.

  ## see
  https://auth0.com/docs/api/management/v2/organizations/get-organization-member-roles

  """
  @spec list_roles(id, user_id, map(), config) ::
          {:ok, list(map()) | map()} | error
  def list_roles(id, user_id, %{} = params, %Config{} = config) do
    Members.Roles.List.execute(id, user_id, params, config)
  end

  @doc """
  Remove one or more Organization-specific roles from a given user.

  ## see
  https://auth0.com/docs/api/management/v2/organizations/delete-organization-member-roles

  """
  @spec delete_roles(id, user_id, map(), config) ::
          {:ok, String.t()} | error
  def delete_roles(id, user_id, %{} = params, %Config{} = config) do
    Members.Roles.Delete.execute(id, user_id, params, config)
  end

  @doc """
  Assign one or more roles to a user to determine their access for a specific Organization.

  ## see
  https://auth0.com/docs/api/management/v2/organizations/post-organization-member-roles

  """
  @spec assign_roles(id, user_id, map(), config) ::
          {:ok, String.t()} | error
  def assign_roles(id, user_id, %{} = params, %Config{} = config) do
    Members.Roles.Add.execute(id, user_id, params, config)
  end
end
