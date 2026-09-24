defmodule Auth0.Management.Organizations do
  @moduledoc """
  Facade for the Auth0 Management API Organizations endpoints.

  Most applications should call `Auth0.Api.Management` instead of this module.
  """

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
  alias Auth0.Management.Organizations.Search, as: OrganizationsSearch
  alias Auth0.Management.Organizations.ClientGrants.List, as: OrganizationsClientGrantsList
  alias Auth0.Management.Organizations.ClientGrants.Create, as: OrganizationsClientGrantsCreate
  alias Auth0.Management.Organizations.ClientGrants.Delete, as: OrganizationsClientGrantsDelete
  alias Auth0.Management.Organizations.Clients.List, as: OrganizationsClientsList
  alias Auth0.Management.Organizations.Clients.Create, as: OrganizationsClientsCreate
  alias Auth0.Management.Organizations.Clients.DeleteAll, as: OrganizationsClientsDeleteAll
  alias Auth0.Management.Organizations.Clients.Get, as: OrganizationsClientsGet
  alias Auth0.Management.Organizations.Clients.Patch, as: OrganizationsClientsPatch
  alias Auth0.Management.Organizations.Connections.List, as: OrganizationsConnectionsList
  alias Auth0.Management.Organizations.Connections.Create, as: OrganizationsConnectionsCreate
  alias Auth0.Management.Organizations.Connections.Get, as: OrganizationsConnectionsGet
  alias Auth0.Management.Organizations.Connections.Patch, as: OrganizationsConnectionsPatch
  alias Auth0.Management.Organizations.Connections.Delete, as: OrganizationsConnectionsDelete

  alias Auth0.Management.Organizations.DiscoveryDomains.List,
    as: OrganizationsDiscoveryDomainsList

  alias Auth0.Management.Organizations.DiscoveryDomains.Create,
    as: OrganizationsDiscoveryDomainsCreate

  alias Auth0.Management.Organizations.DiscoveryDomains.GetByName,
    as: OrganizationsDiscoveryDomainsGetByName

  alias Auth0.Management.Organizations.DiscoveryDomains.Get, as: OrganizationsDiscoveryDomainsGet

  alias Auth0.Management.Organizations.DiscoveryDomains.Patch,
    as: OrganizationsDiscoveryDomainsPatch

  alias Auth0.Management.Organizations.DiscoveryDomains.Delete,
    as: OrganizationsDiscoveryDomainsDelete

  alias Auth0.Management.Organizations.Members.EffectiveRoles.List,
    as: OrganizationsMembersEffectiveRolesList

  alias Auth0.Management.Organizations.Members.EffectiveRoles.Sources.Groups.List,
    as: OrganizationsMembersEffectiveRolesSourcesGroupsList

  alias Auth0.Management.Organizations.Roles.Members.List, as: OrganizationsRolesMembersList
  alias Auth0.Management.Organizations.Groups.List, as: OrganizationsGroupsList
  alias Auth0.Management.Organizations.Groups.Roles.List, as: OrganizationsGroupsRolesList
  alias Auth0.Management.Organizations.Groups.Roles.Assign, as: OrganizationsGroupsRolesAssign
  alias Auth0.Management.Organizations.Groups.Roles.Remove, as: OrganizationsGroupsRolesRemove
  alias Auth0.Management.Organizations.Roles.Groups.List, as: OrganizationsRolesGroupsList

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
  @spec create_invitation(id, map(), config, keyword()) ::
          {:ok, map()} | error
  def create_invitation(id, %{} = params, %Config{} = config, opts \\ []) do
    Invitations.Create.execute(id, params, config, opts)
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

  @doc """
  Search organizations.

  Retrieve details of organizations matching a search criteria. It is possible to:

  **Early Access**: this endpoint is marked as Early Access (`x-release-lifecycle: EA`) in the Auth0 Management API specification and may not be available on every tenant.

  ## see
  https://auth0.com/docs/api/management/v2/organizations/get-search

  """
  @spec search(map(), config) :: {:ok, map() | list(map())} | error
  def search(%{} = params, %Config{} = config) do
    OrganizationsSearch.execute(params, config)
  end

  @doc """
  Get client grants associated to an organization.

  ## see
  https://auth0.com/docs/api/management/v2/organizations/get-organization-client-grants

  """
  @spec list_client_grants(String.t(), map(), config) :: {:ok, map() | list(map())} | error
  def list_client_grants(id, %{} = params, %Config{} = config) do
    OrganizationsClientGrantsList.execute(id, params, config)
  end

  @doc """
  Associate a client grant with an organization.

  ## see
  https://auth0.com/docs/api/management/v2/organizations/create-organization-client-grants

  """
  @spec create_client_grant(String.t(), map(), config) :: {:ok, map()} | error
  def create_client_grant(id, %{} = params, %Config{} = config) do
    OrganizationsClientGrantsCreate.execute(id, params, config)
  end

  @doc """
  Remove a client grant from an organization.

  ## see
  https://auth0.com/docs/api/management/v2/organizations/delete-client-grants-by-grant-id

  """
  @spec delete_client_grant(String.t(), String.t(), config) :: {:ok, String.t()} | error
  def delete_client_grant(id, grant_id, %Config{} = config) do
    OrganizationsClientGrantsDelete.execute(id, grant_id, config)
  end

  @doc """
  List organization client associations.

  List all clients associated with an organization, using checkpoint pagination. Note: The first time you call this endpoint, omit the from parameter. If there are more results, a next value is included in the response. You can use this for subsequent API calls. When next is no longer included in the response, no further results are remaining.

  **Early Access**: this endpoint is marked as Early Access (`x-release-lifecycle: EA`) in the Auth0 Management API specification and may not be available on every tenant.

  ## see
  https://auth0.com/docs/api/management/v2/organizations/get-organization-clients

  """
  @spec list_clients(String.t(), map(), config) :: {:ok, map()} | error
  def list_clients(id, %{} = params, %Config{} = config) do
    OrganizationsClientsList.execute(id, params, config)
  end

  @doc """
  Associate clients with an organization.

  Associate one or more clients with an organization.

  **Early Access**: this endpoint is marked as Early Access (`x-release-lifecycle: EA`) in the Auth0 Management API specification and may not be available on every tenant.

  ## see
  https://auth0.com/docs/api/management/v2/organizations/post-organization-clients

  """
  @spec create_clients(String.t(), map(), config) :: {:ok, list(map())} | error
  def create_clients(id, %{} = params, %Config{} = config) do
    OrganizationsClientsCreate.execute(id, params, config)
  end

  @doc """
  Remove client associations from an organization.

  Remove one or more client associations from an organization.

  **Early Access**: this endpoint is marked as Early Access (`x-release-lifecycle: EA`) in the Auth0 Management API specification and may not be available on every tenant.

  ## see
  https://auth0.com/docs/api/management/v2/organizations/delete-organization-clients

  """
  @spec delete_clients(String.t(), map(), config) :: {:ok, String.t()} | error
  def delete_clients(id, %{} = params, %Config{} = config) do
    OrganizationsClientsDeleteAll.execute(id, params, config)
  end

  @doc """
  Get an organization client association.

  Get a specific client association for an organization.

  **Early Access**: this endpoint is marked as Early Access (`x-release-lifecycle: EA`) in the Auth0 Management API specification and may not be available on every tenant.

  ## see
  https://auth0.com/docs/api/management/v2/organizations/get-organization-client

  """
  @spec get_client(String.t(), String.t(), config) :: {:ok, map()} | error
  def get_client(id, client_id, %Config{} = config) do
    OrganizationsClientsGet.execute(id, client_id, config)
  end

  @doc """
  Update an organization client association.

  **Early Access**: this endpoint is marked as Early Access (`x-release-lifecycle: EA`) in the Auth0 Management API specification and may not be available on every tenant.

  ## see
  https://auth0.com/docs/api/management/v2/organizations/patch-organization-client

  """
  @spec update_client(String.t(), String.t(), map(), config) :: {:ok, map()} | error
  def update_client(id, client_id, %{} = params, %Config{} = config) do
    OrganizationsClientsPatch.execute(id, client_id, params, config)
  end

  @doc """
  Get connections associated with an organization.

  **Early Access**: this endpoint is marked as Early Access (`x-release-lifecycle: EA`) in the Auth0 Management API specification and may not be available on every tenant.

  ## see
  https://auth0.com/docs/api/management/v2/organizations/get-organization-connections

  """
  @spec list_associated_connections(String.t(), map(), config) ::
          {:ok, map() | list(map())} | error
  def list_associated_connections(id, %{} = params, %Config{} = config) do
    OrganizationsConnectionsList.execute(id, params, config)
  end

  @doc """
  Add a connection to an organization.

  **Early Access**: this endpoint is marked as Early Access (`x-release-lifecycle: EA`) in the Auth0 Management API specification and may not be available on every tenant.

  ## see
  https://auth0.com/docs/api/management/v2/organizations/post-organization-connection

  """
  @spec create_associated_connection(String.t(), map(), config) :: {:ok, map()} | error
  def create_associated_connection(id, %{} = params, %Config{} = config) do
    OrganizationsConnectionsCreate.execute(id, params, config)
  end

  @doc """
  Get a specific connection associated with an organization.

  **Early Access**: this endpoint is marked as Early Access (`x-release-lifecycle: EA`) in the Auth0 Management API specification and may not be available on every tenant.

  ## see
  https://auth0.com/docs/api/management/v2/organizations/get-organization-connection

  """
  @spec get_associated_connection(String.t(), String.t(), config) :: {:ok, map()} | error
  def get_associated_connection(id, connection_id, %Config{} = config) do
    OrganizationsConnectionsGet.execute(id, connection_id, config)
  end

  @doc """
  Update a connection for an organization.

  **Early Access**: this endpoint is marked as Early Access (`x-release-lifecycle: EA`) in the Auth0 Management API specification and may not be available on every tenant.

  ## see
  https://auth0.com/docs/api/management/v2/organizations/patch-organization-connection

  """
  @spec update_associated_connection(String.t(), String.t(), map(), config) ::
          {:ok, map()} | error
  def update_associated_connection(id, connection_id, %{} = params, %Config{} = config) do
    OrganizationsConnectionsPatch.execute(id, connection_id, params, config)
  end

  @doc """
  Delete a connection from an organization.

  **Early Access**: this endpoint is marked as Early Access (`x-release-lifecycle: EA`) in the Auth0 Management API specification and may not be available on every tenant.

  ## see
  https://auth0.com/docs/api/management/v2/organizations/delete-organization-connection

  """
  @spec delete_associated_connection(String.t(), String.t(), config) :: {:ok, String.t()} | error
  def delete_associated_connection(id, connection_id, %Config{} = config) do
    OrganizationsConnectionsDelete.execute(id, connection_id, config)
  end

  @doc """
  Retrieve all organization discovery domains.

  Retrieve list of all organization discovery domains associated with the specified organization. This endpoint is subject to eventual consistency; newly created, updated, or deleted discovery domains may not immediately appear in the response.

  ## see
  https://auth0.com/docs/api/management/v2/organizations/get-discovery-domains

  """
  @spec list_discovery_domains(String.t(), map(), config) :: {:ok, map()} | error
  def list_discovery_domains(id, %{} = params, %Config{} = config) do
    OrganizationsDiscoveryDomainsList.execute(id, params, config)
  end

  @doc """
  Create an organization discovery domain.

  Create a new discovery domain for an organization.

  ## see
  https://auth0.com/docs/api/management/v2/organizations/post-discovery-domains

  """
  @spec create_discovery_domain(String.t(), map(), config) :: {:ok, map()} | error
  def create_discovery_domain(id, %{} = params, %Config{} = config) do
    OrganizationsDiscoveryDomainsCreate.execute(id, params, config)
  end

  @doc """
  Retrieve an organization discovery domain by domain name.

  Retrieve details about a single organization discovery domain specified by domain name. This endpoint is subject to eventual consistency; newly created, updated, or deleted discovery domains may not immediately appear in the response.

  ## see
  https://auth0.com/docs/api/management/v2/organizations/get-name-by-discovery-domain

  """
  @spec get_discovery_domain_by_name(String.t(), String.t(), config) :: {:ok, map()} | error
  def get_discovery_domain_by_name(id, discovery_domain, %Config{} = config) do
    OrganizationsDiscoveryDomainsGetByName.execute(id, discovery_domain, config)
  end

  @doc """
  Retrieve an organization discovery domain by ID.

  Retrieve details about a single organization discovery domain specified by ID. This endpoint is subject to eventual consistency; newly created, updated, or deleted discovery domains may not immediately appear in the response.

  ## see
  https://auth0.com/docs/api/management/v2/organizations/get-discovery-domains-by-discovery-domain-id

  """
  @spec get_discovery_domain(String.t(), String.t(), config) :: {:ok, map()} | error
  def get_discovery_domain(id, discovery_domain_id, %Config{} = config) do
    OrganizationsDiscoveryDomainsGet.execute(id, discovery_domain_id, config)
  end

  @doc """
  Update an organization discovery domain.

  Update the verification status and/or use_for_organization_discovery for an organization discovery domain. The `status` field must be either `pending` or `verified`. The `use_for_organization_discovery` field can be `true` or `false` (default: `true`).

  ## see
  https://auth0.com/docs/api/management/v2/organizations/patch-discovery-domains-by-discovery-domain-id

  """
  @spec update_discovery_domain(String.t(), String.t(), map(), config) :: {:ok, map()} | error
  def update_discovery_domain(id, discovery_domain_id, %{} = params, %Config{} = config) do
    OrganizationsDiscoveryDomainsPatch.execute(id, discovery_domain_id, params, config)
  end

  @doc """
  Delete an organization discovery domain.

  Remove a discovery domain from an organization. This action cannot be undone.

  ## see
  https://auth0.com/docs/api/management/v2/organizations/delete-discovery-domains-by-discovery-domain-id

  """
  @spec delete_discovery_domain(String.t(), String.t(), config) :: {:ok, String.t()} | error
  def delete_discovery_domain(id, discovery_domain_id, %Config{} = config) do
    OrganizationsDiscoveryDomainsDelete.execute(id, discovery_domain_id, config)
  end

  @doc """
  List organization member effective roles.

  Lists the roles assigned to an organization member directly or through group membership.

  ## see
  https://auth0.com/docs/api/management/v2/organizations/get-organization-member-effective-roles

  """
  @spec list_member_effective_roles(String.t(), String.t(), map(), config) :: {:ok, map()} | error
  def list_member_effective_roles(id, user_id, %{} = params, %Config{} = config) do
    OrganizationsMembersEffectiveRolesList.execute(id, user_id, params, config)
  end

  @doc """
  List organization member role group sources.

  Lists the groups which grant the org member a given role.

  ## see
  https://auth0.com/docs/api/management/v2/organizations/get-organization-member-role-source-groups

  """
  @spec list_member_effective_role_group_sources(String.t(), String.t(), map(), config) ::
          {:ok, map()} | error
  def list_member_effective_role_group_sources(id, user_id, %{} = params, %Config{} = config) do
    OrganizationsMembersEffectiveRolesSourcesGroupsList.execute(id, user_id, params, config)
  end

  @doc """
  List the members assigned to a role in the context of an organization.

  List the organization members assigned a specific role within the context of an organization. Note: Returns only members with direct role assignments. For groups assigned to this role within the organization, use GET /api/v2/organizations/{organization_id}/roles/{role_id}/groups.

  **Early Access**: this endpoint is marked as Early Access (`x-release-lifecycle: EA`) in the Auth0 Management API specification and may not be available on every tenant.

  ## see
  https://auth0.com/docs/api/management/v2/organizations/get-organization-role-members

  """
  @spec list_role_members(String.t(), String.t(), map(), config) :: {:ok, map()} | error
  def list_role_members(id, role_id, %{} = params, %Config{} = config) do
    OrganizationsRolesMembersList.execute(id, role_id, params, config)
  end

  @doc """
  List the groups that are assigned to the organization.

  Lists the groups that are assigned to the specified organization.

  ## see
  https://auth0.com/docs/api/management/v2/organizations/get-organization-groups

  """
  @spec list_groups(String.t(), map(), config) :: {:ok, map()} | error
  def list_groups(organization_id, %{} = params, %Config{} = config) do
    OrganizationsGroupsList.execute(organization_id, params, config)
  end

  @doc """
  List the roles assigned to a group in the context of an organization.

  Lists the roles assigned to the specified group in the context of an organization.

  ## see
  https://auth0.com/docs/api/management/v2/organizations/get-organization-group-roles

  """
  @spec list_group_roles(String.t(), String.t(), map(), config) :: {:ok, map()} | error
  def list_group_roles(organization_id, group_id, %{} = params, %Config{} = config) do
    OrganizationsGroupsRolesList.execute(organization_id, group_id, params, config)
  end

  @doc """
  Assign roles to a group in an organization context.

  Assign one or more roles to a specified group in the context of an organization.

  ## see
  https://auth0.com/docs/api/management/v2/organizations/post-organization-group-roles

  """
  @spec assign_group_roles(String.t(), String.t(), map(), config) :: {:ok, String.t()} | error
  def assign_group_roles(organization_id, group_id, %{} = params, %Config{} = config) do
    OrganizationsGroupsRolesAssign.execute(organization_id, group_id, params, config)
  end

  @doc """
  Remove roles assigned to a group in an organization context.

  Unassign one or more roles from a specified group in the context of an organization.

  ## see
  https://auth0.com/docs/api/management/v2/organizations/delete-organization-group-roles

  """
  @spec remove_group_roles(String.t(), String.t(), map(), config) :: {:ok, String.t()} | error
  def remove_group_roles(organization_id, group_id, %{} = params, %Config{} = config) do
    OrganizationsGroupsRolesRemove.execute(organization_id, group_id, params, config)
  end

  @doc """
  List the groups assigned to a role in the context of an organization.

  Retrieve the list of groups assigned to a role in the context of an organization.

  **Early Access**: this endpoint is marked as Early Access (`x-release-lifecycle: EA`) in the Auth0 Management API specification and may not be available on every tenant.

  ## see
  https://auth0.com/docs/api/management/v2/organizations/get-organization-role-groups

  """
  @spec list_role_groups(String.t(), String.t(), map(), config) :: {:ok, map()} | error
  def list_role_groups(organization_id, role_id, %{} = params, %Config{} = config) do
    OrganizationsRolesGroupsList.execute(organization_id, role_id, params, config)
  end
end
