defmodule Auth0.Management.Connections do
  @moduledoc """
  Facade for the Auth0 Management API Connections endpoints.

  Most applications should call `Auth0.Api.Management` instead of this module.
  """

  alias Auth0.Config
  alias Auth0.Management.Connections.List
  alias Auth0.Management.Connections.Create
  alias Auth0.Management.Connections.Get
  alias Auth0.Management.Connections.Delete
  alias Auth0.Management.Connections.Patch
  alias Auth0.Management.Connections.ScimConfiguration
  alias Auth0.Management.Connections.Status
  alias Auth0.Management.Connections.Users

  alias Auth0.Management.Connections.DirectoryProvisionings.List,
    as: ConnectionsDirectoryProvisioningsList

  alias Auth0.Management.Connections.ScimConfigurations.List,
    as: ConnectionsScimConfigurationsList

  alias Auth0.Management.Connections.Clients.Get, as: ConnectionsClientsGet
  alias Auth0.Management.Connections.Clients.Patch, as: ConnectionsClientsPatch

  alias Auth0.Management.Connections.DirectoryProvisioning.Get,
    as: ConnectionsDirectoryProvisioningGet

  alias Auth0.Management.Connections.DirectoryProvisioning.Create,
    as: ConnectionsDirectoryProvisioningCreate

  alias Auth0.Management.Connections.DirectoryProvisioning.Patch,
    as: ConnectionsDirectoryProvisioningPatch

  alias Auth0.Management.Connections.DirectoryProvisioning.Delete,
    as: ConnectionsDirectoryProvisioningDelete

  alias Auth0.Management.Connections.DirectoryProvisioning.DefaultMapping.Get,
    as: ConnectionsDirectoryProvisioningDefaultMappingGet

  alias Auth0.Management.Connections.DirectoryProvisioning.Synchronizations.Create,
    as: ConnectionsDirectoryProvisioningSynchronizationsCreate

  alias Auth0.Management.Connections.DirectoryProvisioning.SynchronizedGroups.List,
    as: ConnectionsDirectoryProvisioningSynchronizedGroupsList

  alias Auth0.Management.Connections.DirectoryProvisioning.SynchronizedGroups.Add,
    as: ConnectionsDirectoryProvisioningSynchronizedGroupsAdd

  alias Auth0.Management.Connections.DirectoryProvisioning.SynchronizedGroups.Put,
    as: ConnectionsDirectoryProvisioningSynchronizedGroupsPut

  alias Auth0.Management.Connections.DirectoryProvisioning.SynchronizedGroups.Delete,
    as: ConnectionsDirectoryProvisioningSynchronizedGroupsDelete

  alias Auth0.Management.Connections.Keys.Get, as: ConnectionsKeysGet
  alias Auth0.Management.Connections.Keys.Create, as: ConnectionsKeysCreate
  alias Auth0.Management.Connections.Keys.Rotate, as: ConnectionsKeysRotate

  @type id :: String.t()
  @type token_id :: String.t()
  @type config :: Config.t()
  @type error :: {:error, integer, term} | {:error, term}

  @doc """
  Retrieves detailed list of all connections that match the specified strategy. If no strategy is provided, all connections within your tenant are retrieved. This action can accept a list of fields to include or exclude from the resulting list of connections.

  ## see
  https://auth0.com/docs/api/management/v2/connections/get-connections

  """
  @spec list(map(), config) ::
          {:ok, list(map()) | map()} | error
  def list(%{} = params, %Config{} = config) do
    List.execute(params, config)
  end

  @doc """
  Creates a new connection according to the JSON object received in body.

  ## see
  https://auth0.com/docs/api/management/v2/connections/post-connections

  """
  @spec create(map(), config) ::
          {:ok, map()} | error
  def create(%{} = params, %Config{} = config) do
    Create.execute(params, config)
  end

  @doc """
  Retrieve details for a specified connection along with options that can be used for identity provider configuration.

  ## see
  https://auth0.com/docs/api/management/v2/connections/get-connections-by-id

  """
  @spec get(id, map(), config) ::
          {:ok, map()} | error
  def get(id, %{} = params, %Config{} = config) do
    Get.execute(id, params, config)
  end

  @doc """
  Removes a specific connection from your tenant. This action cannot be undone. Once removed, users can no longer use this connection to authenticate.

  ## see
  https://auth0.com/docs/api/management/v2/connections/delete-connections-by-id

  """
  @spec delete(id, config) :: {:ok, String.t()} | error
  def delete(id, %Config{} = config) do
    Delete.execute(id, config)
  end

  @doc """
  Update details for a specific connection, including option properties for identity provider configuration.

  ## see
  https://auth0.com/docs/api/management/v2/connections/patch-connections-by-id

  """
  @spec update(id, map(), config) ::
          {:ok, map()} | error
  def update(id, %{} = params, %Config{} = config) do
    Patch.execute(id, params, config)
  end

  @doc """
  Retrieves a scim configuration by its connectionId.

  ## see
  https://auth0.com/docs/api/management/v2/connections/get-scim-configuration

  """
  @spec get_scim_configuration(id, config) :: {:ok, map()} | error
  def get_scim_configuration(id, %Config{} = config) do
    ScimConfiguration.Get.execute(id, config)
  end

  @doc """
  Deletes a scim configuration by its connectionId.

  ## see
  https://auth0.com/docs/api/management/v2/connections/delete-scim-configuration

  """
  @spec delete_scim_configuration(id, config) :: {:ok, String.t()} | error
  def delete_scim_configuration(id, %Config{} = config) do
    ScimConfiguration.Delete.execute(id, config)
  end

  @doc """
  Update a scim configuration by its connectionId.

  ## see
  https://auth0.com/docs/api/management/v2/connections/patch-scim-configuration

  """
  @spec update_scim_configuration(id, map(), config) :: {:ok, map()} | error
  def update_scim_configuration(id, %{} = params, %Config{} = config) do
    ScimConfiguration.Patch.execute(id, params, config)
  end

  @doc """
  Create a scim configuration for a connection.

  ## see
  https://auth0.com/docs/api/management/v2/connections/post-scim-configuration

  """
  @spec create_scim_configuration(id, map(), config) :: {:ok, map()} | error
  def create_scim_configuration(id, %{} = params, %Config{} = config) do
    ScimConfiguration.Create.execute(id, params, config)
  end

  @doc """
  Retrieves a scim configuration's default mapping by its connectionId.

  ## see
  https://auth0.com/docs/api/management/v2/connections/get-default-mapping

  """
  @spec get_scim_configuration_default_mapping(id, config) :: {:ok, map()} | error
  def get_scim_configuration_default_mapping(id, %Config{} = config) do
    ScimConfiguration.DefaultMapping.Get.execute(id, config)
  end

  @doc """
  Retrieves all scim tokens by its connection id.

  ## see
  https://auth0.com/docs/api/management/v2/connections/get-scim-tokens

  """
  @spec get_scim_configuration_tokens(id, config) :: {:ok, list(map())} | error
  def get_scim_configuration_tokens(id, %Config{} = config) do
    ScimConfiguration.Tokens.Get.execute(id, config)
  end

  @doc """
  Create a scim token for a scim client.

  ## see
  https://auth0.com/docs/api/management/v2/connections/post-scim-token

  """
  @spec create_scim_configuration_tokens(id, map(), config) :: {:ok, map()} | error
  def create_scim_configuration_tokens(id, %{} = params, %Config{} = config) do
    ScimConfiguration.Tokens.Create.execute(id, params, config)
  end

  @doc """
  Deletes a scim token by its connection id and tokenId.

  ## see
  https://auth0.com/docs/api/management/v2/connections/delete-tokens-by-token-id

  """
  @spec delete_scim_configuration_tokens(id, token_id, config) :: {:ok, String.t()} | error
  def delete_scim_configuration_tokens(id, token_id, %Config{} = config) do
    ScimConfiguration.Tokens.Delete.execute(id, token_id, config)
  end

  @doc """
  Retrieves the status of an ad/ldap connection referenced by its ID. 200 OK http status code response is returned when the connection is online, otherwise a 404 status code is returned along with an error message

  ## see
  https://auth0.com/docs/api/management/v2/connections/get-status

  """
  @spec get_status(id, config) :: {:ok, map()} | error
  def get_status(id, %Config{} = config) do
    Status.execute(id, config)
  end

  @doc """
  Deletes a specified connection user by its email (you cannot delete all users from specific connection). Currently, only Database Connections are supported.

  ## see
  https://auth0.com/docs/api/management/v2/connections/delete-users-by-email

  """
  @spec delete_users(id, map(), config) ::
          {:ok, String.t()} | error
  def delete_users(id, %{} = params, %Config{} = config) do
    Users.Delete.execute(id, params, config)
  end

  @doc """
  Get a list of directory provisioning configurations.

  Retrieve a list of directory provisioning configurations of a tenant.

  ## see
  https://auth0.com/docs/api/management/v2/connections-directory-provisionings/get-connections-directory-provisionings

  """
  @spec list_directory_provisionings(map(), config) :: {:ok, map()} | error
  def list_directory_provisionings(%{} = params, %Config{} = config) do
    ConnectionsDirectoryProvisioningsList.execute(params, config)
  end

  @doc """
  Get a list of SCIM configurations.

  Retrieve a list of SCIM configurations of a tenant.

  ## see
  https://auth0.com/docs/api/management/v2/connections-scim-configurations/get-connections-scim-configurations

  """
  @spec list_scim_configurations(map(), config) :: {:ok, map()} | error
  def list_scim_configurations(%{} = params, %Config{} = config) do
    ConnectionsScimConfigurationsList.execute(params, config)
  end

  @doc """
  Get enabled clients for a connection.

  Retrieve all clients that have the specified [connection](https://auth0.com/docs/authenticate/identity-providers) enabled.

  ## see
  https://auth0.com/docs/api/management/v2/connections/get-connection-clients

  """
  @spec get_clients(String.t(), map(), config) :: {:ok, map()} | error
  def get_clients(id, %{} = params, %Config{} = config) do
    ConnectionsClientsGet.execute(id, params, config)
  end

  @doc """
  Update enabled clients for a connection.

  ## see
  https://auth0.com/docs/api/management/v2/connections/patch-clients

  """
  @spec update_clients(String.t(), list(map()), config) :: {:ok, String.t()} | error
  def update_clients(id, params, %Config{} = config) when is_list(params) do
    ConnectionsClientsPatch.execute(id, params, config)
  end

  @doc """
  Get a directory provisioning configuration.

  Retrieve the directory provisioning configuration of a connection.

  ## see
  https://auth0.com/docs/api/management/v2/connections/get-directory-provisioning

  """
  @spec get_directory_provisioning(String.t(), config) :: {:ok, map()} | error
  def get_directory_provisioning(id, %Config{} = config) do
    ConnectionsDirectoryProvisioningGet.execute(id, config)
  end

  @doc """
  Create a directory provisioning configuration.

  Create a directory provisioning configuration for a connection.

  ## see
  https://auth0.com/docs/api/management/v2/connections/post-directory-provisioning

  """
  @spec create_directory_provisioning(String.t(), map(), config) :: {:ok, map()} | error
  def create_directory_provisioning(id, %{} = params, %Config{} = config) do
    ConnectionsDirectoryProvisioningCreate.execute(id, params, config)
  end

  @doc """
  Patch a directory provisioning configuration.

  Update the directory provisioning configuration of a connection.

  ## see
  https://auth0.com/docs/api/management/v2/connections/patch-directory-provisioning

  """
  @spec update_directory_provisioning(String.t(), map(), config) :: {:ok, map()} | error
  def update_directory_provisioning(id, %{} = params, %Config{} = config) do
    ConnectionsDirectoryProvisioningPatch.execute(id, params, config)
  end

  @doc """
  Delete a directory provisioning configuration.

  Delete the directory provisioning configuration of a connection.

  ## see
  https://auth0.com/docs/api/management/v2/connections/delete-directory-provisioning

  """
  @spec delete_directory_provisioning(String.t(), config) :: {:ok, String.t()} | error
  def delete_directory_provisioning(id, %Config{} = config) do
    ConnectionsDirectoryProvisioningDelete.execute(id, config)
  end

  @doc """
  Get a connection's default directory provisioning attribute mapping.

  Retrieve the directory provisioning default attribute mapping of a connection.

  ## see
  https://auth0.com/docs/api/management/v2/connections/get-directory-provisioning-default-mapping

  """
  @spec get_directory_provisioning_default_mapping(String.t(), config) :: {:ok, map()} | error
  def get_directory_provisioning_default_mapping(id, %Config{} = config) do
    ConnectionsDirectoryProvisioningDefaultMappingGet.execute(id, config)
  end

  @doc """
  Request an on-demand synchronization of the directory.

  ## see
  https://auth0.com/docs/api/management/v2/connections/post-synchronizations

  """
  @spec create_directory_provisioning_synchronization(String.t(), config) :: {:ok, map()} | error
  def create_directory_provisioning_synchronization(id, %Config{} = config) do
    ConnectionsDirectoryProvisioningSynchronizationsCreate.execute(id, config)
  end

  @doc """
  Get synchronized groups for a directory provisioning configuration.

  Retrieve the configured synchronized groups for a connection directory provisioning configuration.

  ## see
  https://auth0.com/docs/api/management/v2/connections/get-synchronized-groups

  """
  @spec list_directory_provisioning_synchronized_groups(String.t(), map(), config) ::
          {:ok, map()} | error
  def list_directory_provisioning_synchronized_groups(id, %{} = params, %Config{} = config) do
    ConnectionsDirectoryProvisioningSynchronizedGroupsList.execute(id, params, config)
  end

  @doc """
  Add synchronized group selections to a directory provisioning configuration.

  ## see
  https://auth0.com/docs/api/management/v2/connections/post-synchronized-groups

  """
  @spec add_directory_provisioning_synchronized_groups(String.t(), map(), config) ::
          {:ok, String.t()} | error
  def add_directory_provisioning_synchronized_groups(id, %{} = params, %Config{} = config) do
    ConnectionsDirectoryProvisioningSynchronizedGroupsAdd.execute(id, params, config)
  end

  @doc """
  Create or replace synchronized group selections for a directory provisioning configuration.

  Create or replace the selected groups for a connection directory provisioning configuration.

  ## see
  https://auth0.com/docs/api/management/v2/connections/put-synchronized-groups

  """
  @spec set_directory_provisioning_synchronized_groups(String.t(), map(), config) ::
          {:ok, String.t()} | error
  def set_directory_provisioning_synchronized_groups(id, %{} = params, %Config{} = config) do
    ConnectionsDirectoryProvisioningSynchronizedGroupsPut.execute(id, params, config)
  end

  @doc """
  Delete synchronized group selections for a directory provisioning configuration.

  ## see
  https://auth0.com/docs/api/management/v2/connections/delete-synchronized-groups

  """
  @spec delete_directory_provisioning_synchronized_groups(String.t(), map(), config) ::
          {:ok, String.t()} | error
  def delete_directory_provisioning_synchronized_groups(id, %{} = params, %Config{} = config) do
    ConnectionsDirectoryProvisioningSynchronizedGroupsDelete.execute(id, params, config)
  end

  @doc """
  Get connection keys.

  Gets the connection keys for the Okta or OIDC connection strategy.

  ## see
  https://auth0.com/docs/api/management/v2/connections/get-keys

  """
  @spec get_keys(String.t(), config) :: {:ok, list(map())} | error
  def get_keys(id, %Config{} = config) do
    ConnectionsKeysGet.execute(id, config)
  end

  @doc """
  Create connection keys.

  Provision initial connection keys for Okta or OIDC connection strategies. This endpoint allows you to create keys before configuring the connection to use Private Key JWT authentication, enabling zero-downtime transitions.

  ## see
  https://auth0.com/docs/api/management/v2/connections/post-keys

  """
  @spec create_keys(String.t(), map(), config) :: {:ok, list(map())} | error
  def create_keys(id, %{} = params, %Config{} = config) do
    ConnectionsKeysCreate.execute(id, params, config)
  end

  @doc """
  Rotate connection keys.

  Rotates the connection keys for the Okta or OIDC connection strategies.

  ## see
  https://auth0.com/docs/api/management/v2/connections/post-rotate

  """
  @spec rotate_keys(String.t(), map(), config) :: {:ok, map()} | error
  def rotate_keys(id, %{} = params, %Config{} = config) do
    ConnectionsKeysRotate.execute(id, params, config)
  end
end
