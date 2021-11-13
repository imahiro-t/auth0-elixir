defmodule Auth0.Management do
  @moduledoc """
  Documentation for Auth0 Management API.

  """

  alias Auth0.Config
  alias Auth0.Entity
  alias Auth0.Management.Branding
  alias Auth0.Management.ClientGrants
  alias Auth0.Management.Clients
  alias Auth0.Management.Connections
  alias Auth0.Management.CustomDomains
  alias Auth0.Management.DeviceCredentials
  alias Auth0.Management.Grants
  alias Auth0.Management.Hooks
  alias Auth0.Management.LogStreams
  alias Auth0.Management.Logs
  alias Auth0.Management.Organizations
  alias Auth0.Management.Prompts
  alias Auth0.Management.ResourceServers
  alias Auth0.Management.Roles
  alias Auth0.Management.Rules
  alias Auth0.Management.RulesConfigs
  alias Auth0.Management.UserBlocks
  alias Auth0.Management.Users
  alias Auth0.Management.UsersByEmail
  alias Auth0.Management.Actions
  alias Auth0.Management.Blacklist
  alias Auth0.Management.EmailTemplates
  alias Auth0.Management.Emails
  alias Auth0.Management.Guardian
  alias Auth0.Management.Jobs
  alias Auth0.Management.Keys
  alias Auth0.Management.Stats
  alias Auth0.Management.Tenants
  alias Auth0.Management.Anomaly
  alias Auth0.Management.Tickets

  @type config :: Config.t()
  @type id :: String.t()
  @type name :: String.t()
  @type invitation_id :: String.t()
  @type connection_id :: String.t()
  @type user_id :: String.t()
  @type prompt :: String.t()
  @type language :: String.t()
  @type key :: String.t()
  @type action_id :: String.t()
  @type trigger_id :: String.t()
  @type template_name :: String.t()
  @type kid :: String.t()
  @type ip :: String.t()
  @type response_body :: String.t()
  @type error :: {:error, integer, term} | {:error, term}

  @doc """
  Get branding settings.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Branding/get_branding

  """
  @spec get_branding(config) :: {:ok, Entity.Branding.t(), response_body} | error
  def get_branding(%Config{} = config) do
    Branding.get(config)
  end

  @doc """
  Update branding settings.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Branding/patch_branding

  """
  @spec update_branding(Branding.Patch.Params.t(), config) ::
          {:ok, Entity.Branding.t(), response_body} | error
  def update_branding(%Branding.Patch.Params{} = params, %Config{} = config) do
    Branding.update(params, config)
  end

  @doc """
  Get template for New Universal Login Experience.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Branding/get_universal_login

  """
  @spec get_template_for_universal_login(config) ::
          {:ok, Entity.UniversalLogin.t(), response_body} | error
  def get_template_for_universal_login(%Config{} = config) do
    Branding.get_universal_login(config)
  end

  @doc """
  Delete template for New Universal Login Experience.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Branding/delete_universal_login

  """
  @spec delete_template_for_universal_login(config) :: {:ok, String.t(), response_body} | error
  def delete_template_for_universal_login(%Config{} = config) do
    Branding.delete_universal_login(config)
  end

  @doc """
  Set template for New Universal Login Experience.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Branding/put_universal_login

  """
  @spec set_template_for_universal_login(Branding.Templates.UniversalLogin.Put.Params.t(), config) ::
          {:ok, String.t(), response_body} | error
  def set_template_for_universal_login(
        %Branding.Templates.UniversalLogin.Put.Params{} = params,
        %Config{} = config
      ) do
    Branding.set_universal_login(params, config)
  end

  @doc """
  Get client grants.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Client_Grants/get_client_grants

  """
  @spec get_client_grants(ClientGrants.List.Params.t(), config) ::
          {:ok, Entity.ClientGrants.t(), response_body} | error
  def get_client_grants(%ClientGrants.List.Params{} = params, %Config{} = config) do
    ClientGrants.list(params, config)
  end

  @doc """
  Create client grant.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Client_Grants/post_client_grants

  """
  @spec create_client_grant(ClientGrants.Create.Params.t(), config) ::
          {:ok, Entity.ClientGrant.t(), response_body} | error
  def create_client_grant(%ClientGrants.Create.Params{} = params, %Config{} = config) do
    ClientGrants.create(params, config)
  end

  @doc """
  Delete client grant.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Client_Grants/delete_client_grants_by_id

  """
  @spec delete_client_grant(id, config) :: {:ok, String.t(), response_body} | error
  def delete_client_grant(id, %Config{} = config) do
    ClientGrants.delete(id, config)
  end

  @doc """
  Update client grant.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Client_Grants/patch_client_grants_by_id

  """
  @spec update_client_grant(id, ClientGrants.Patch.Params.t(), config) ::
          {:ok, Entity.ClientGrant.t(), response_body} | error
  def update_client_grant(id, %ClientGrants.Patch.Params{} = params, %Config{} = config) do
    ClientGrants.update(id, params, config)
  end

  @doc """
  Get clients.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Clients/get_clients

  """
  @spec get_clients(Clients.List.Params.t(), config) ::
          {:ok, Entity.Clients.t(), response_body} | error
  def get_clients(%Clients.List.Params{} = params, %Config{} = config) do
    Clients.list(params, config)
  end

  @doc """
  Create a client.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Clients/post_clients

  """
  @spec create_client(Clients.Create.Params.t(), config) ::
          {:ok, Entity.Client.t(), response_body} | error
  def create_client(%Clients.Create.Params{} = params, %Config{} = config) do
    Clients.create(params, config)
  end

  @doc """
  Get a client.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Clients/get_clients_by_id

  """
  @spec get_client(id, Clients.Get.Params.t(), config) ::
          {:ok, Entity.Client.t(), response_body} | error
  def get_client(id, %Clients.Get.Params{} = params, %Config{} = config) do
    Clients.get(id, params, config)
  end

  @doc """
  Delete a client.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Clients/delete_clients_by_id

  """
  @spec delete_client(id, config) :: {:ok, String.t(), response_body} | error
  def delete_client(id, %Config{} = config) do
    Clients.delete(id, config)
  end

  @doc """
  Update a client.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Clients/patch_clients_by_id

  """
  @spec update_client(id, Clients.Patch.Params.t(), config) ::
          {:ok, Entity.Client.t(), response_body} | error
  def update_client(id, %Clients.Patch.Params{} = params, %Config{} = config) do
    Clients.update(id, params, config)
  end

  @doc """
  Rotate a client secret.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Clients/post_rotate_secret

  """
  @spec rotate_client_secret(id, config) ::
          {:ok, Entity.Client.t(), response_body} | error
  def rotate_client_secret(id, %Config{} = config) do
    Clients.rotate_secret(id, config)
  end

  @doc """
  Get all connections.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Connections/get_connections

  """
  @spec get_connections(Connections.List.Params.t(), config) ::
          {:ok, Entity.Connections.t(), response_body} | error
  def get_connections(%Connections.List.Params{} = params, %Config{} = config) do
    Connections.list(params, config)
  end

  @doc """
  Create a connection.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Connections/post_connections

  """
  @spec create_connection(Connections.Create.Params.t(), config) ::
          {:ok, Entity.Connection.t(), response_body} | error
  def create_connection(%Connections.Create.Params{} = params, %Config{} = config) do
    Connections.create(params, config)
  end

  @doc """
  Get a connection.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Connections/get_connections_by_id

  """
  @spec get_connection(id, Connections.Get.Params.t(), config) ::
          {:ok, Entity.Connection.t(), response_body} | error
  def get_connection(id, %Connections.Get.Params{} = params, %Config{} = config) do
    Connections.get(id, params, config)
  end

  @doc """
  Delete a connection.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Connections/delete_connections_by_id

  """
  @spec delete_connection(id, config) :: {:ok, String.t(), response_body} | error
  def delete_connection(id, %Config{} = config) do
    Connections.delete(id, config)
  end

  @doc """
  Update a connection.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Connections/patch_connections_by_id

  """
  @spec update_connection(id, Connections.Patch.Params.t(), config) ::
          {:ok, Entity.Connection.t(), response_body} | error
  def update_connection(id, %Connections.Patch.Params{} = params, %Config{} = config) do
    Connections.update(id, params, config)
  end

  @doc """
  Check connection status.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Connections/get_status

  """
  @spec get_connection_status(id, config) :: {:ok, boolean, response_body} | error
  def get_connection_status(id, %Config{} = config) do
    Connections.get_status(id, config)
  end

  @doc """
  Delete a connection user.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Connections/delete_users_by_email

  """
  @spec delete_connection_users(id, Connections.Users.Delete.Params.t(), config) ::
          {:ok, String.t(), response_body} | error
  def delete_connection_users(id, %Connections.Users.Delete.Params{} = params, %Config{} = config) do
    Connections.delete_users(id, params, config)
  end

  @doc """
  Get custom domains configurations.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Custom_Domains/get_custom_domains

  """
  @spec get_custom_domain_configurations(config) ::
          {:ok, Entity.CustomDomains.t(), response_body} | error
  def get_custom_domain_configurations(%Config{} = config) do
    CustomDomains.list(config)
  end

  @doc """
  Configure a new custom domain.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Custom_Domains/post_custom_domains

  """
  @spec configure_custom_domain(CustomDomains.Configure.Params.t(), config) ::
          {:ok, Entity.CustomDomain.t(), response_body} | error
  def configure_custom_domain(%CustomDomains.Configure.Params{} = params, %Config{} = config) do
    CustomDomains.configure(params, config)
  end

  @doc """
  Get custom domain configuration.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Custom_Domains/get_custom_domains_by_id

  """
  @spec get_custom_domain_configuration(id, config) ::
          {:ok, Entity.CustomDomain.t(), response_body} | error
  def get_custom_domain_configuration(id, %Config{} = config) do
    CustomDomains.get(id, config)
  end

  @doc """
  Delete custom domain configuration.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Custom_Domains/delete_custom_domains_by_id

  """
  @spec delete_custom_domain_configuration(id, config) :: {:ok, String.t(), response_body} | error
  def delete_custom_domain_configuration(id, %Config{} = config) do
    CustomDomains.delete(id, config)
  end

  @doc """
  Update custom domain configuration.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Custom_Domains/patch_custom_domains_by_id

  """
  @spec update_custom_domain_configuration(id, CustomDomains.Patch.Params.t(), config) ::
          {:ok, Entity.CustomDomain.t(), response_body} | error
  def update_custom_domain_configuration(
        id,
        %CustomDomains.Patch.Params{} = params,
        %Config{} = config
      ) do
    CustomDomains.update(id, params, config)
  end

  @doc """
  Verify a custom domain.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Custom_Domains/post_verify

  """
  @spec verify_custom_domain(id, config) ::
          {:ok, Entity.CustomDomain.t(), response_body} | error
  def verify_custom_domain(id, %Config{} = config) do
    CustomDomains.verify(id, config)
  end

  @doc """
  Retrieve device credentials.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Device_Credentials/get_device_credentials

  """
  @spec get_device_credentials(DeviceCredentials.List.Params.t(), config) ::
          {:ok, Entity.DeviceCredentials.t(), response_body} | error
  def get_device_credentials(%DeviceCredentials.List.Params{} = params, %Config{} = config) do
    DeviceCredentials.list(params, config)
  end

  @doc """
  Create a device public key credential.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Device_Credentials/post_device_credentials

  """
  @spec create_device_credential(DeviceCredentials.Create.Params.t(), config) ::
          {:ok, Entity.DeviceCredential.t(), response_body} | error
  def create_device_credential(%DeviceCredentials.Create.Params{} = params, %Config{} = config) do
    DeviceCredentials.create(params, config)
  end

  @doc """
  Delete a device credential.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Device_Credentials/delete_device_credentials_by_id

  """
  @spec delete_device_credential(id, config) :: {:ok, String.t(), response_body} | error
  def delete_device_credential(id, %Config{} = config) do
    DeviceCredentials.delete(id, config)
  end

  @doc """
  Get grants.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Grants/get_grants

  """
  @spec get_grants(Grants.List.Params.t(), config) ::
          {:ok, Entity.Grants.t(), response_body} | error
  def get_grants(%Grants.List.Params{} = params, %Config{} = config) do
    Grants.list(params, config)
  end

  @doc """
  Delete a grant.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Grants/delete_grants_by_id

  """
  @spec delete_grant(id, config) :: {:ok, String.t(), response_body} | error
  def delete_grant(id, %Config{} = config) do
    Grants.delete(id, config)
  end

  @doc """
  Get hooks.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Hooks/get_hooks

  """
  @spec get_hooks(Hooks.List.Params.t(), config) ::
          {:ok, Entity.Hooks.t(), response_body} | error
  def get_hooks(%Hooks.List.Params{} = params, %Config{} = config) do
    Hooks.list(params, config)
  end

  @doc """
  Create a hook.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Hooks/post_hooks

  """
  @spec create_hook(Hooks.Create.Params.t(), config) ::
          {:ok, Entity.Hook.t(), response_body} | error
  def create_hook(%Hooks.Create.Params{} = params, %Config{} = config) do
    Hooks.create(params, config)
  end

  @doc """
  Get a hook.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Hooks/get_hooks_by_id

  """
  @spec get_hook(id, Hooks.Get.Params.t(), config) ::
          {:ok, Entity.Hook.t(), response_body} | error
  def get_hook(id, %Hooks.Get.Params{} = params, %Config{} = config) do
    Hooks.get(id, params, config)
  end

  @doc """
  Delete a hook.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Hooks/delete_hooks_by_id

  """
  @spec delete_hook(id, config) :: {:ok, String.t(), response_body} | error
  def delete_hook(id, %Config{} = config) do
    Hooks.delete(id, config)
  end

  @doc """
  Update a hook.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Hooks/patch_hooks_by_id

  """
  @spec update_hook(id, Hooks.Patch.Params.t(), config) ::
          {:ok, Entity.Hook.t(), response_body} | error
  def update_hook(id, %Hooks.Patch.Params{} = params, %Config{} = config) do
    Hooks.update(id, params, config)
  end

  @doc """
  Get hook secrets.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Hooks/get_secrets

  """
  @spec get_hook_secrets(id, config) ::
          {:ok, Entity.HookSecret.t(), response_body} | error
  def get_hook_secrets(id, %Config{} = config) do
    Hooks.get_secrets(id, config)
  end

  @doc """
  Delete hook secrets.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Hooks/delete_secrets

  """
  @spec delete_hook_secrets(id, Hooks.Secrets.Delete.Params.t(), config) ::
          {:ok, String.t(), response_body} | error
  def delete_hook_secrets(id, %Hooks.Secrets.Delete.Params{} = params, %Config{} = config) do
    Hooks.delete_secrets(id, params, config)
  end

  @doc """
  Update hook secrets.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Hooks/patch_hooks_by_id

  """
  @spec update_hook_secrets(id, Hooks.Secrets.Patch.Params.t(), config) ::
          {:ok, map, response_body} | error
  def update_hook_secrets(id, %Hooks.Secrets.Patch.Params{} = params, %Config{} = config) do
    Hooks.update_secrets(id, params, config)
  end

  @doc """
  Add hook secrets.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Hooks/post_secrets

  """
  @spec add_hook_secrets(id, Hooks.Secrets.Add.Params.t(), config) ::
          {:ok, map, response_body} | error
  def add_hook_secrets(id, %Hooks.Secrets.Add.Params{} = params, %Config{} = config) do
    Hooks.add_secrets(id, params, config)
  end

  @doc """
  Get log streams.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Log_Streams/get_log_streams

  """
  @spec get_log_streams(config) :: {:ok, Entity.LogStreams.t(), response_body} | error
  def get_log_streams(%Config{} = config) do
    LogStreams.list(config)
  end

  @doc """
  Create a log stream.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Log_Streams/post_log_streams

  """
  @spec create_log_stream(LogStreams.Create.Params.t(), config) ::
          {:ok, Entity.LogStream.t(), response_body} | error
  def create_log_stream(%LogStreams.Create.Params{} = params, %Config{} = config) do
    LogStreams.create(params, config)
  end

  @doc """
  Get log stream by ID.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Log_Streams/get_log_streams_by_id

  """
  @spec get_log_stream(id, config) ::
          {:ok, Entity.LogStream.t(), response_body} | error
  def get_log_stream(id, %Config{} = config) do
    LogStreams.get(id, config)
  end

  @doc """
  Delete log stream.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Log_Streams/delete_log_streams_by_id

  """
  @spec delete_log_stream(id, config) :: {:ok, String.t(), response_body} | error
  def delete_log_stream(id, %Config{} = config) do
    LogStreams.delete(id, config)
  end

  @doc """
  Update a log stream.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Log_Streams/patch_log_streams_by_id

  """
  @spec update_log_stream(id, LogStreams.Patch.Params.t(), config) ::
          {:ok, Entity.LogStream.t(), response_body} | error
  def update_log_stream(id, %LogStreams.Patch.Params{} = params, %Config{} = config) do
    LogStreams.update(id, params, config)
  end

  @doc """
  Search log events.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Logs/get_logs

  """
  @spec get_log_events(Logs.List.Params.t(), config) ::
          {:ok, Entity.Logs.t(), response_body} | error
  def get_log_events(%Logs.List.Params{} = params, %Config{} = config) do
    Logs.list(params, config)
  end

  @doc """
  Get a log event by id.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Logs/get_logs_by_id

  """
  @spec get_log_event(id, config) :: {:ok, Entity.Log.t(), response_body} | error
  def get_log_event(id, %Config{} = config) do
    Logs.get(id, config)
  end

  @doc """
  Get organizations.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Organizations/get_organizations

  """
  @spec get_organizations(Organizations.List.Params.t(), config) ::
          {:ok, Entity.Organizations.t(), response_body} | error
  def get_organizations(%Organizations.List.Params{} = params, %Config{} = config) do
    Organizations.list(params, config)
  end

  @doc """
  Create an Organization.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Organizations/post_organizations

  """
  @spec create_organization(Organizations.Create.Params.t(), config) ::
          {:ok, Entity.Organization.t(), response_body} | error
  def create_organization(%Organizations.Create.Params{} = params, %Config{} = config) do
    Organizations.create(params, config)
  end

  @doc """
  Get organization.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Organizations/get_organizations_by_id

  """
  @spec get_organization(id, config) ::
          {:ok, Entity.Organization.t(), response_body} | error
  def get_organization(id, %Config{} = config) do
    Organizations.get(id, config)
  end

  @doc """
  Delete organization.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Organizations/delete_organizations_by_id

  """
  @spec delete_organization(id, config) :: {:ok, String.t(), response_body} | error
  def delete_organization(id, %Config{} = config) do
    Organizations.delete(id, config)
  end

  @doc """
  Modify an Organization.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Organizations/patch_organizations_by_id

  """
  @spec modify_organization(id, Organizations.Patch.Params.t(), config) ::
          {:ok, Entity.Organization.t(), response_body} | error
  def modify_organization(id, %Organizations.Patch.Params{} = params, %Config{} = config) do
    Organizations.modify(id, params, config)
  end

  @doc """
  Get organization by name.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Organizations/get_name_by_name

  """
  @spec get_organization_by_name(name, config) ::
          {:ok, Entity.Organization.t(), response_body} | error
  def get_organization_by_name(name, %Config{} = config) do
    Organizations.get_by_name(name, config)
  end

  @doc """
  Get connections enabled for an organization.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Organizations/get_enabled_connections

  """
  @spec get_organization_connections(id, Organizations.EnabledConnections.List.Params.t(), config) ::
          {:ok, Entity.EnabledConnections.t(), response_body} | error
  def get_organization_connections(
        id,
        %Organizations.EnabledConnections.List.Params{} = params,
        %Config{} = config
      ) do
    Organizations.list_connections(id, params, config)
  end

  @doc """
  Add connections to an organization.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Organizations/post_enabled_connections

  """
  @spec add_organization_connection(
          id,
          Organizations.EnabledConnections.Create.Params.t(),
          config
        ) ::
          {:ok, Entity.EnabledConnection.t(), response_body} | error
  def add_organization_connection(
        id,
        %Organizations.EnabledConnections.Create.Params{} = params,
        %Config{} = config
      ) do
    Organizations.add_connection(id, params, config)
  end

  @doc """
  Get an enabled connection for an organization.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Organizations/get_enabled_connections_by_connectionId

  """
  @spec get_organization_connection(id, connection_id, config) ::
          {:ok, Entity.EnabledConnection.t(), response_body} | error
  def get_organization_connection(id, connection_id, %Config{} = config) do
    Organizations.get_connection(id, connection_id, config)
  end

  @doc """
  Delete connections from an organization.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Organizations/delete_enabled_connections_by_connectionId

  """
  @spec delete_organization_connection(id, connection_id, config) ::
          {:ok, String.t(), response_body} | error
  def delete_organization_connection(id, connection_id, %Config{} = config) do
    Organizations.delete_connection(id, connection_id, config)
  end

  @doc """
  Modify an Organizations Connection.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Organizations/patch_enabled_connections_by_connectionId

  """
  @spec modify_organization_connection(
          id,
          connection_id,
          Organizations.EnabledConnections.Patch.Params.t(),
          config
        ) ::
          {:ok, Entity.EnabledConnection.t(), response_body} | error
  def modify_organization_connection(
        id,
        connection_id,
        %Organizations.EnabledConnections.Patch.Params{} = params,
        %Config{} = config
      ) do
    Organizations.modify_connection(id, connection_id, params, config)
  end

  @doc """
  Get invitations to organization.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Organizations/get_invitations

  """
  @spec get_organization_invitations(id, Organizations.Invitations.List.Params.t(), config) ::
          {:ok, Entity.Invitations.t(), response_body} | error
  def get_organization_invitations(
        id,
        %Organizations.Invitations.List.Params{} = params,
        %Config{} = config
      ) do
    Organizations.list_invitations(id, params, config)
  end

  @doc """
  Create invitations to organization.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Organizations/post_invitations

  """
  @spec create_organization_invitation(id, Organizations.Invitations.Create.Params.t(), config) ::
          {:ok, Entity.Invitation.t(), response_body} | error
  def create_organization_invitation(
        id,
        %Organizations.Invitations.Create.Params{} = params,
        %Config{} = config
      ) do
    Organizations.create_invitation(id, params, config)
  end

  @doc """
  Get an invitation to organization.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Organizations/get_invitations_by_invitation_id

  """
  @spec get_organization_invitation(
          id,
          invitation_id,
          Organizations.Invitations.Get.Params.t(),
          config
        ) ::
          {:ok, Entity.Invitation.t(), response_body} | error
  def get_organization_invitation(
        id,
        invitation_id,
        %Organizations.Invitations.Get.Params{} = params,
        %Config{} = config
      ) do
    Organizations.get_invitation(id, invitation_id, params, config)
  end

  @doc """
  Delete an invitation to organization.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Organizations/delete_invitations_by_invitation_id

  """
  @spec delete_organization_invitation(id, invitation_id, config) ::
          {:ok, String.t(), response_body} | error
  def delete_organization_invitation(id, invitation_id, %Config{} = config) do
    Organizations.delete_invitation(id, invitation_id, config)
  end

  @doc """
  Get members who belong to an organization.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Organizations/get_members

  """
  @spec get_organization_members(id, Organizations.Members.List.Params.t(), config) ::
          {:ok, Entity.Members.t(), response_body} | error
  def get_organization_members(
        id,
        %Organizations.Members.List.Params{} = params,
        %Config{} = config
      ) do
    Organizations.list_members(id, params, config)
  end

  @doc """
  Delete members from an organization.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Organizations/delete_members

  """
  @spec delete_organization_members(id, Organizations.Members.Delete.Params.t(), config) ::
          {:ok, String.t(), response_body} | error
  def delete_organization_members(
        id,
        %Organizations.Members.Delete.Params{} = params,
        %Config{} = config
      ) do
    Organizations.delete_members(id, params, config)
  end

  @doc """
  Add members to an organization.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Organizations/post_members

  """
  @spec add_organization_members(id, Organizations.Members.Add.Params.t(), config) ::
          {:ok, String.t(), response_body} | error
  def add_organization_members(
        id,
        %Organizations.Members.Add.Params{} = params,
        %Config{} = config
      ) do
    Organizations.add_members(id, params, config)
  end

  @doc """
  Get the roles assigned to an organization member.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Organizations/get_organization_member_roles

  """
  @spec get_organization_roles(id, user_id, Organizations.Members.Roles.List.Params.t(), config) ::
          {:ok, Entity.Roles.t(), response_body} | error
  def get_organization_roles(
        id,
        user_id,
        %Organizations.Members.Roles.List.Params{} = params,
        %Config{} = config
      ) do
    Organizations.list_roles(id, user_id, params, config)
  end

  @doc """
  Delete members from an organization.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Organizations/delete_members

  """
  @spec delete_organization_roles(
          id,
          user_id,
          Organizations.Members.Roles.Delete.Params.t(),
          config
        ) ::
          {:ok, String.t(), response_body} | error
  def delete_organization_roles(
        id,
        user_id,
        %Organizations.Members.Roles.Delete.Params{} = params,
        %Config{} = config
      ) do
    Organizations.delete_roles(id, user_id, params, config)
  end

  @doc """
  Add members to an organization.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Organizations/post_members

  """
  @spec assign_organization_roles(id, user_id, Organizations.Members.Roles.Add.Params.t(), config) ::
          {:ok, String.t(), response_body} | error
  def assign_organization_roles(
        id,
        user_id,
        %Organizations.Members.Roles.Add.Params{} = params,
        %Config{} = config
      ) do
    Organizations.assign_roles(id, user_id, params, config)
  end

  @doc """
  Get prompts settings.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Prompts/get_prompts

  """
  @spec get_prompt_setting(config) :: {:ok, Entity.Prompt.t(), response_body} | error
  def get_prompt_setting(%Config{} = config) do
    Prompts.get(config)
  end

  @doc """
  Update prompts settings.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Prompts/patch_prompts

  """
  @spec update_prompt_setting(Prompts.Patch.Params.t(), config) ::
          {:ok, Entity.Prompt.t(), response_body} | error
  def update_prompt_setting(%Prompts.Patch.Params{} = params, %Config{} = config) do
    Prompts.update(params, config)
  end

  @doc """
  Get custom text for a prompt.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Prompts/get_custom_text_by_language

  """
  @spec get_prompt_custom_text(prompt, language, config) ::
          {:ok, Entity.CustomText.t(), response_body} | error
  def get_prompt_custom_text(prompt, language, %Config{} = config) do
    Prompts.get_custom_text(prompt, language, config)
  end

  @doc """
  Set custom text for a specific prompt.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Prompts/put_custom_text_by_language

  """
  @spec set_prompt_custom_text(prompt, language, Prompts.CustomText.Put.Params.t(), config) ::
          {:ok, Entity.CustomText.t(), response_body} | error
  def set_prompt_custom_text(
        prompt,
        language,
        %Prompts.CustomText.Put.Params{} = params,
        %Config{} = config
      ) do
    Prompts.set_custom_text(prompt, language, params, config)
  end

  @doc """
  Get resource servers.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Resource_Servers/get_resource_servers

  """
  @spec get_resource_servers(ResourceServers.List.Params.t(), config) ::
          {:ok, Entity.ResourceServers.t(), response_body} | error
  def get_resource_servers(%ResourceServers.List.Params{} = params, %Config{} = config) do
    ResourceServers.list(params, config)
  end

  @doc """
  Create a resource server.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Resource_Servers/post_resource_servers

  """
  @spec create_resource_server(ResourceServers.Create.Params.t(), config) ::
          {:ok, Entity.ResourceServer.t(), response_body} | error
  def create_resource_server(%ResourceServers.Create.Params{} = params, %Config{} = config) do
    ResourceServers.create(params, config)
  end

  @doc """
  Get a resource server.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Resource_Servers/get_resource_servers_by_id

  """
  @spec get_resource_server(id, ResourceServers.Get.Params.t(), config) ::
          {:ok, Entity.ResourceServer.t(), response_body} | error
  def get_resource_server(id, %ResourceServers.Get.Params{} = params, %Config{} = config) do
    ResourceServers.get(id, params, config)
  end

  @doc """
  Delete a resource server.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Resource_Servers/delete_resource_servers_by_id

  """
  @spec delete_resource_server(id, config) :: {:ok, String.t(), response_body} | error
  def delete_resource_server(id, %Config{} = config) do
    ResourceServers.delete(id, config)
  end

  @doc """
  Update a resource server.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Resource_Servers/get_resource_servers_by_id

  """
  @spec update_resource_server(id, ResourceServers.Patch.Params.t(), config) ::
          {:ok, Entity.ResourceServer.t(), response_body} | error
  def update_resource_server(id, %ResourceServers.Patch.Params{} = params, %Config{} = config) do
    ResourceServers.update(id, params, config)
  end

  @doc """
  Get roles.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Roles/get_roles

  """
  @spec get_roles(Roles.List.Params.t(), config) ::
          {:ok, Entity.Roles.t(), response_body} | error
  def get_roles(%Roles.List.Params{} = params, %Config{} = config) do
    Roles.list(params, config)
  end

  @doc """
  Create a role.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Roles/post_roles

  """
  @spec create_role(Roles.Create.Params.t(), config) ::
          {:ok, Entity.Role.t(), response_body} | error
  def create_role(%Roles.Create.Params{} = params, %Config{} = config) do
    Roles.create(params, config)
  end

  @doc """
  Get a role.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Roles/get_roles_by_id

  """
  @spec get_role(id, config) :: {:ok, Entity.Role.t(), response_body} | error
  def get_role(id, %Config{} = config) do
    Roles.get(id, config)
  end

  @doc """
  Delete a role.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Roles/delete_roles_by_id

  """
  @spec delete_role(id, config) :: {:ok, String.t(), response_body} | error
  def delete_role(id, %Config{} = config) do
    Roles.delete(id, config)
  end

  @doc """
  Update a role.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Roles/patch_roles_by_id

  """
  @spec update_role(id, Roles.Patch.Params.t(), config) ::
          {:ok, Entity.Role.t(), response_body} | error
  def update_role(id, %Roles.Patch.Params{} = params, %Config{} = config) do
    Roles.update(id, params, config)
  end

  @doc """
  Get permissions granted by role.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Roles/get_role_permission

  """
  @spec get_role_permissions(id, Roles.Permissions.List.Params.t(), config) ::
          {:ok, Entity.Permissions.t(), response_body} | error
  def get_role_permissions(id, %Roles.Permissions.List.Params{} = params, %Config{} = config) do
    Roles.list_permissions(id, params, config)
  end

  @doc """
  Remove permissions from a role.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Roles/delete_role_permission_assignment

  """
  @spec remove_role_permissions(id, Roles.Permissions.Remove.Params.t(), config) ::
          {:ok, String.t(), response_body} | error
  def remove_role_permissions(id, %Roles.Permissions.Remove.Params{} = params, %Config{} = config) do
    Roles.remove_permissions(id, params, config)
  end

  @doc """
  Associate permissions with a role.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Roles/post_role_permission_assignment

  """
  @spec associate_role_permissions(id, Roles.Permissions.Associate.Params.t(), config) ::
          {:ok, String.t(), response_body} | error
  def associate_role_permissions(
        id,
        %Roles.Permissions.Associate.Params{} = params,
        %Config{} = config
      ) do
    Roles.associate_permissions(id, params, config)
  end

  @doc """
  Get a role's users.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Roles/get_role_user

  """
  @spec get_role_users(id, Roles.Users.List.Params.t(), config) ::
          {:ok, Entity.Users.t(), response_body} | error
  def get_role_users(id, %Roles.Users.List.Params{} = params, %Config{} = config) do
    Roles.list_users(id, params, config)
  end

  @doc """
  Assign users to a role.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Roles/post_role_users

  """
  @spec assign_role_users(id, Roles.Users.Assign.Params.t(), config) ::
          {:ok, String.t(), response_body} | error
  def assign_role_users(id, %Roles.Users.Assign.Params{} = params, %Config{} = config) do
    Roles.assign_users(id, params, config)
  end

  @doc """
  Get rules.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Rules/get_rules

  """
  @spec get_rules(Rules.List.Params.t(), config) ::
          {:ok, Entity.Rules.t(), response_body} | error
  def get_rules(%Rules.List.Params{} = params, %Config{} = config) do
    Rules.list(params, config)
  end

  @doc """
  Create a rule.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Rules/post_rules

  """
  @spec create_rule(Rules.Create.Params.t(), config) ::
          {:ok, Entity.Rule.t(), response_body} | error
  def create_rule(%Rules.Create.Params{} = params, %Config{} = config) do
    Rules.create(params, config)
  end

  @doc """
  Get a rule.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Rules/get_rules_by_id

  """
  @spec get_rule(id, Rules.Get.Params.t(), config) ::
          {:ok, Entity.Rule.t(), response_body} | error
  def get_rule(id, %Rules.Get.Params{} = params, %Config{} = config) do
    Rules.get(id, params, config)
  end

  @doc """
  Delete a rule.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Rules/delete_rules_by_id

  """
  @spec delete_rule(id, config) :: {:ok, String.t(), response_body} | error
  def delete_rule(id, %Config{} = config) do
    Rules.delete(id, config)
  end

  @doc """
  Update a rule.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Rules/patch_rules_by_id

  """
  @spec update_rule(id, Rules.Patch.Params.t(), config) ::
          {:ok, Entity.Rule.t(), response_body} | error
  def update_rule(id, %Rules.Patch.Params{} = params, %Config{} = config) do
    Rules.update(id, params, config)
  end

  @doc """
  Retrieve config variable keys for rules (get_rules-configs).

  ## see
  https://auth0.com/docs/api/management/v2/#!/Rules_Configs/get_rules_configs

  """
  @spec get_rules_configs(config) ::
          {:ok, Entity.RulesConfigs.t(), response_body} | error
  def get_rules_configs(%Config{} = config) do
    RulesConfigs.list(config)
  end

  @doc """
  Delete rules config for a given key.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Rules_Configs/delete_rules_configs_by_key

  """
  @spec delete_rules_config(key, config) :: {:ok, String.t(), response_body} | error
  def delete_rules_config(key, %Config{} = config) do
    RulesConfigs.delete(key, config)
  end

  @doc """
  Set rules config for a given key.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Rules_Configs/put_rules_configs_by_key

  """
  @spec set_rules_config(key, RulesConfigs.Put.Params.t(), config) ::
          {:ok, Entity.RulesConfig.t(), response_body} | error
  def set_rules_config(key, %RulesConfigs.Put.Params{} = params, %Config{} = config) do
    RulesConfigs.set(key, params, config)
  end

  @doc """
  Get blocks by identifier.

  ## see
  https://auth0.com/docs/api/management/v2/#!/User_Blocks/get_user_blocks

  """
  @spec get_user_block(UserBlocks.Get.Params.t(), config) ::
          {:ok, Entity.UserBlocks.t(), response_body} | error
  def get_user_block(%UserBlocks.Get.Params{} = params, %Config{} = config) do
    UserBlocks.get(params, config)
  end

  @doc """
  Unblock by identifier.

  ## see
  https://auth0.com/docs/api/management/v2/#!/User_Blocks/delete_user_blocks

  """
  @spec unblock_user_block(UserBlocks.Unblock.Params.t(), config) ::
          {:ok, String.t(), response_body} | error
  def unblock_user_block(%UserBlocks.Unblock.Params{} = params, %Config{} = config) do
    UserBlocks.unblock(params, config)
  end

  @doc """
  Get a user's blocks.

  ## see
  https://auth0.com/docs/api/management/v2/#!/User_Blocks/get_user_blocks_by_id

  """
  @spec get_user_block_by_user_id(id, UserBlocks.Users.Get.Params.t(), config) ::
          {:ok, Entity.UserBlocks.t(), response_body} | error
  def get_user_block_by_user_id(id, %UserBlocks.Users.Get.Params{} = params, %Config{} = config) do
    UserBlocks.get_by_user_id(id, params, config)
  end

  @doc """
  Unblock a user.

  ## see
  https://auth0.com/docs/api/management/v2/#!/User_Blocks/delete_user_blocks_by_id

  """
  @spec unblock_user_block_by_user_id(id, config) :: {:ok, String.t(), response_body} | error
  def unblock_user_block_by_user_id(id, %Config{} = config) do
    UserBlocks.unblock_by_user_id(id, config)
  end

  @doc """
  List or Search Users.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Users/get_users

  """
  @spec get_users(Users.List.Params.t(), config) ::
          {:ok, Entity.Users.t(), response_body} | error
  def get_users(%Users.List.Params{} = params, %Config{} = config) do
    Users.list(params, config)
  end

  @doc """
  Create a User.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Users/post_users

  """
  @spec create_user(Users.Create.Params.t(), config) ::
          {:ok, Entity.User.t(), response_body} | error
  def create_user(%Users.Create.Params{} = params, %Config{} = config) do
    Users.create(params, config)
  end

  @doc """
  Get a User.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Users/get_users_by_id

  """
  @spec get_user(id, Users.Get.Params.t(), config) ::
          {:ok, Entity.User.t(), response_body} | error
  def get_user(id, %Users.Get.Params{} = params, %Config{} = config) do
    Users.get(id, params, config)
  end

  @doc """
  Delete a User.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Users/delete_users_by_id

  """
  @spec delete_user(id, config) :: {:ok, String.t(), response_body} | error
  def delete_user(id, %Config{} = config) do
    Users.delete(id, config)
  end

  @doc """
  Update a User.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Users/patch_users_by_id

  """
  @spec update_user(id, Users.Patch.Params.t(), config) ::
          {:ok, Entity.User.t(), response_body} | error
  def update_user(id, %Users.Patch.Params{} = params, %Config{} = config) do
    Users.update(id, params, config)
  end

  @doc """
  Get the First Confirmed Multi-factor Authentication Enrollment.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Users/get_enrollments

  """
  @spec get_user_enrollments(id, config) ::
          {:ok, Entity.Enrollments.t(), response_body} | error
  def get_user_enrollments(id, %Config{} = config) do
    Users.get_enrollments(id, config)
  end

  @doc """
  Get a user's roles.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Users/get_user_roles

  """
  @spec get_user_roles(id, Users.Roles.List.Params.t(), config) ::
          {:ok, Entity.Roles.t(), response_body} | error
  def get_user_roles(id, %Users.Roles.List.Params{} = params, %Config{} = config) do
    Users.get_roles(id, params, config)
  end

  @doc """
  Removes roles from a user.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Users/delete_user_roles

  """
  @spec remove_user_roles(id, Users.Roles.Remove.Params.t(), config) ::
          {:ok, String.t(), response_body} | error
  def remove_user_roles(id, %Users.Roles.Remove.Params{} = params, %Config{} = config) do
    Users.remove_roles(id, params, config)
  end

  @doc """
  Assign roles to a user.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Users/post_user_roles

  """
  @spec assign_user_roles(id, Users.Roles.Assign.Params.t(), config) ::
          {:ok, String.t(), response_body} | error
  def assign_user_roles(id, %Users.Roles.Assign.Params{} = params, %Config{} = config) do
    Users.assign_roles(id, params, config)
  end

  @doc """
  Get user's log events.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Users/get_logs_by_user

  """
  @spec get_user_logs(id, Users.Logs.List.Params.t(), config) ::
          {:ok, Entity.Logs.t(), response_body} | error
  def get_user_logs(id, %Users.Logs.List.Params{} = params, %Config{} = config) do
    Users.get_logs(id, params, config)
  end

  @doc """
  List user's organizations.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Users/get_user_organizations

  """
  @spec get_user_organizations(id, Users.Organizations.List.Params.t(), config) ::
          {:ok, Entity.Organizations.t(), response_body} | error
  def get_user_organizations(id, %Users.Organizations.List.Params{} = params, %Config{} = config) do
    Users.get_organizations(id, params, config)
  end

  @doc """
  Get a User's Permissions.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Users/get_permissions

  """
  @spec get_user_permissions(id, Users.Permissions.List.Params.t(), config) ::
          {:ok, Entity.Permissions.t(), response_body} | error
  def get_user_permissions(id, %Users.Permissions.List.Params{} = params, %Config{} = config) do
    Users.get_permissions(id, params, config)
  end

  @doc """
  Remove Permissions from a User.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Users/delete_permissions

  """
  @spec remove_user_permissions(id, Users.Permissions.Remove.Params.t(), config) ::
          {:ok, String.t(), response_body} | error
  def remove_user_permissions(id, %Users.Permissions.Remove.Params{} = params, %Config{} = config) do
    Users.remove_permissions(id, params, config)
  end

  @doc """
  Assign Permissions to a User.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Users/post_permissions

  """
  @spec assign_user_permissions(id, Users.Permissions.Assign.Params.t(), config) ::
          {:ok, String.t(), response_body} | error
  def assign_user_permissions(id, %Users.Permissions.Assign.Params{} = params, %Config{} = config) do
    Users.assign_permissions(id, params, config)
  end

  @doc """
  Delete a User's Multi-factor Provider.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Users/delete_multifactor_by_provider

  """
  @spec delete_user_multifactor(id, Users.Multifactor.Delete.Params.t(), config) ::
          {:ok, String.t(), response_body} | error
  def delete_user_multifactor(
        id,
        %Users.Multifactor.Delete.Params{} = params,
        %Config{} = config
      ) do
    Users.delete_multifactor(id, params, config)
  end

  @doc """
  Invalidate All Remembered Browsers for Multi-factor Authentication.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Users/post_invalidate_remember_browser

  """
  @spec invalidate_user_remembered_browser_for_multifactor(id, config) ::
          {:ok, String.t(), response_body} | error
  def invalidate_user_remembered_browser_for_multifactor(
        id,
        %Config{} = config
      ) do
    Users.invalidate_remembered_browser_for_multifactor(id, config)
  end

  @doc """
  Link a User Account.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Users/post_identities

  """
  @spec link_user_identities(id, Users.Identities.Link.Params.t(), config) ::
          {:ok, Entity.Identities.t(), response_body} | error
  def link_user_identities(
        id,
        %Users.Identities.Link.Params{} = params,
        %Config{} = config
      ) do
    Users.link_identities(id, params, config)
  end

  @doc """
  Unlink a User Identity.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Users/delete_user_identity_by_user_id

  """
  @spec unlink_user_identities(id, Users.Identities.Unlink.Params.t(), config) ::
          {:ok, Entity.Identities.t(), response_body} | error
  def unlink_user_identities(
        id,
        %Users.Identities.Unlink.Params{} = params,
        %Config{} = config
      ) do
    Users.unlink_identities(id, params, config)
  end

  @doc """
  Generate New Multi-factor Authentication Recovery Code.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Users/post_recovery_code_regeneration

  """
  @spec regenerate_user_recovery_code(id, config) ::
          {:ok, Entity.RecoveryCodeRegeneration.t(), response_body} | error
  def regenerate_user_recovery_code(
        id,
        %Config{} = config
      ) do
    Users.regenerate_recovery_code(id, config)
  end

  @doc """
  Search Users by Email.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Users_By_Email/get_users_by_email

  """
  @spec get_users_by_email(UsersByEmail.List.Params.t(), config) ::
          {:ok, Entity.Users.t(), response_body} | error
  def get_users_by_email(%UsersByEmail.List.Params{} = params, %Config{} = config) do
    UsersByEmail.list(params, config)
  end

  @doc """
  Get actions.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Actions/get_actions

  """
  @spec get_actions(Actions.List.Params.t(), config) ::
          {:ok, Entity.Actions.t(), response_body} | error
  def get_actions(%Actions.List.Params{} = params, %Config{} = config) do
    Actions.list(params, config)
  end

  @doc """
  Create an action.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Actions/post_action

  """
  @spec create_action(Actions.Create.Params.t(), config) ::
          {:ok, Entity.Action.t(), response_body} | error
  def create_action(%Actions.Create.Params{} = params, %Config{} = config) do
    Actions.create(params, config)
  end

  @doc """
  Get an action.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Actions/get_action

  """
  @spec get_action(id, config) ::
          {:ok, Entity.Action.t(), response_body} | error
  def get_action(id, %Config{} = config) do
    Actions.get(id, config)
  end

  @doc """
  Delete an action.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Actions/delete_action

  """
  @spec delete_action(id, Actions.Delete.Params.t(), config) ::
          {:ok, String.t(), response_body} | error
  def delete_action(id, %Actions.Delete.Params{} = params, %Config{} = config) do
    Actions.delete(id, params, config)
  end

  @doc """
  Update an action.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Actions/patch_action

  """
  @spec update_action(id, Actions.Patch.Params.t(), config) ::
          {:ok, Entity.Action.t(), response_body} | error
  def update_action(id, %Actions.Patch.Params{} = params, %Config{} = config) do
    Actions.update(id, params, config)
  end

  @doc """
  Get an action's versions.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Actions/get_action_versions

  """
  @spec get_action_versions(action_id, Actions.Versions.List.Params.t(), config) ::
          {:ok, Entity.ActionVersions.t(), response_body} | error
  def get_action_versions(action_id, %Actions.Versions.List.Params{} = params, %Config{} = config) do
    Actions.list_versions(action_id, params, config)
  end

  @doc """
  Get a specific version of an action.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Actions/get_action_version

  """
  @spec get_action_version(action_id, id, config) ::
          {:ok, Entity.ActionVersions.t(), response_body} | error
  def get_action_version(action_id, id, %Config{} = config) do
    Actions.get_version(action_id, id, config)
  end

  @doc """
  Roll back to a previous action version.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Actions/post_deploy_draft_version

  """
  @spec rollback_action_version(action_id, id, Actions.Versions.Rollback.Params.t(), config) ::
          {:ok, Entity.ActionVersion.t(), response_body} | error
  def rollback_action_version(
        action_id,
        id,
        %Actions.Versions.Rollback.Params{} = params,
        %Config{} = config
      ) do
    Actions.rollback_version(action_id, id, params, config)
  end

  @doc """
  Test an Action.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Actions/post_test_action

  """
  @spec test_action(id, Actions.Test.Params.t(), config) ::
          {:ok, Entity.ActionTest.t(), response_body} | error
  def test_action(id, %Actions.Test.Params{} = params, %Config{} = config) do
    Actions.test(id, params, config)
  end

  @doc """
  Deploy an action.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Actions/post_deploy_action

  """
  @spec deploy_action(id, config) ::
          {:ok, Entity.ActionVersion.t(), response_body} | error
  def deploy_action(id, %Config{} = config) do
    Actions.deploy(id, config)
  end

  @doc """
  Get triggers.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Actions/get_triggers

  """
  @spec get_action_trigger_bindings(trigger_id, Actions.Triggers.Bindings.List.Params.t(), config) ::
          {:ok, Entity.ActionTriggerBindings.t(), response_body} | error
  def get_action_trigger_bindings(
        trigger_id,
        %Actions.Triggers.Bindings.List.Params{} = params,
        %Config{} = config
      ) do
    Actions.get_bindings(trigger_id, params, config)
  end

  @doc """
  Update trigger bindings.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Actions/patch_bindings

  """
  @spec update_action_trigger_bindings(
          trigger_id,
          Actions.Triggers.Bindings.Patch.Params.t(),
          config
        ) ::
          {:ok, Entity.ActionTriggerBindings.t(), response_body} | error
  def update_action_trigger_bindings(
        trigger_id,
        %Actions.Triggers.Bindings.Patch.Params{} = params,
        %Config{} = config
      ) do
    Actions.update_bindings(trigger_id, params, config)
  end

  @doc """
  Get actions service status.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Actions/get_service_status

  """
  @spec get_action_status(config) ::
          {:ok, Entity.ActionStatus.t(), response_body} | error
  def get_action_status(%Config{} = config) do
    Actions.get_status(config)
  end

  @doc """
  Get an execution.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Actions/get_execution

  """
  @spec get_action_execution(id, config) ::
          {:ok, Entity.ActionExecution.t(), response_body} | error
  def get_action_execution(id, %Config{} = config) do
    Actions.get_execution(id, config)
  end

  @doc """
  Get blacklisted tokens.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Blacklists/get_tokens

  """
  @spec get_blacklisted_tokens(Blacklist.Tokens.List.Params.t(), config) ::
          {:ok, Entity.BlacklistTokens.t(), response_body} | error
  def get_blacklisted_tokens(%Blacklist.Tokens.List.Params{} = params, %Config{} = config) do
    Blacklist.list_tokens(params, config)
  end

  @doc """
  Blacklist a token.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Blacklists/post_tokens

  """
  @spec blacklist_token(Blacklist.Tokens.Add.Params.t(), config) ::
          {:ok, String.t(), response_body} | error
  def blacklist_token(%Blacklist.Tokens.Add.Params{} = params, %Config{} = config) do
    Blacklist.add_token(params, config)
  end

  @doc """
  Get an email template.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Email_Templates/get_email_templates_by_templateName

  """
  @spec get_email_template(template_name, config) ::
          {:ok, Entity.EmailTemplate.t(), response_body} | error
  def get_email_template(template_name, %Config{} = config) do
    EmailTemplates.get(template_name, config)
  end

  @doc """
  Patch an email template.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Email_Templates/patch_email_templates_by_templateName

  """
  @spec patch_email_template(template_name, EmailTemplates.Patch.Params.t(), config) ::
          {:ok, Entity.EmailTemplate.t(), response_body} | error
  def patch_email_template(
        template_name,
        %EmailTemplates.Patch.Params{} = params,
        %Config{} = config
      ) do
    EmailTemplates.patch(template_name, params, config)
  end

  @doc """
  Update an email template.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Email_Templates/put_email_templates_by_templateName

  """
  @spec update_email_template(template_name, EmailTemplates.Update.Params.t(), config) ::
          {:ok, Entity.EmailTemplate.t(), response_body} | error
  def update_email_template(
        template_name,
        %EmailTemplates.Update.Params{} = params,
        %Config{} = config
      ) do
    EmailTemplates.update(template_name, params, config)
  end

  @doc """
  Create an email template.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Email_Templates/post_email_templates

  """
  @spec create_email_template(EmailTemplates.Create.Params.t(), config) ::
          {:ok, Entity.EmailTemplate.t(), response_body} | error
  def create_email_template(%EmailTemplates.Create.Params{} = params, %Config{} = config) do
    EmailTemplates.create(params, config)
  end

  @doc """
  Get the email provider.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Emails/get_provider

  """
  @spec get_email_provider(Emails.Provider.Get.Params.t(), config) ::
          {:ok, Entity.EmailProvider.t(), response_body} | error
  def get_email_provider(%Emails.Provider.Get.Params{} = params, %Config{} = config) do
    Emails.get_provider(params, config)
  end

  @doc """
  Delete the email provider.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Emails/delete_provider

  """
  @spec delete_email_provider(config) :: {:ok, String.t(), response_body} | error
  def delete_email_provider(%Config{} = config) do
    Emails.delete_provider(config)
  end

  @doc """
  Update the email provider.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Emails/patch_provider

  """
  @spec update_email_provider(Emails.Provider.Patch.Params.t(), config) ::
          {:ok, Entity.EmailProvider.t(), response_body} | error
  def update_email_provider(%Emails.Provider.Patch.Params{} = params, %Config{} = config) do
    Emails.update_provider(params, config)
  end

  @doc """
  Configure the email provider.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Emails/post_provider

  """
  @spec configure_email_provider(Emails.Provider.Configure.Params.t(), config) ::
          {:ok, Entity.EmailProvider.t(), response_body} | error
  def configure_email_provider(%Emails.Provider.Configure.Params{} = params, %Config{} = config) do
    Emails.configure_provider(params, config)
  end

  @doc """
  Retrieve Factors and their Status.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Guardian/get_factors

  """
  @spec get_guardian_factors(config) ::
          {:ok, Entity.GuardianFactors.t(), response_body} | error
  def get_guardian_factors(%Config{} = config) do
    Guardian.list_factors(config)
  end

  @doc """
  Update a Multi-factor Authentication Factor.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Guardian/put_factors_by_name

  """
  @spec update_guardian_factor(name, Guardian.Factors.Put.Params.t(), config) ::
          {:ok, Entity.GuardianFactor.t(), response_body} | error
  def update_guardian_factor(name, %Guardian.Factors.Put.Params{} = params, %Config{} = config) do
    Guardian.update_factor(name, params, config)
  end

  @doc """
  Get the Multi-factor Authentication policies.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Guardian/get_policies

  """
  @spec list_guardian_policies(config) :: {:ok, list(map), response_body} | error
  def list_guardian_policies(%Config{} = config) do
    Guardian.list_policies(config)
  end

  @doc """
  Set the Multi-factor Authentication policies.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Guardian/put_policies

  """
  @spec set_guardian_policies(map, config) :: {:ok, list(map), response_body} | error
  def set_guardian_policies(params, %Config{} = config) do
    Guardian.set_policies(params, config)
  end

  @doc """
  Retrieve a multi-factor authentication enrollment.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Guardian/get_enrollments_by_id

  """
  @spec get_guardian_enrollment(id, config) ::
          {:ok, Entity.GuardianEnrollment.t(), response_body} | error
  def get_guardian_enrollment(id, %Config{} = config) do
    Guardian.get_enrollment(id, config)
  end

  @doc """
  Delete a multi-factor authentication enrollment.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Guardian/delete_enrollments_by_id

  """
  @spec delete_guardian_enrollment(id, config) :: {:ok, String.t(), response_body} | error
  def delete_guardian_enrollment(id, %Config{} = config) do
    Guardian.delete_enrollment(id, config)
  end

  @doc """
  Create a multi-factor authentication enrollment ticket.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Guardian/post_ticket

  """
  @spec create_guardian_enrollment_ticket(Guardian.Enrollments.Ticket.Params.t(), config) ::
          {:ok, Entity.GuardianEnrollmentTicket.t(), response_body} | error
  def create_guardian_enrollment_ticket(
        %Guardian.Enrollments.Ticket.Params{} = params,
        %Config{} = config
      ) do
    Guardian.create_enrollment_ticket(params, config)
  end

  @doc """
  Retrieve the Enabled Phone Factors.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Guardian/get_message_types

  """
  @spec get_guardian_phone_factor(config) ::
          {:ok, Entity.GuardianPhoneFactor.t(), response_body} | error
  def get_guardian_phone_factor(%Config{} = config) do
    Guardian.get_phone_factor(config)
  end

  @doc """
  Update the Enabled Phone Factors.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Guardian/put_message_types

  """
  @spec update_guardian_phone_factor(Guardian.Phone.Factor.Put.Params.t(), config) ::
          {:ok, Entity.GuardianPhoneFactor.t(), response_body} | error
  def update_guardian_phone_factor(
        %Guardian.Phone.Factor.Put.Params{} = params,
        %Config{} = config
      ) do
    Guardian.update_phone_factor(params, config)
  end

  @doc """
  Retrieve phone configuration (one of auth0|twilio|phone-message-hook).

  ## see
  https://auth0.com/docs/api/management/v2/#!/Guardian/get_selected_provider

  """
  @spec get_guardian_phone_configuration(config) ::
          {:ok, Entity.GuardianPhoneConfiguration.t(), response_body} | error
  def get_guardian_phone_configuration(%Config{} = config) do
    Guardian.get_phone_configuration(config)
  end

  @doc """
  Update phone configuration (one of auth0|twilio|phone-message-hook).

  ## see
  https://auth0.com/docs/api/management/v2/#!/Guardian/put_selected_provider

  """
  @spec update_guardian_phone_configuration(Guardian.Phone.Configuration.Put.Params.t(), config) ::
          {:ok, Entity.GuardianPhoneConfiguration.t(), response_body} | error
  def update_guardian_phone_configuration(
        %Guardian.Phone.Configuration.Put.Params{} = params,
        %Config{} = config
      ) do
    Guardian.update_phone_configuration(params, config)
  end

  @doc """
  Retrieve Enrollment and Verification Phone Templates.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Guardian/get_templates

  """
  @spec get_guardian_phone_template(config) ::
          {:ok, Entity.GuardianPhoneTemplate.t(), response_body} | error
  def get_guardian_phone_template(%Config{} = config) do
    Guardian.get_phone_template(config)
  end

  @doc """
  Update Enrollment and Verification Phone Templates.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Guardian/put_templates

  """
  @spec update_guardian_phone_template(Guardian.Phone.Template.Put.Params.t(), config) ::
          {:ok, Entity.GuardianPhoneTemplate.t(), response_body} | error
  def update_guardian_phone_template(
        %Guardian.Phone.Template.Put.Params{} = params,
        %Config{} = config
      ) do
    Guardian.update_phone_template(params, config)
  end

  @doc """
  Retrieve SMS configuration (one of auth0|twilio|phone-message-hook).

  ## see
  https://auth0.com/docs/api/management/v2/#!/Guardian/get_selected_provider_0

  """
  @spec get_guardian_sms_configuration(config) ::
          {:ok, Entity.GuardianSmsConfiguration.t(), response_body} | error
  def get_guardian_sms_configuration(%Config{} = config) do
    Guardian.get_sms_configuration(config)
  end

  @doc """
  Update SMS configuration (one of auth0|twilio|phone-message-hook).

  ## see
  https://auth0.com/docs/api/management/v2/#!/Guardian/put_selected_provider_0

  """
  @spec update_guardian_sms_configuration(Guardian.Sms.Configuration.Put.Params.t(), config) ::
          {:ok, Entity.GuardianSmsConfiguration.t(), response_body} | error
  def update_guardian_sms_configuration(
        %Guardian.Sms.Configuration.Put.Params{} = params,
        %Config{} = config
      ) do
    Guardian.update_sms_configuration(params, config)
  end

  @doc """
  Retrieve SMS Enrollment and Verification Templates.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Guardian/get_templates_0

  """
  @spec get_guardian_sms_template(config) ::
          {:ok, Entity.GuardianSmsTemplate.t(), response_body} | error
  def get_guardian_sms_template(%Config{} = config) do
    Guardian.get_sms_template(config)
  end

  @doc """
  Update SMS Enrollment and Verification Templates.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Guardian/put_templates_0

  """
  @spec update_guardian_sms_template(Guardian.Sms.Template.Put.Params.t(), config) ::
          {:ok, Entity.GuardianSmsTemplate.t(), response_body} | error
  def update_guardian_sms_template(
        %Guardian.Sms.Template.Put.Params{} = params,
        %Config{} = config
      ) do
    Guardian.update_sms_template(params, config)
  end

  @doc """
  Retrieve Twilio phone configuration.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Guardian/get_twilio

  """
  @spec get_guardian_twilio_phone_configuration(config) ::
          {:ok, Entity.GuardianTwilioConfiguration.t(), response_body} | error
  def get_guardian_twilio_phone_configuration(%Config{} = config) do
    Guardian.get_twilio_phone_configuration(config)
  end

  @doc """
  Update Twilio phone configuration.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Guardian/put_twilio

  """
  @spec update_guardian_twilio_phone_configuration(
          Guardian.Twilio.Phone.Configuration.Put.Params.t(),
          config
        ) ::
          {:ok, Entity.GuardianTwilioConfiguration.t(), response_body} | error
  def update_guardian_twilio_phone_configuration(
        %Guardian.Twilio.Phone.Configuration.Put.Params{} = params,
        %Config{} = config
      ) do
    Guardian.update_twilio_phone_configuration(params, config)
  end

  @doc """
  Retrieve Twilio SMS configuration.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Guardian/get_twilio_0

  """
  @spec get_guardian_twilio_sms_configuration(config) ::
          {:ok, Entity.GuardianTwilioConfiguration.t(), response_body} | error
  def get_guardian_twilio_sms_configuration(%Config{} = config) do
    Guardian.get_twilio_sms_configuration(config)
  end

  @doc """
  Update Twilio SMS configuration.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Guardian/put_twilio_0

  """
  @spec update_guardian_twilio_sms_configuration(
          Guardian.Twilio.Sms.Configuration.Put.Params.t(),
          config
        ) ::
          {:ok, Entity.GuardianTwilioConfiguration.t(), response_body} | error
  def update_guardian_twilio_sms_configuration(
        %Guardian.Twilio.Sms.Configuration.Put.Params{} = params,
        %Config{} = config
      ) do
    Guardian.update_twilio_sms_configuration(params, config)
  end

  @doc """
  Retrieve AWS SNS push notification configuration.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Guardian/get_sns

  """
  @spec get_guardian_aws_sns_configuration(config) ::
          {:ok, Entity.GuardianAwsSnsConfiguration.t(), response_body} | error
  def get_guardian_aws_sns_configuration(%Config{} = config) do
    Guardian.get_aws_sns_configuration(config)
  end

  @doc """
  Update SNS configuration for push notifications.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Guardian/patch_sns

  """
  @spec patch_guardian_aws_sns_configuration(
          Guardian.AwsSns.Configuration.Patch.Params.t(),
          config
        ) ::
          {:ok, Entity.GuardianAwsSnsConfiguration.t(), response_body} | error
  def patch_guardian_aws_sns_configuration(
        %Guardian.AwsSns.Configuration.Patch.Params{} = params,
        %Config{} = config
      ) do
    Guardian.patch_aws_sns_configuration(params, config)
  end

  @doc """
  Update AWS SNS push notification configuration.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Guardian/put_sns

  """
  @spec update_guardian_aws_sns_configuration(
          Guardian.AwsSns.Configuration.Put.Params.t(),
          config
        ) ::
          {:ok, Entity.GuardianAwsSnsConfiguration.t(), response_body} | error
  def update_guardian_aws_sns_configuration(
        %Guardian.AwsSns.Configuration.Put.Params{} = params,
        %Config{} = config
      ) do
    Guardian.update_aws_sns_configuration(params, config)
  end

  @doc """
  Get a job.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Jobs/get_jobs_by_id

  """
  @spec get_job(id, config) :: {:ok, Entity.Jobs.t(), response_body} | error
  def get_job(id, %Config{} = config) do
    Jobs.get(id, config)
  end

  @doc """
  Get job error details.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Jobs/get_errors

  """
  @spec get_job_error(id, config) ::
          {:ok, Entity.JobsErrors.t(), response_body} | error
  def get_job_error(id, %Config{} = config) do
    Jobs.get_error(id, config)
  end

  @doc """
  Create export users job.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Jobs/post_users_exports

  """
  @spec create_job_users_exports(Jobs.UsersExport.Params.t(), config) ::
          {:ok, Entity.JobsUsersExport.t(), response_body} | error
  def create_job_users_exports(%Jobs.UsersExport.Params{} = params, %Config{} = config) do
    Jobs.create_users_exports(params, config)
  end

  @doc """
  Create import users job.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Jobs/post_users_imports

  """
  @spec create_job_users_imports(Jobs.UsersImport.Params.t(), config) ::
          {:ok, Entity.JobsUsersImport.t(), response_body} | error
  def create_job_users_imports(%Jobs.UsersImport.Params{} = params, %Config{} = config) do
    Jobs.create_users_imports(params, config)
  end

  @doc """
  Send an email address verification email.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Jobs/post_verification_email

  """
  @spec send_job_verification_email(Jobs.VerificationEmail.Params.t(), config) ::
          {:ok, Entity.JobsVerificationEmail.t(), response_body} | error
  def send_job_verification_email(%Jobs.VerificationEmail.Params{} = params, %Config{} = config) do
    Jobs.send_verification_email(params, config)
  end

  @doc """
  Get all Application Signing Keys.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Keys/get_signing_keys

  """
  @spec get_signing_keys(config) ::
          {:ok, Entity.SigningKeys.t(), response_body} | error
  def get_signing_keys(%Config{} = config) do
    Keys.list_signing(config)
  end

  @doc """
  Get an Application Signing Key by its key id.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Keys/get_signing_key

  """
  @spec get_signing_key(kid, config) ::
          {:ok, Entity.SigningKey.t(), response_body} | error
  def get_signing_key(kid, %Config{} = config) do
    Keys.get_signing(kid, config)
  end

  @doc """
  Rotate the Application Signing Key.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Keys/post_signing_keys

  """
  @spec rotate_signing_key(config) ::
          {:ok, Entity.SigningKey.t(), response_body} | error
  def rotate_signing_key(%Config{} = config) do
    Keys.rotate_signing(config)
  end

  @doc """
  Revoke an Application Signing Key by its key id.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Keys/put_signing_keys

  """
  @spec revoke_signing_key(kid, config) ::
          {:ok, Entity.SigningKey.t(), response_body} | error
  def revoke_signing_key(kid, %Config{} = config) do
    Keys.revoke_signing(kid, config)
  end

  @doc """
  Get active users count.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Stats/get_active_users

  """
  @spec get_active_users_count(config) :: {:ok, integer, response_body} | error
  def get_active_users_count(%Config{} = config) do
    Stats.count_active_users(config)
  end

  @doc """
  Get daily stats.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Stats/get_daily

  """
  @spec get_daily_stats(config) :: {:ok, Entity.DailyStats.t(), response_body} | error
  def get_daily_stats(%Config{} = config) do
    Stats.list_daily(config)
  end

  @doc """
  Get tenant settings.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Tenants/tenant_settings_route

  """
  @spec get_tenant_setting(Tenants.Settings.Get.Params.t(), config) ::
          {:ok, Entity.TenantSetting.t(), response_body} | error
  def get_tenant_setting(%Tenants.Settings.Get.Params{} = params, %Config{} = config) do
    Tenants.get_setting(params, config)
  end

  @doc """
  Update tenant settings.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Tenants/patch_settings

  """
  @spec update_tenant_setting(Tenants.Settings.Patch.Params.t(), config) ::
          {:ok, Entity.TenantSetting.t(), response_body} | error
  def update_tenant_setting(%Tenants.Settings.Patch.Params{} = params, %Config{} = config) do
    Tenants.update_setting(params, config)
  end

  @doc """
  Check if an IP address is blocked.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Anomaly/get_ips_by_id

  """
  @spec check_ip_blocked(ip, config) :: {:ok, boolean, response_body} | error
  def check_ip_blocked(ip, %Config{} = config) do
    Anomaly.check_ip_blocked(ip, config)
  end

  @doc """
  Remove the blocked IP address.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Anomaly/delete_ips_by_id

  """
  @spec remove_blocked_ip(ip, config) :: {:ok, String.t(), response_body} | error
  def remove_blocked_ip(ip, %Config{} = config) do
    Anomaly.remove_blocked_ip(ip, config)
  end

  @doc """
  Create an email verification ticket.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Tickets/post_email_verification

  """
  @spec create_email_verification_ticket(Tickets.EmailVerification.Create.Params.t(), config) ::
          {:ok, Entity.Ticket.t(), response_body} | error
  def create_email_verification_ticket(
        %Tickets.EmailVerification.Create.Params{} = params,
        %Config{} = config
      ) do
    Tickets.create_email_verification(params, config)
  end

  @doc """
  Create a password change ticket.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Tickets/post_password_change

  """
  @spec create_password_change_ticket(Tickets.PasswordChange.Create.Params.t(), config) ::
          {:ok, Entity.Ticket.t(), response_body} | error
  def create_password_change_ticket(
        %Tickets.PasswordChange.Create.Params{} = params,
        %Config{} = config
      ) do
    Tickets.create_password_change(params, config)
  end
end
