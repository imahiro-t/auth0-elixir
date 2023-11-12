defmodule Auth0.Simple.Management do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Util
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
  alias Auth0.Management.AttackProtection

  @type config :: Config.t()
  @type theme_id :: String.t()
  @type id :: String.t()
  @type name :: String.t()
  @type invitation_id :: String.t()
  @type connection_id :: String.t()
  @type user_id :: String.t()
  @type prompt :: String.t()
  @type language :: String.t()
  @type key :: String.t()
  @type provider :: String.t()
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
  @deprecated "Use Auth0.Api.Management.get_branding/1 instead"
  @spec get_branding(config) :: {:ok, map} | error
  def get_branding(%Config{} = config) do
    Branding.get(config) |> to_response
  end

  @doc """
  Update branding settings.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Branding/patch_branding

  """
  @deprecated "Use Auth0.Api.Management.update_branding/2 instead"
  @spec update_branding(map, config) ::
          {:ok, map} | error
  def update_branding(%{} = params, %Config{} = config) do
    Branding.update(params, config)
    |> to_response
  end

  @doc """
  Get template for New Universal Login Experience.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Branding/get_universal_login

  """
  @deprecated "Use Auth0.Api.Management.get_template_for_universal_login/1 instead"
  @spec get_template_for_universal_login(config) ::
          {:ok, map} | error
  def get_template_for_universal_login(%Config{} = config) do
    Branding.get_universal_login(config) |> to_response
  end

  @doc """
  Delete template for New Universal Login Experience.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Branding/delete_universal_login

  """
  @deprecated "Use Auth0.Api.Management.delete_template_for_universal_login/1 instead"
  @spec delete_template_for_universal_login(config) :: {:ok, String.t()} | error
  def delete_template_for_universal_login(%Config{} = config) do
    Branding.delete_universal_login(config) |> to_response
  end

  @doc """
  Set template for New Universal Login Experience.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Branding/put_universal_login

  """
  @deprecated "Use Auth0.Api.Management.set_template_for_universal_login/2 instead"
  @spec set_template_for_universal_login(map, config) ::
          {:ok, String.t()} | error
  def set_template_for_universal_login(
        %{} = params,
        %Config{} = config
      ) do
    Branding.set_universal_login(params, config)
    |> to_response
  end

  @doc """
  Retrieve default branding theme.

  ## see
  https://auth0.com/docs/api/management/v2#!/Branding/get_default_branding_theme

  """
  @deprecated "Use Auth0.Api.Management.get_default_branding_theme/1 instead"
  @spec get_default_branding_theme(config) ::
          {:ok, map} | error
  def get_default_branding_theme(%Config{} = config) do
    Branding.get_default_theme(config) |> to_response
  end

  @doc """
  Get branding theme.

  ## see
  https://auth0.com/docs/api/management/v2#!/Branding/get_branding_theme

  """
  @deprecated "Use Auth0.Api.Management.get_branding_theme/2 instead"
  @spec get_branding_theme(theme_id, config) ::
          {:ok, map} | error
  def get_branding_theme(theme_id, %Config{} = config) do
    Branding.get_theme(theme_id, config) |> to_response
  end

  @doc """
  Delete branding theme.

  ## see
  https://auth0.com/docs/api/management/v2#!/Branding/delete_branding_theme

  """
  @deprecated "Use Auth0.Api.Management.delete_branding_theme/2 instead"
  @spec delete_branding_theme(theme_id, config) ::
          {:ok, String.t()} | error
  def delete_branding_theme(theme_id, %Config{} = config) do
    Branding.delete_theme(theme_id, config) |> to_response
  end

  @doc """
  Update branding theme.

  ## see
  https://auth0.com/docs/api/management/v2#!/Branding/patch_branding_theme

  """
  @deprecated "Use Auth0.Api.Management.update_branding_theme/3 instead"
  @spec update_branding_theme(theme_id, map, config) ::
          {:ok, map} | error
  def update_branding_theme(theme_id, %{} = params, %Config{} = config) do
    Branding.update_theme(theme_id, params, config) |> to_response
  end

  @doc """
  Create branding theme.

  ## see
  https://auth0.com/docs/api/management/v2#!/Branding/post_branding_theme

  """
  @deprecated "Use Auth0.Api.Management.create_branding_theme/2 instead"
  @spec create_branding_theme(map, config) ::
          {:ok, map} | error
  def create_branding_theme(%{} = params, %Config{} = config) do
    Branding.create_theme(params, config) |> to_response
  end

  @doc """
  Get client grants.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Client_Grants/get_client_grants

  """
  @deprecated "Use Auth0.Api.Management.get_client_grants/2 instead"
  @spec get_client_grants(map, config) ::
          {:ok, map} | error
  def get_client_grants(%{} = params, %Config{} = config) do
    ClientGrants.list(params, config)
    |> to_response
  end

  @doc """
  Create client grant.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Client_Grants/post_client_grants

  """
  @deprecated "Use Auth0.Api.Management.create_client_grant/2 instead"
  @spec create_client_grant(map, config) ::
          {:ok, map} | error
  def create_client_grant(%{} = params, %Config{} = config) do
    ClientGrants.create(params, config)
    |> to_response
  end

  @doc """
  Delete client grant.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Client_Grants/delete_client_grants_by_id

  """
  @deprecated "Use Auth0.Api.Management.delete_client_grant/2 instead"
  @spec delete_client_grant(id, config) :: {:ok, String.t()} | error
  def delete_client_grant(id, %Config{} = config) do
    ClientGrants.delete(id, config) |> to_response
  end

  @doc """
  Update client grant.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Client_Grants/patch_client_grants_by_id

  """
  @deprecated "Use Auth0.Api.Management.update_client_grant/2 instead"
  @spec update_client_grant(id, map, config) ::
          {:ok, map} | error
  def update_client_grant(id, %{} = params, %Config{} = config) do
    ClientGrants.update(id, params, config)
    |> to_response
  end

  @doc """
  Get clients.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Clients/get_clients

  """
  @deprecated "Use Auth0.Api.Management.get_clients/2 instead"
  @spec get_clients(map, config) ::
          {:ok, map} | error
  def get_clients(%{} = params, %Config{} = config) do
    Clients.list(params, config)
    |> to_response
  end

  @doc """
  Create a client.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Clients/post_clients

  """
  @deprecated "Use Auth0.Api.Management.create_client/2 instead"
  @spec create_client(map, config) ::
          {:ok, map} | error
  def create_client(%{} = params, %Config{} = config) do
    Clients.create(params, config)
    |> to_response
  end

  @doc """
  Get a client.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Clients/get_clients_by_id

  """
  @deprecated "Use Auth0.Api.Management.get_client/3 instead"
  @spec get_client(id, map, config) ::
          {:ok, map} | error
  def get_client(id, %{} = params, %Config{} = config) do
    Clients.get(id, params, config)
    |> to_response
  end

  @doc """
  Delete a client.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Clients/delete_clients_by_id

  """
  @deprecated "Use Auth0.Api.Management.delete_client/2 instead"
  @spec delete_client(id, config) :: {:ok, String.t()} | error
  def delete_client(id, %Config{} = config) do
    Clients.delete(id, config) |> to_response
  end

  @doc """
  Update a client.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Clients/patch_clients_by_id

  """
  @deprecated "Use Auth0.Api.Management.update_client/3 instead"
  @spec update_client(id, map, config) ::
          {:ok, map} | error
  def update_client(id, %{} = params, %Config{} = config) do
    Clients.update(id, params, config)
    |> to_response
  end

  @doc """
  Rotate a client secret.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Clients/post_rotate_secret

  """
  @deprecated "Use Auth0.Api.Management.rotate_client_secret/2 instead"
  @spec rotate_client_secret(id, config) ::
          {:ok, Entity.Client.t(), response_body} | error
  def rotate_client_secret(id, %Config{} = config) do
    Clients.rotate_secret(id, config) |> to_response
  end

  @doc """
  Get all connections.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Connections/get_connections

  """
  @deprecated "Use Auth0.Api.Management.get_connections/2 instead"
  @spec get_connections(map, config) ::
          {:ok, map} | error
  def get_connections(%{} = params, %Config{} = config) do
    Connections.list(params, config)
    |> to_response
  end

  @doc """
  Create a connection.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Connections/post_connections

  """
  @deprecated "Use Auth0.Api.Management.create_connection/2 instead"
  @spec create_connection(map, config) ::
          {:ok, map} | error
  def create_connection(%{} = params, %Config{} = config) do
    Connections.create(params, config)
    |> to_response
  end

  @doc """
  Get a connection.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Connections/get_connections_by_id

  """
  @deprecated "Use Auth0.Api.Management.get_connection/2 instead"
  @spec get_connection(id, map, config) ::
          {:ok, map} | error
  def get_connection(id, %{} = params, %Config{} = config) do
    Connections.get(id, params, config)
    |> to_response
  end

  @doc """
  Delete a connection.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Connections/delete_connections_by_id

  """
  @deprecated "Use Auth0.Api.Management.delete_connection/2 instead"
  @spec delete_connection(id, config) :: {:ok, String.t()} | error
  def delete_connection(id, %Config{} = config) do
    Connections.delete(id, config) |> to_response
  end

  @doc """
  Update a connection.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Connections/patch_connections_by_id

  """
  @deprecated "Use Auth0.Api.Management.update_connection/3 instead"
  @spec update_connection(id, map, config) ::
          {:ok, map} | error
  def update_connection(id, %{} = params, %Config{} = config) do
    Connections.update(id, params, config)
    |> to_response
  end

  @doc """
  Check connection status.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Connections/get_status

  """
  @deprecated "Use Auth0.Api.Management.get_connection_status/2 instead"
  @spec get_connection_status(id, config) :: {:ok, boolean} | error
  def get_connection_status(id, %Config{} = config) do
    Connections.get_status(id, config) |> to_response
  end

  @doc """
  Delete a connection user.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Connections/delete_users_by_email

  """
  @deprecated "Use Auth0.Api.Management.delete_connection_users/3 instead"
  @spec delete_connection_users(id, map, config) ::
          {:ok, String.t()} | error
  def delete_connection_users(id, %{} = params, %Config{} = config) do
    Connections.delete_users(id, params, config)
    |> to_response
  end

  @doc """
  Get custom domains configurations.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Custom_Domains/get_custom_domains

  """
  @deprecated "Use Auth0.Api.Management.get_custom_domain_configurations/1 instead"
  @spec get_custom_domain_configurations(config) ::
          {:ok, map} | error
  def get_custom_domain_configurations(%Config{} = config) do
    CustomDomains.list(config) |> to_response
  end

  @doc """
  Configure a new custom domain.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Custom_Domains/post_custom_domains

  """
  @deprecated "Use Auth0.Api.Management.configure_custom_domain/2 instead"
  @spec configure_custom_domain(map, config) ::
          {:ok, map} | error
  def configure_custom_domain(%{} = params, %Config{} = config) do
    CustomDomains.configure(params, config)
    |> to_response
  end

  @doc """
  Get custom domain configuration.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Custom_Domains/get_custom_domains_by_id

  """
  @deprecated "Use Auth0.Api.Management.get_custom_domain_configuration/2 instead"
  @spec get_custom_domain_configuration(id, config) ::
          {:ok, map} | error
  def get_custom_domain_configuration(id, %Config{} = config) do
    CustomDomains.get(id, config) |> to_response
  end

  @doc """
  Delete custom domain configuration.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Custom_Domains/delete_custom_domains_by_id

  """
  @deprecated "Use Auth0.Api.Management.delete_custom_domain_configuration/2 instead"
  @spec delete_custom_domain_configuration(id, config) :: {:ok, String.t()} | error
  def delete_custom_domain_configuration(id, %Config{} = config) do
    CustomDomains.delete(id, config) |> to_response
  end

  @doc """
  Update custom domain configuration.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Custom_Domains/patch_custom_domains_by_id

  """
  @deprecated "Use Auth0.Api.Management.update_custom_domain_configuration/3 instead"
  @spec update_custom_domain_configuration(id, map, config) ::
          {:ok, map} | error
  def update_custom_domain_configuration(
        id,
        %{} = params,
        %Config{} = config
      ) do
    CustomDomains.update(id, params, config)
    |> to_response
  end

  @doc """
  Verify a custom domain.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Custom_Domains/post_verify

  """
  @deprecated "Use Auth0.Api.Management.verify_custom_domain/2 instead"
  @spec verify_custom_domain(id, config) ::
          {:ok, map} | error
  def verify_custom_domain(id, %Config{} = config) do
    CustomDomains.verify(id, config) |> to_response
  end

  @doc """
  Retrieve device credentials.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Device_Credentials/get_device_credentials

  """
  @deprecated "Use Auth0.Api.Management.get_device_credentials/2 instead"
  @spec get_device_credentials(map, config) ::
          {:ok, map} | error
  def get_device_credentials(%{} = params, %Config{} = config) do
    DeviceCredentials.list(params, config)
    |> to_response
  end

  @doc """
  Create a device public key credential.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Device_Credentials/post_device_credentials

  """
  @deprecated "Use Auth0.Api.Management.create_device_credential/2 instead"
  @spec create_device_credential(map, config) ::
          {:ok, map} | error
  def create_device_credential(%{} = params, %Config{} = config) do
    DeviceCredentials.create(params, config)
    |> to_response
  end

  @doc """
  Delete a device credential.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Device_Credentials/delete_device_credentials_by_id

  """
  @deprecated "Use Auth0.Api.Management.delete_device_credential/2 instead"
  @spec delete_device_credential(id, config) :: {:ok, String.t()} | error
  def delete_device_credential(id, %Config{} = config) do
    DeviceCredentials.delete(id, config) |> to_response
  end

  @doc """
  Get grants.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Grants/get_grants

  """
  @deprecated "Use Auth0.Api.Management.get_grants/2 instead"
  @spec get_grants(map, config) ::
          {:ok, map} | error
  def get_grants(%{} = params, %Config{} = config) do
    Grants.list(params, config)
    |> to_response
  end

  @doc """
  Delete a grant.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Grants/delete_grants_by_id

  """
  @deprecated "Use Auth0.Api.Management.delete_grant/2 instead"
  @spec delete_grant(id, config) :: {:ok, String.t()} | error
  def delete_grant(id, %Config{} = config) do
    Grants.delete(id, config) |> to_response
  end

  @doc """
  Get hooks.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Hooks/get_hooks

  """
  @deprecated "Use Auth0.Api.Management.get_hooks/2 instead"
  @spec get_hooks(map, config) ::
          {:ok, map} | error
  def get_hooks(%{} = params, %Config{} = config) do
    Hooks.list(params, config)
    |> to_response
  end

  @doc """
  Create a hook.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Hooks/post_hooks

  """
  @deprecated "Use Auth0.Api.Management.create_hook/2 instead"
  @spec create_hook(map, config) ::
          {:ok, map} | error
  def create_hook(%{} = params, %Config{} = config) do
    Hooks.create(params, config)
    |> to_response
  end

  @doc """
  Get a hook.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Hooks/get_hooks_by_id

  """
  @deprecated "Use Auth0.Api.Management.get_hook/3 instead"
  @spec get_hook(id, map, config) ::
          {:ok, map} | error
  def get_hook(id, %{} = params, %Config{} = config) do
    Hooks.get(id, params, config)
    |> to_response
  end

  @doc """
  Delete a hook.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Hooks/delete_hooks_by_id

  """
  @deprecated "Use Auth0.Api.Management.delete_hook/2 instead"
  @spec delete_hook(id, config) :: {:ok, String.t(), response_body} | error
  def delete_hook(id, %Config{} = config) do
    Hooks.delete(id, config) |> to_response
  end

  @doc """
  Update a hook.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Hooks/patch_hooks_by_id

  """
  @deprecated "Use Auth0.Api.Management.update_hook/3 instead"
  @spec update_hook(id, map, config) ::
          {:ok, map} | error
  def update_hook(id, %{} = params, %Config{} = config) do
    Hooks.update(id, params, config)
    |> to_response
  end

  @doc """
  Get hook secrets.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Hooks/get_secrets

  """
  @deprecated "Use Auth0.Api.Management.get_hook_secrets/2 instead"
  @spec get_hook_secrets(id, config) ::
          {:ok, map} | error
  def get_hook_secrets(id, %Config{} = config) do
    Hooks.get_secrets(id, config) |> to_response
  end

  @doc """
  Delete hook secrets.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Hooks/delete_secrets

  """
  @deprecated "Use Auth0.Api.Management.delete_hook_secrets/3 instead"
  @spec delete_hook_secrets(id, map, config) ::
          {:ok, String.t()} | error
  def delete_hook_secrets(id, %{} = params, %Config{} = config) do
    Hooks.delete_secrets(id, params, config)
    |> to_response
  end

  @doc """
  Update hook secrets.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Hooks/patch_hooks_by_id

  """
  @deprecated "Use Auth0.Api.Management.update_hook_secrets/3 instead"
  @spec update_hook_secrets(id, map, config) ::
          {:ok, map} | error
  def update_hook_secrets(id, %{} = params, %Config{} = config) do
    Hooks.update_secrets(id, params, config)
    |> to_response
  end

  @doc """
  Add hook secrets.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Hooks/post_secrets

  """
  @deprecated "Use Auth0.Api.Management.add_hook_secrets/3 instead"
  @spec add_hook_secrets(id, map, config) ::
          {:ok, map} | error
  def add_hook_secrets(id, %{} = params, %Config{} = config) do
    Hooks.add_secrets(id, params, config)
    |> to_response
  end

  @doc """
  Get log streams.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Log_Streams/get_log_streams

  """
  @deprecated "Use Auth0.Api.Management.get_log_streams/1 instead"
  @spec get_log_streams(config) :: {:ok, Entity.LogStreams.t(), response_body} | error
  def get_log_streams(%Config{} = config) do
    LogStreams.list(config) |> to_response
  end

  @doc """
  Create a log stream.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Log_Streams/post_log_streams

  """
  @deprecated "Use Auth0.Api.Management.create_log_stream/2 instead"
  @spec create_log_stream(map, config) ::
          {:ok, map} | error
  def create_log_stream(%{} = params, %Config{} = config) do
    LogStreams.create(params, config)
    |> to_response
  end

  @doc """
  Get log stream by ID.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Log_Streams/get_log_streams_by_id

  """
  @deprecated "Use Auth0.Api.Management.get_log_stream/2 instead"
  @spec get_log_stream(id, config) ::
          {:ok, map} | error
  def get_log_stream(id, %Config{} = config) do
    LogStreams.get(id, config) |> to_response
  end

  @doc """
  Delete log stream.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Log_Streams/delete_log_streams_by_id

  """
  @deprecated "Use Auth0.Api.Management.delete_log_stream/2 instead"
  @spec delete_log_stream(id, config) :: {:ok, String.t()} | error
  def delete_log_stream(id, %Config{} = config) do
    LogStreams.delete(id, config) |> to_response
  end

  @doc """
  Update a log stream.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Log_Streams/patch_log_streams_by_id

  """
  @deprecated "Use Auth0.Api.Management.update_log_stream/3 instead"
  @spec update_log_stream(id, map, config) ::
          {:ok, map} | error
  def update_log_stream(id, %{} = params, %Config{} = config) do
    LogStreams.update(id, params, config)
    |> to_response
  end

  @doc """
  Search log events.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Logs/get_logs

  """
  @deprecated "Use Auth0.Api.Management.get_log_events/2 instead"
  @spec get_log_events(map, config) ::
          {:ok, map} | error
  def get_log_events(%{} = params, %Config{} = config) do
    Logs.list(params, config)
    |> to_response
  end

  @doc """
  Get a log event by id.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Logs/get_logs_by_id

  """
  @deprecated "Use Auth0.Api.Management.get_log_event/2 instead"
  @spec get_log_event(id, config) :: {:ok, map} | error
  def get_log_event(id, %Config{} = config) do
    Logs.get(id, config) |> to_response
  end

  @doc """
  Get organizations.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Organizations/get_organizations

  """
  @deprecated "Use Auth0.Api.Management.get_organizations/2 instead"
  @spec get_organizations(map, config) ::
          {:ok, map} | error
  def get_organizations(%{} = params, %Config{} = config) do
    Organizations.list(params, config)
    |> to_response
  end

  @doc """
  Create an Organization.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Organizations/post_organizations

  """
  @deprecated "Use Auth0.Api.Management.create_organization/2 instead"
  @spec create_organization(map, config) ::
          {:ok, map} | error
  def create_organization(%{} = params, %Config{} = config) do
    Organizations.create(params, config)
    |> to_response
  end

  @doc """
  Get organization.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Organizations/get_organizations_by_id

  """
  @deprecated "Use Auth0.Api.Management.get_organization/2 instead"
  @spec get_organization(id, config) ::
          {:ok, map} | error
  def get_organization(id, %Config{} = config) do
    Organizations.get(id, config) |> to_response
  end

  @doc """
  Delete organization.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Organizations/delete_organizations_by_id

  """
  @deprecated "Use Auth0.Api.Management.delete_organization/2 instead"
  @spec delete_organization(id, config) :: {:ok, String.t()} | error
  def delete_organization(id, %Config{} = config) do
    Organizations.delete(id, config) |> to_response
  end

  @doc """
  Modify an Organization.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Organizations/patch_organizations_by_id

  """
  @deprecated "Use Auth0.Api.Management.modify_organization/3 instead"
  @spec modify_organization(id, map, config) ::
          {:ok, map} | error
  def modify_organization(id, %{} = params, %Config{} = config) do
    Organizations.modify(id, params, config)
    |> to_response
  end

  @doc """
  Get organization by name.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Organizations/get_name_by_name

  """
  @deprecated "Use Auth0.Api.Management.get_organization_by_name/2 instead"
  @spec get_organization_by_name(name, config) ::
          {:ok, map} | error
  def get_organization_by_name(name, %Config{} = config) do
    Organizations.get_by_name(name, config) |> to_response
  end

  @doc """
  Get connections enabled for an organization.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Organizations/get_enabled_connections

  """
  @deprecated "Use Auth0.Api.Management.get_organization_connections/3 instead"
  @spec get_organization_connections(id, map, config) ::
          {:ok, map} | error
  def get_organization_connections(
        id,
        %{} = params,
        %Config{} = config
      ) do
    Organizations.list_connections(id, params, config)
    |> to_response
  end

  @doc """
  Add connections to an organization.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Organizations/post_enabled_connections

  """
  @deprecated "Use Auth0.Api.Management.add_organization_connection/3 instead"
  @spec add_organization_connection(
          id,
          map,
          config
        ) ::
          {:ok, map} | error
  def add_organization_connection(
        id,
        %{} = params,
        %Config{} = config
      ) do
    Organizations.add_connection(id, params, config)
    |> to_response
  end

  @doc """
  Get an enabled connection for an organization.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Organizations/get_enabled_connections_by_connectionId

  """
  @deprecated "Use Auth0.Api.Management.get_organization_connection/3 instead"
  @spec get_organization_connection(id, connection_id, config) ::
          {:ok, map} | error
  def get_organization_connection(id, connection_id, %Config{} = config) do
    Organizations.get_connection(id, connection_id, config) |> to_response
  end

  @doc """
  Delete connections from an organization.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Organizations/delete_enabled_connections_by_connectionId

  """
  @deprecated "Use Auth0.Api.Management.delete_organization_connection/3 instead"
  @spec delete_organization_connection(id, connection_id, config) ::
          {:ok, String.t()} | error
  def delete_organization_connection(id, connection_id, %Config{} = config) do
    Organizations.delete_connection(id, connection_id, config) |> to_response
  end

  @doc """
  Modify an Organizations Connection.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Organizations/patch_enabled_connections_by_connectionId

  """
  @deprecated "Use Auth0.Api.Management.modify_organization_connection/4 instead"
  @spec modify_organization_connection(
          id,
          connection_id,
          map,
          config
        ) ::
          {:ok, map} | error
  def modify_organization_connection(
        id,
        connection_id,
        %{} = params,
        %Config{} = config
      ) do
    Organizations.modify_connection(id, connection_id, params, config)
    |> to_response
  end

  @doc """
  Get invitations to organization.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Organizations/get_invitations

  """
  @deprecated "Use Auth0.Api.Management.get_organization_invitations/3 instead"
  @spec get_organization_invitations(id, map, config) ::
          {:ok, map} | error
  def get_organization_invitations(
        id,
        %{} = params,
        %Config{} = config
      ) do
    Organizations.list_invitations(id, params, config)
    |> to_response
  end

  @doc """
  Create invitations to organization.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Organizations/post_invitations

  """
  @deprecated "Use Auth0.Api.Management.create_organization_invitation/3 instead"
  @spec create_organization_invitation(id, map, config) ::
          {:ok, map} | error
  def create_organization_invitation(
        id,
        %{} = params,
        %Config{} = config
      ) do
    Organizations.create_invitation(id, params, config)
    |> to_response
  end

  @doc """
  Get an invitation to organization.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Organizations/get_invitations_by_invitation_id

  """
  @deprecated "Use Auth0.Api.Management.get_organization_invitation/4 instead"
  @spec get_organization_invitation(
          id,
          invitation_id,
          map,
          config
        ) ::
          {:ok, map} | error
  def get_organization_invitation(
        id,
        invitation_id,
        %{} = params,
        %Config{} = config
      ) do
    Organizations.get_invitation(id, invitation_id, params, config)
    |> to_response
  end

  @doc """
  Delete an invitation to organization.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Organizations/delete_invitations_by_invitation_id

  """
  @deprecated "Use Auth0.Api.Management.delete_organization_invitation/3 instead"
  @spec delete_organization_invitation(id, invitation_id, config) ::
          {:ok, String.t()} | error
  def delete_organization_invitation(id, invitation_id, %Config{} = config) do
    Organizations.delete_invitation(id, invitation_id, config) |> to_response
  end

  @doc """
  Get members who belong to an organization.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Organizations/get_members

  """
  @deprecated "Use Auth0.Api.Management.get_organization_members/3 instead"
  @spec get_organization_members(id, map, config) ::
          {:ok, map} | error
  def get_organization_members(
        id,
        %{} = params,
        %Config{} = config
      ) do
    Organizations.list_members(id, params, config)
    |> to_response
  end

  @doc """
  Delete members from an organization.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Organizations/delete_members

  """
  @deprecated "Use Auth0.Api.Management.delete_organization_members/3 instead"
  @spec delete_organization_members(id, map, config) ::
          {:ok, String.t()} | error
  def delete_organization_members(
        id,
        %{} = params,
        %Config{} = config
      ) do
    Organizations.delete_members(id, params, config)
    |> to_response
  end

  @doc """
  Add members to an organization.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Organizations/post_members

  """
  @deprecated "Use Auth0.Api.Management.add_organization_members/3 instead"
  @spec add_organization_members(id, map, config) ::
          {:ok, String.t()} | error
  def add_organization_members(
        id,
        %{} = params,
        %Config{} = config
      ) do
    Organizations.add_members(id, params, config)
    |> to_response
  end

  @doc """
  Get the roles assigned to an organization member.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Organizations/get_organization_member_roles

  """
  @deprecated "Use Auth0.Api.Management.get_organization_roles/4 instead"
  @spec get_organization_roles(id, user_id, map, config) ::
          {:ok, map} | error
  def get_organization_roles(
        id,
        user_id,
        %{} = params,
        %Config{} = config
      ) do
    Organizations.list_roles(id, user_id, params, config)
    |> to_response
  end

  @doc """
  Delete members from an organization.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Organizations/delete_members

  """
  @deprecated "Use Auth0.Api.Management.delete_organization_roles/4 instead"
  @spec delete_organization_roles(
          id,
          user_id,
          map,
          config
        ) ::
          {:ok, String.t()} | error
  def delete_organization_roles(
        id,
        user_id,
        %{} = params,
        %Config{} = config
      ) do
    Organizations.delete_roles(id, user_id, params, config)
    |> to_response
  end

  @doc """
  Add members to an organization.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Organizations/post_members

  """
  @deprecated "Use Auth0.Api.Management.assign_organization_roles/4 instead"
  @spec assign_organization_roles(id, user_id, map, config) ::
          {:ok, String.t()} | error
  def assign_organization_roles(
        id,
        user_id,
        %{} = params,
        %Config{} = config
      ) do
    Organizations.assign_roles(id, user_id, params, config)
    |> to_response
  end

  @doc """
  Get prompts settings.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Prompts/get_prompts

  """
  @deprecated "Use Auth0.Api.Management.get_prompt_setting/1 instead"
  @spec get_prompt_setting(config) :: {:ok, map} | error
  def get_prompt_setting(%Config{} = config) do
    Prompts.get(config) |> to_response
  end

  @doc """
  Update prompts settings.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Prompts/patch_prompts

  """
  @deprecated "Use Auth0.Api.Management.update_prompt_setting/2 instead"
  @spec update_prompt_setting(map, config) ::
          {:ok, map} | error
  def update_prompt_setting(%{} = params, %Config{} = config) do
    Prompts.update(params, config)
    |> to_response
  end

  @doc """
  Get custom text for a prompt.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Prompts/get_custom_text_by_language

  """
  @deprecated "Use Auth0.Api.Management.get_prompt_custom_text/3 instead"
  @spec get_prompt_custom_text(prompt, language, config) ::
          {:ok, map} | error
  def get_prompt_custom_text(prompt, language, %Config{} = config) do
    Prompts.get_custom_text(prompt, language, config) |> to_response
  end

  @doc """
  Set custom text for a specific prompt.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Prompts/put_custom_text_by_language

  """
  @deprecated "Use Auth0.Api.Management.set_prompt_custom_text/4 instead"
  @spec set_prompt_custom_text(prompt, language, map, config) ::
          {:ok, map} | error
  def set_prompt_custom_text(
        prompt,
        language,
        %{} = params,
        %Config{} = config
      ) do
    Prompts.set_custom_text(prompt, language, params, config)
    |> to_response
  end

  @doc """
  Get resource servers.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Resource_Servers/get_resource_servers

  """
  @deprecated "Use Auth0.Api.Management.get_resource_servers/2 instead"
  @spec get_resource_servers(map, config) ::
          {:ok, map} | error
  def get_resource_servers(%{} = params, %Config{} = config) do
    ResourceServers.list(params, config)
    |> to_response
  end

  @doc """
  Create a resource server.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Resource_Servers/post_resource_servers

  """
  @deprecated "Use Auth0.Api.Management.create_resource_server/2 instead"
  @spec create_resource_server(map, config) ::
          {:ok, map} | error
  def create_resource_server(%{} = params, %Config{} = config) do
    ResourceServers.create(params, config)
    |> to_response
  end

  @doc """
  Get a resource server.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Resource_Servers/get_resource_servers_by_id

  """
  @deprecated "Use Auth0.Api.Management.get_resource_server/3 instead"
  @spec get_resource_server(id, map, config) ::
          {:ok, map} | error
  def get_resource_server(id, %{} = params, %Config{} = config) do
    ResourceServers.get(id, params, config)
    |> to_response
  end

  @doc """
  Delete a resource server.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Resource_Servers/delete_resource_servers_by_id

  """
  @deprecated "Use Auth0.Api.Management.delete_resource_server/2 instead"
  @spec delete_resource_server(id, config) :: {:ok, String.t()} | error
  def delete_resource_server(id, %Config{} = config) do
    ResourceServers.delete(id, config) |> to_response
  end

  @doc """
  Update a resource server.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Resource_Servers/get_resource_servers_by_id

  """
  @deprecated "Use Auth0.Api.Management.update_resource_server/3 instead"
  @spec update_resource_server(id, map, config) ::
          {:ok, map} | error
  def update_resource_server(id, %{} = params, %Config{} = config) do
    ResourceServers.update(id, params, config)
    |> to_response
  end

  @doc """
  Get roles.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Roles/get_roles

  """
  @deprecated "Use Auth0.Api.Management.get_roles/2 instead"
  @spec get_roles(map, config) ::
          {:ok, map} | error
  def get_roles(%{} = params, %Config{} = config) do
    Roles.list(params, config)
    |> to_response
  end

  @doc """
  Create a role.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Roles/post_roles

  """
  @deprecated "Use Auth0.Api.Management.create_role/2 instead"
  @spec create_role(map, config) ::
          {:ok, map} | error
  def create_role(%{} = params, %Config{} = config) do
    Roles.create(params, config)
    |> to_response
  end

  @doc """
  Get a role.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Roles/get_roles_by_id

  """
  @deprecated "Use Auth0.Api.Management.get_role/2 instead"
  @spec get_role(id, config) :: {:ok, map} | error
  def get_role(id, %Config{} = config) do
    Roles.get(id, config) |> to_response
  end

  @doc """
  Delete a role.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Roles/delete_roles_by_id

  """
  @deprecated "Use Auth0.Api.Management.delete_role/2 instead"
  @spec delete_role(id, config) :: {:ok, String.t()} | error
  def delete_role(id, %Config{} = config) do
    Roles.delete(id, config) |> to_response
  end

  @doc """
  Update a role.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Roles/patch_roles_by_id

  """
  @deprecated "Use Auth0.Api.Management.update_role/3 instead"
  @spec update_role(id, map, config) ::
          {:ok, map} | error
  def update_role(id, %{} = params, %Config{} = config) do
    Roles.update(id, params, config)
    |> to_response
  end

  @doc """
  Get permissions granted by role.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Roles/get_role_permission

  """
  @deprecated "Use Auth0.Api.Management.get_role_permissions/3 instead"
  @spec get_role_permissions(id, map, config) ::
          {:ok, map} | error
  def get_role_permissions(id, %{} = params, %Config{} = config) do
    Roles.list_permissions(id, params, config)
    |> to_response
  end

  @doc """
  Remove permissions from a role.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Roles/delete_role_permission_assignment

  """
  @deprecated "Use Auth0.Api.Management.remove_role_permissions/3 instead"
  @spec remove_role_permissions(id, map, config) ::
          {:ok, String.t()} | error
  def remove_role_permissions(id, %{} = params, %Config{} = config) do
    Roles.remove_permissions(id, params, config)
    |> to_response
  end

  @doc """
  Associate permissions with a role.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Roles/post_role_permission_assignment

  """
  @deprecated "Use Auth0.Api.Management.associate_role_permissions/3 instead"
  @spec associate_role_permissions(id, map, config) ::
          {:ok, String.t()} | error
  def associate_role_permissions(
        id,
        %{} = params,
        %Config{} = config
      ) do
    Roles.associate_permissions(id, params, config)
    |> to_response
  end

  @doc """
  Get a role's users.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Roles/get_role_user

  """
  @deprecated "Use Auth0.Api.Management.get_role_users/3 instead"
  @spec get_role_users(id, map, config) ::
          {:ok, map} | error
  def get_role_users(id, %{} = params, %Config{} = config) do
    Roles.list_users(id, params, config)
    |> to_response
  end

  @doc """
  Assign users to a role.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Roles/post_role_users

  """
  @deprecated "Use Auth0.Api.Management.assign_role_users/3 instead"
  @spec assign_role_users(id, map, config) ::
          {:ok, String.t()} | error
  def assign_role_users(id, %{} = params, %Config{} = config) do
    Roles.assign_users(id, params, config)
    |> to_response
  end

  @doc """
  Get rules.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Rules/get_rules

  """
  @deprecated "Use Auth0.Api.Management.get_rules/2 instead"
  @spec get_rules(map, config) ::
          {:ok, map} | error
  def get_rules(%{} = params, %Config{} = config) do
    Rules.list(params, config)
    |> to_response
  end

  @doc """
  Create a rule.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Rules/post_rules

  """
  @deprecated "Use Auth0.Api.Management.create_rule/2 instead"
  @spec create_rule(map, config) ::
          {:ok, map} | error
  def create_rule(%{} = params, %Config{} = config) do
    Rules.create(params, config)
    |> to_response
  end

  @doc """
  Get a rule.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Rules/get_rules_by_id

  """
  @deprecated "Use Auth0.Api.Management.get_rule/3 instead"
  @spec get_rule(id, map, config) ::
          {:ok, map} | error
  def get_rule(id, %{} = params, %Config{} = config) do
    Rules.get(id, params, config)
    |> to_response
  end

  @doc """
  Delete a rule.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Rules/delete_rules_by_id

  """
  @deprecated "Use Auth0.Api.Management.delete_rule/2 instead"
  @spec delete_rule(id, config) :: {:ok, String.t()} | error
  def delete_rule(id, %Config{} = config) do
    Rules.delete(id, config) |> to_response
  end

  @doc """
  Update a rule.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Rules/patch_rules_by_id

  """
  @deprecated "Use Auth0.Api.Management.update_rule/3 instead"
  @spec update_rule(id, map, config) ::
          {:ok, map} | error
  def update_rule(id, %{} = params, %Config{} = config) do
    Rules.update(id, params, config)
    |> to_response
  end

  @doc """
  Retrieve config variable keys for rules (get_rules-configs).

  ## see
  https://auth0.com/docs/api/management/v2/#!/Rules_Configs/get_rules_configs

  """
  @deprecated "Use Auth0.Api.Management.get_rules_configs/1 instead"
  @spec get_rules_configs(config) ::
          {:ok, map} | error
  def get_rules_configs(%Config{} = config) do
    RulesConfigs.list(config) |> to_response
  end

  @doc """
  Delete rules config for a given key.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Rules_Configs/delete_rules_configs_by_key

  """
  @deprecated "Use Auth0.Api.Management.delete_rules_config/2 instead"
  @spec delete_rules_config(key, config) :: {:ok, String.t()} | error
  def delete_rules_config(key, %Config{} = config) do
    RulesConfigs.delete(key, config) |> to_response
  end

  @doc """
  Set rules config for a given key.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Rules_Configs/put_rules_configs_by_key

  """
  @deprecated "Use Auth0.Api.Management.set_rules_config/3 instead"
  @spec set_rules_config(key, map, config) ::
          {:ok, map} | error
  def set_rules_config(key, %{} = params, %Config{} = config) do
    RulesConfigs.set(key, params, config)
    |> to_response
  end

  @doc """
  Get blocks by identifier.

  ## see
  https://auth0.com/docs/api/management/v2/#!/User_Blocks/get_user_blocks

  """
  @deprecated "Use Auth0.Api.Management.get_user_block/2 instead"
  @spec get_user_block(map, config) ::
          {:ok, map} | error
  def get_user_block(%{} = params, %Config{} = config) do
    UserBlocks.get(params, config)
    |> to_response
  end

  @doc """
  Unblock by identifier.

  ## see
  https://auth0.com/docs/api/management/v2/#!/User_Blocks/delete_user_blocks

  """
  @deprecated "Use Auth0.Api.Management.unblock_user_block/2 instead"
  @spec unblock_user_block(map, config) ::
          {:ok, String.t()} | error
  def unblock_user_block(%{} = params, %Config{} = config) do
    UserBlocks.unblock(params, config)
    |> to_response
  end

  @doc """
  Get a user's blocks.

  ## see
  https://auth0.com/docs/api/management/v2/#!/User_Blocks/get_user_blocks_by_id

  """
  @deprecated "Use Auth0.Api.Management.get_user_block_by_user_id/3 instead"
  @spec get_user_block_by_user_id(id, map, config) ::
          {:ok, map} | error
  def get_user_block_by_user_id(id, %{} = params, %Config{} = config) do
    UserBlocks.get_by_user_id(id, params, config)
    |> to_response
  end

  @doc """
  Unblock a user.

  ## see
  https://auth0.com/docs/api/management/v2/#!/User_Blocks/delete_user_blocks_by_id

  """
  @deprecated "Use Auth0.Api.Management.unblock_user_block_by_user_id/2 instead"
  @spec unblock_user_block_by_user_id(id, config) :: {:ok, String.t()} | error
  def unblock_user_block_by_user_id(id, %Config{} = config) do
    UserBlocks.unblock_by_user_id(id, config) |> to_response
  end

  @doc """
  List or Search Users.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Users/get_users

  """
  @deprecated "Use Auth0.Api.Management.get_users/2 instead"
  @spec get_users(map, config) ::
          {:ok, map} | error
  def get_users(%{} = params, %Config{} = config) do
    Users.list(params, config)
    |> to_response
  end

  @doc """
  Create a User.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Users/post_users

  """
  @deprecated "Use Auth0.Api.Management.create_user/2 instead"
  @spec create_user(map, config) ::
          {:ok, map} | error
  def create_user(%{} = params, %Config{} = config) do
    Users.create(params, config)
    |> to_response
  end

  @doc """
  Get a User.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Users/get_users_by_id

  """
  @deprecated "Use Auth0.Api.Management.get_user/3 instead"
  @spec get_user(id, map, config) ::
          {:ok, map} | error
  def get_user(id, %{} = params, %Config{} = config) do
    Users.get(id, params, config)
    |> to_response
  end

  @doc """
  Delete a User.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Users/delete_users_by_id

  """
  @deprecated "Use Auth0.Api.Management.delete_user/2 instead"
  @spec delete_user(id, config) :: {:ok, String.t()} | error
  def delete_user(id, %Config{} = config) do
    Users.delete(id, config) |> to_response
  end

  @doc """
  Update a User.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Users/patch_users_by_id

  """
  @deprecated "Use Auth0.Api.Management.update_user/3 instead"
  @spec update_user(id, map, config) ::
          {:ok, map} | error
  def update_user(id, %{} = params, %Config{} = config) do
    Users.update(id, params, config)
    |> to_response
  end

  @doc """
  Get the First Confirmed Multi-factor Authentication Enrollment.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Users/get_enrollments

  """
  @deprecated "Use Auth0.Api.Management.get_user_enrollments/2 instead"
  @spec get_user_enrollments(id, config) ::
          {:ok, map} | error
  def get_user_enrollments(id, %Config{} = config) do
    Users.get_enrollments(id, config) |> to_response
  end

  @doc """
  Get a user's roles.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Users/get_user_roles

  """
  @deprecated "Use Auth0.Api.Management.get_user_roles/3 instead"
  @spec get_user_roles(id, map, config) ::
          {:ok, map} | error
  def get_user_roles(id, %{} = params, %Config{} = config) do
    Users.get_roles(id, params, config)
    |> to_response
  end

  @doc """
  Removes roles from a user.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Users/delete_user_roles

  """
  @deprecated "Use Auth0.Api.Management.remove_user_roles/3 instead"
  @spec remove_user_roles(id, map, config) ::
          {:ok, String.t()} | error
  def remove_user_roles(id, %{} = params, %Config{} = config) do
    Users.remove_roles(id, params, config)
    |> to_response
  end

  @doc """
  Assign roles to a user.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Users/post_user_roles

  """
  @deprecated "Use Auth0.Api.Management.assign_user_roles/3 instead"
  @spec assign_user_roles(id, map, config) ::
          {:ok, String.t()} | error
  def assign_user_roles(id, %{} = params, %Config{} = config) do
    Users.assign_roles(id, params, config)
    |> to_response
  end

  @doc """
  Get user's log events.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Users/get_logs_by_user

  """
  @deprecated "Use Auth0.Api.Management.get_user_logs/3 instead"
  @spec get_user_logs(id, map, config) ::
          {:ok, map} | error
  def get_user_logs(id, %{} = params, %Config{} = config) do
    Users.get_logs(id, params, config)
    |> to_response
  end

  @doc """
  List user's organizations.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Users/get_user_organizations

  """
  @deprecated "Use Auth0.Api.Management.get_user_organizations/3 instead"
  @spec get_user_organizations(id, map, config) ::
          {:ok, map} | error
  def get_user_organizations(id, %{} = params, %Config{} = config) do
    Users.get_organizations(id, params, config)
    |> to_response
  end

  @doc """
  Get a User's Permissions.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Users/get_permissions

  """
  @deprecated "Use Auth0.Api.Management.get_user_permissions/3 instead"
  @spec get_user_permissions(id, map, config) ::
          {:ok, map} | error
  def get_user_permissions(id, %{} = params, %Config{} = config) do
    Users.get_permissions(id, params, config)
    |> to_response
  end

  @doc """
  Remove Permissions from a User.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Users/delete_permissions

  """
  @deprecated "Use Auth0.Api.Management.remove_user_permissions/3 instead"
  @spec remove_user_permissions(id, map, config) ::
          {:ok, String.t()} | error
  def remove_user_permissions(id, %{} = params, %Config{} = config) do
    Users.remove_permissions(id, params, config)
    |> to_response
  end

  @doc """
  Assign Permissions to a User.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Users/post_permissions

  """
  @deprecated "Use Auth0.Api.Management.assign_user_permissions/3 instead"
  @spec assign_user_permissions(id, map, config) ::
          {:ok, String.t()} | error
  def assign_user_permissions(id, %{} = params, %Config{} = config) do
    Users.assign_permissions(id, params, config)
    |> to_response
  end

  @doc """
  Delete a User's Multi-factor Provider.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Users/delete_multifactor_by_provider

  """
  @deprecated "Use Auth0.Api.Management.delete_user_multifactor/3 instead"
  @spec delete_user_multifactor(id, map, config) ::
          {:ok, String.t()} | error
  def delete_user_multifactor(
        id,
        %{} = params,
        %Config{} = config
      ) do
    Users.delete_multifactor(id, params, config)
    |> to_response
  end

  @doc """
  Invalidate All Remembered Browsers for Multi-factor Authentication.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Users/post_invalidate_remember_browser

  """
  @deprecated "Use Auth0.Api.Management.invalidate_user_remembered_browser_for_multifactor/2 instead"
  @spec invalidate_user_remembered_browser_for_multifactor(id, config) ::
          {:ok, String.t()} | error
  def invalidate_user_remembered_browser_for_multifactor(
        id,
        %Config{} = config
      ) do
    Users.invalidate_remembered_browser_for_multifactor(id, config) |> to_response
  end

  @doc """
  Link a User Account.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Users/post_identities

  """
  @deprecated "Use Auth0.Api.Management.link_user_identities/3 instead"
  @spec link_user_identities(id, map, config) ::
          {:ok, map} | error
  def link_user_identities(
        id,
        %{} = params,
        %Config{} = config
      ) do
    Users.link_identities(id, params, config)
    |> to_response
  end

  @doc """
  Unlink a User Identity.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Users/delete_user_identity_by_user_id

  """
  @deprecated "Use Auth0.Api.Management.unlink_user_identities/4 instead"
  @spec unlink_user_identities(id, provider, user_id, config) ::
          {:ok, map} | error
  def unlink_user_identities(
        id,
        provider,
        user_id,
        %Config{} = config
      ) do
    Users.unlink_identities(id, provider, user_id, config)
    |> to_response
  end

  @doc """
  Generate New Multi-factor Authentication Recovery Code.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Users/post_recovery_code_regeneration

  """
  @deprecated "Use Auth0.Api.Management.regenerate_user_recovery_code/2 instead"
  @spec regenerate_user_recovery_code(id, config) ::
          {:ok, map} | error
  def regenerate_user_recovery_code(
        id,
        %Config{} = config
      ) do
    Users.regenerate_recovery_code(id, config) |> to_response
  end

  @doc """
  Search Users by Email.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Users_By_Email/get_users_by_email

  """
  @deprecated "Use Auth0.Api.Management.get_users_by_email/2 instead"
  @spec get_users_by_email(map, config) ::
          {:ok, map} | error
  def get_users_by_email(%{} = params, %Config{} = config) do
    UsersByEmail.list(params, config)
    |> to_response
  end

  @doc """
  Get actions.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Actions/get_actions

  """
  @deprecated "Use Auth0.Api.Management.get_actions/2 instead"
  @spec get_actions(map, config) ::
          {:ok, map} | error
  def get_actions(%{} = params, %Config{} = config) do
    Actions.list(params, config)
    |> to_response
  end

  @doc """
  Create an action.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Actions/post_action

  """
  @deprecated "Use Auth0.Api.Management.create_action/2 instead"
  @spec create_action(map, config) ::
          {:ok, map} | error
  def create_action(%{} = params, %Config{} = config) do
    Actions.create(params, config)
    |> to_response
  end

  @doc """
  Get an action.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Actions/get_action

  """
  @deprecated "Use Auth0.Api.Management.get_action/2 instead"
  @spec get_action(id, config) ::
          {:ok, map} | error
  def get_action(id, %Config{} = config) do
    Actions.get(id, config) |> to_response
  end

  @doc """
  Delete an action.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Actions/delete_action

  """
  @deprecated "Use Auth0.Api.Management.delete_action/3 instead"
  @spec delete_action(id, map, config) ::
          {:ok, String.t()} | error
  def delete_action(id, %{} = params, %Config{} = config) do
    Actions.delete(id, params, config)
    |> to_response
  end

  @doc """
  Update an action.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Actions/patch_action

  """
  @deprecated "Use Auth0.Api.Management.update_action/3 instead"
  @spec update_action(id, map, config) ::
          {:ok, map} | error
  def update_action(id, %{} = params, %Config{} = config) do
    Actions.update(id, params, config)
    |> to_response
  end

  @doc """
  Get an action's versions.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Actions/get_action_versions

  """
  @deprecated "Use Auth0.Api.Management.get_action_versions/3 instead"
  @spec get_action_versions(action_id, map, config) ::
          {:ok, map} | error
  def get_action_versions(action_id, %{} = params, %Config{} = config) do
    Actions.list_versions(action_id, params, config)
    |> to_response
  end

  @doc """
  Get a specific version of an action.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Actions/get_action_version

  """
  @deprecated "Use Auth0.Api.Management.get_action_version/3 instead"
  @spec get_action_version(action_id, id, config) ::
          {:ok, map} | error
  def get_action_version(action_id, id, %Config{} = config) do
    Actions.get_version(action_id, id, config) |> to_response
  end

  @doc """
  Roll back to a previous action version.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Actions/post_deploy_draft_version

  """
  @deprecated "Use Auth0.Api.Management.rollback_action_version/4 instead"
  @spec rollback_action_version(action_id, id, map, config) ::
          {:ok, map} | error
  def rollback_action_version(
        action_id,
        id,
        %{} = params,
        %Config{} = config
      ) do
    Actions.rollback_version(action_id, id, params, config)
    |> to_response
  end

  @doc """
  Test an Action.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Actions/post_test_action

  """
  @deprecated "Use Auth0.Api.Management.test_action/3 instead"
  @spec test_action(id, map, config) ::
          {:ok, map} | error
  def test_action(id, %{} = params, %Config{} = config) do
    Actions.test(id, params, config)
    |> to_response
  end

  @doc """
  Deploy an action.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Actions/post_deploy_action

  """
  @deprecated "Use Auth0.Api.Management.deploy_action/2 instead"
  @spec deploy_action(id, config) ::
          {:ok, map} | error
  def deploy_action(id, %Config{} = config) do
    Actions.deploy(id, config) |> to_response
  end

  @doc """
  Get triggers.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Actions/get_triggers

  """
  @deprecated "Use Auth0.Api.Management.get_action_trigger_bindings/3 instead"
  @spec get_action_trigger_bindings(trigger_id, map, config) ::
          {:ok, map} | error
  def get_action_trigger_bindings(
        trigger_id,
        %{} = params,
        %Config{} = config
      ) do
    Actions.get_bindings(trigger_id, params, config)
    |> to_response
  end

  @doc """
  Update trigger bindings.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Actions/patch_bindings

  """
  @deprecated "Use Auth0.Api.Management.update_action_trigger_bindings/3 instead"
  @spec update_action_trigger_bindings(
          trigger_id,
          map,
          config
        ) ::
          {:ok, map} | error
  def update_action_trigger_bindings(
        trigger_id,
        %{} = params,
        %Config{} = config
      ) do
    Actions.update_bindings(trigger_id, params, config)
    |> to_response
  end

  @doc """
  Get actions service status.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Actions/get_service_status

  """
  @deprecated "Use Auth0.Api.Management.get_action_status/1 instead"
  @spec get_action_status(config) ::
          {:ok, map} | error
  def get_action_status(%Config{} = config) do
    Actions.get_status(config) |> to_response
  end

  @doc """
  Get an execution.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Actions/get_execution

  """
  @deprecated "Use Auth0.Api.Management.get_action_execution/2 instead"
  @spec get_action_execution(id, config) ::
          {:ok, map} | error
  def get_action_execution(id, %Config{} = config) do
    Actions.get_execution(id, config) |> to_response
  end

  @doc """
  Get blacklisted tokens.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Blacklists/get_tokens

  """
  @deprecated "Use Auth0.Api.Management.get_blacklisted_tokens/2 instead"
  @spec get_blacklisted_tokens(map, config) ::
          {:ok, map} | error
  def get_blacklisted_tokens(%{} = params, %Config{} = config) do
    Blacklist.list_tokens(params, config)
    |> to_response
  end

  @doc """
  Blacklist a token.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Blacklists/post_tokens

  """
  @deprecated "Use Auth0.Api.Management.blacklist_token/2 instead"
  @spec blacklist_token(map, config) ::
          {:ok, String.t()} | error
  def blacklist_token(%{} = params, %Config{} = config) do
    Blacklist.add_token(params, config)
    |> to_response
  end

  @doc """
  Get an email template.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Email_Templates/get_email_templates_by_templateName

  """
  @deprecated "Use Auth0.Api.Management.get_email_template/2 instead"
  @spec get_email_template(template_name, config) ::
          {:ok, map} | error
  def get_email_template(template_name, %Config{} = config) do
    EmailTemplates.get(template_name, config) |> to_response
  end

  @doc """
  Patch an email template.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Email_Templates/patch_email_templates_by_templateName

  """
  @deprecated "Use Auth0.Api.Management.patch_email_template/3 instead"
  @spec patch_email_template(template_name, map, config) ::
          {:ok, map} | error
  def patch_email_template(
        template_name,
        %{} = params,
        %Config{} = config
      ) do
    EmailTemplates.patch(template_name, params, config)
    |> to_response
  end

  @doc """
  Update an email template.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Email_Templates/put_email_templates_by_templateName

  """
  @deprecated "Use Auth0.Api.Management.update_email_template/3 instead"
  @spec update_email_template(template_name, map, config) ::
          {:ok, map} | error
  def update_email_template(
        template_name,
        %{} = params,
        %Config{} = config
      ) do
    EmailTemplates.update(template_name, params, config)
    |> to_response
  end

  @doc """
  Create an email template.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Email_Templates/post_email_templates

  """
  @deprecated "Use Auth0.Api.Management.create_email_template/2 instead"
  @spec create_email_template(map, config) ::
          {:ok, map} | error
  def create_email_template(%{} = params, %Config{} = config) do
    EmailTemplates.create(params, config)
    |> to_response
  end

  @doc """
  Get the email provider.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Emails/get_provider

  """
  @deprecated "Use Auth0.Api.Management.get_email_provider/2 instead"
  @spec get_email_provider(map, config) ::
          {:ok, map} | error
  def get_email_provider(%{} = params, %Config{} = config) do
    Emails.get_provider(params, config)
    |> to_response
  end

  @doc """
  Delete the email provider.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Emails/delete_provider

  """
  @deprecated "Use Auth0.Api.Management.delete_email_provider/1 instead"
  @spec delete_email_provider(config) :: {:ok, String.t()} | error
  def delete_email_provider(%Config{} = config) do
    Emails.delete_provider(config) |> to_response
  end

  @doc """
  Update the email provider.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Emails/patch_provider

  """
  @deprecated "Use Auth0.Api.Management.update_email_provider/2 instead"
  @spec update_email_provider(map, config) ::
          {:ok, map} | error
  def update_email_provider(%{} = params, %Config{} = config) do
    Emails.update_provider(params, config)
    |> to_response
  end

  @doc """
  Configure the email provider.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Emails/post_provider

  """
  @deprecated "Use Auth0.Api.Management.configure_email_provider/2 instead"
  @spec configure_email_provider(map, config) ::
          {:ok, map} | error
  def configure_email_provider(%{} = params, %Config{} = config) do
    Emails.configure_provider(params, config)
    |> to_response
  end

  @doc """
  Retrieve Factors and their Status.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Guardian/get_factors

  """
  @deprecated "Use Auth0.Api.Management.get_guardian_factors/1 instead"
  @spec get_guardian_factors(config) ::
          {:ok, map} | error
  def get_guardian_factors(%Config{} = config) do
    Guardian.list_factors(config) |> to_response
  end

  @doc """
  Update a Multi-factor Authentication Factor.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Guardian/put_factors_by_name

  """
  @deprecated "Use Auth0.Api.Management.update_guardian_factor/3 instead"
  @spec update_guardian_factor(name, map, config) ::
          {:ok, map} | error
  def update_guardian_factor(name, %{} = params, %Config{} = config) do
    Guardian.update_factor(name, params, config)
    |> to_response
  end

  @doc """
  Get the Multi-factor Authentication policies.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Guardian/get_policies

  """
  @deprecated "Use Auth0.Api.Management.list_guardian_policies/1 instead"
  @spec list_guardian_policies(config) :: {:ok, list(map)} | error
  def list_guardian_policies(%Config{} = config) do
    Guardian.list_policies(config) |> to_response
  end

  @doc """
  Set the Multi-factor Authentication policies.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Guardian/put_policies

  """
  @deprecated "Use Auth0.Api.Management.set_guardian_policies/2 instead"
  @spec set_guardian_policies(map, config) :: {:ok, list(map)} | error
  def set_guardian_policies(%{} = params, %Config{} = config) do
    Guardian.set_policies(params, config)
    |> to_response
  end

  @doc """
  Retrieve a multi-factor authentication enrollment.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Guardian/get_enrollments_by_id

  """
  @deprecated "Use Auth0.Api.Management.get_guardian_enrollment/2 instead"
  @spec get_guardian_enrollment(id, config) ::
          {:ok, map} | error
  def get_guardian_enrollment(id, %Config{} = config) do
    Guardian.get_enrollment(id, config) |> to_response
  end

  @doc """
  Delete a multi-factor authentication enrollment.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Guardian/delete_enrollments_by_id

  """
  @deprecated "Use Auth0.Api.Management.delete_guardian_enrollment/2 instead"
  @spec delete_guardian_enrollment(id, config) :: {:ok, String.t()} | error
  def delete_guardian_enrollment(id, %Config{} = config) do
    Guardian.delete_enrollment(id, config) |> to_response
  end

  @doc """
  Create a multi-factor authentication enrollment ticket.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Guardian/post_ticket

  """
  @deprecated "Use Auth0.Api.Management.create_guardian_enrollment_ticket/2 instead"
  @spec create_guardian_enrollment_ticket(map, config) ::
          {:ok, map} | error
  def create_guardian_enrollment_ticket(
        %{} = params,
        %Config{} = config
      ) do
    Guardian.create_enrollment_ticket(params, config)
    |> to_response
  end

  @doc """
  Retrieve the Enabled Phone Factors.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Guardian/get_message_types

  """
  @deprecated "Use Auth0.Api.Management.get_guardian_phone_factor/1 instead"
  @spec get_guardian_phone_factor(config) ::
          {:ok, map} | error
  def get_guardian_phone_factor(%Config{} = config) do
    Guardian.get_phone_factor(config) |> to_response
  end

  @doc """
  Update the Enabled Phone Factors.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Guardian/put_message_types

  """
  @deprecated "Use Auth0.Api.Management.update_guardian_phone_factor/2 instead"
  @spec update_guardian_phone_factor(map, config) ::
          {:ok, map} | error
  def update_guardian_phone_factor(
        %{} = params,
        %Config{} = config
      ) do
    Guardian.update_phone_factor(params, config)
    |> to_response
  end

  @doc """
  Retrieve phone configuration (one of auth0|twilio|phone-message-hook).

  ## see
  https://auth0.com/docs/api/management/v2/#!/Guardian/get_selected_provider

  """
  @deprecated "Use Auth0.Api.Management.get_guardian_phone_configuration/1 instead"
  @spec get_guardian_phone_configuration(config) ::
          {:ok, map} | error
  def get_guardian_phone_configuration(%Config{} = config) do
    Guardian.get_phone_configuration(config) |> to_response
  end

  @doc """
  Update phone configuration (one of auth0|twilio|phone-message-hook).

  ## see
  https://auth0.com/docs/api/management/v2/#!/Guardian/put_selected_provider

  """
  @deprecated "Use Auth0.Api.Management.update_guardian_phone_configuration/2 instead"
  @spec update_guardian_phone_configuration(map, config) ::
          {:ok, map} | error
  def update_guardian_phone_configuration(
        %{} = params,
        %Config{} = config
      ) do
    Guardian.update_phone_configuration(params, config)
    |> to_response
  end

  @doc """
  Retrieve Enrollment and Verification Phone Templates.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Guardian/get_templates

  """
  @deprecated "Use Auth0.Api.Management.get_guardian_phone_template/1 instead"
  @spec get_guardian_phone_template(config) ::
          {:ok, map} | error
  def get_guardian_phone_template(%Config{} = config) do
    Guardian.get_phone_template(config) |> to_response
  end

  @doc """
  Update Enrollment and Verification Phone Templates.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Guardian/put_templates

  """
  @deprecated "Use Auth0.Api.Management.update_guardian_phone_template/2 instead"
  @spec update_guardian_phone_template(map, config) ::
          {:ok, map} | error
  def update_guardian_phone_template(
        %{} = params,
        %Config{} = config
      ) do
    Guardian.update_phone_template(params, config)
    |> to_response
  end

  @doc """
  Retrieve SMS configuration (one of auth0|twilio|phone-message-hook).

  ## see
  https://auth0.com/docs/api/management/v2/#!/Guardian/get_selected_provider_0

  """
  @deprecated "Use Auth0.Api.Management.get_guardian_sms_configuration/1 instead"
  @spec get_guardian_sms_configuration(config) ::
          {:ok, map} | error
  def get_guardian_sms_configuration(%Config{} = config) do
    Guardian.get_sms_configuration(config) |> to_response
  end

  @doc """
  Update SMS configuration (one of auth0|twilio|phone-message-hook).

  ## see
  https://auth0.com/docs/api/management/v2/#!/Guardian/put_selected_provider_0

  """
  @deprecated "Use Auth0.Api.Management.update_guardian_sms_configuration/2 instead"
  @spec update_guardian_sms_configuration(map, config) ::
          {:ok, map} | error
  def update_guardian_sms_configuration(
        %{} = params,
        %Config{} = config
      ) do
    Guardian.update_sms_configuration(params, config)
    |> to_response
  end

  @doc """
  Retrieve SMS Enrollment and Verification Templates.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Guardian/get_templates_0

  """
  @deprecated "Use Auth0.Api.Management.get_guardian_sms_template/1 instead"
  @spec get_guardian_sms_template(config) ::
          {:ok, map} | error
  def get_guardian_sms_template(%Config{} = config) do
    Guardian.get_sms_template(config) |> to_response
  end

  @doc """
  Update SMS Enrollment and Verification Templates.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Guardian/put_templates_0

  """
  @deprecated "Use Auth0.Api.Management.update_guardian_sms_template/2 instead"
  @spec update_guardian_sms_template(map, config) ::
          {:ok, map} | error
  def update_guardian_sms_template(
        %{} = params,
        %Config{} = config
      ) do
    Guardian.update_sms_template(params, config)
    |> to_response
  end

  @doc """
  Retrieve Twilio phone configuration.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Guardian/get_twilio

  """
  @deprecated "Use Auth0.Api.Management.get_guardian_twilio_phone_configuration/1 instead"
  @spec get_guardian_twilio_phone_configuration(config) ::
          {:ok, map} | error
  def get_guardian_twilio_phone_configuration(%Config{} = config) do
    Guardian.get_twilio_phone_configuration(config) |> to_response
  end

  @doc """
  Update Twilio phone configuration.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Guardian/put_twilio

  """
  @deprecated "Use Auth0.Api.Management.update_guardian_twilio_phone_configuration/2 instead"
  @spec update_guardian_twilio_phone_configuration(
          map,
          config
        ) ::
          {:ok, map} | error
  def update_guardian_twilio_phone_configuration(
        %{} = params,
        %Config{} = config
      ) do
    Guardian.update_twilio_phone_configuration(params, config)
    |> to_response
  end

  @doc """
  Retrieve Twilio SMS configuration.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Guardian/get_twilio_0

  """
  @deprecated "Use Auth0.Api.Management.get_guardian_twilio_sms_configuration/1 instead"
  @spec get_guardian_twilio_sms_configuration(config) ::
          {:ok, map} | error
  def get_guardian_twilio_sms_configuration(%Config{} = config) do
    Guardian.get_twilio_sms_configuration(config) |> to_response
  end

  @doc """
  Update Twilio SMS configuration.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Guardian/put_twilio_0

  """
  @deprecated "Use Auth0.Api.Management.update_guardian_twilio_sms_configuration/2 instead"
  @spec update_guardian_twilio_sms_configuration(
          map,
          config
        ) ::
          {:ok, map} | error
  def update_guardian_twilio_sms_configuration(
        %{} = params,
        %Config{} = config
      ) do
    Guardian.update_twilio_sms_configuration(params, config)
    |> to_response
  end

  @doc """
  Retrieve AWS SNS push notification configuration.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Guardian/get_sns

  """
  @deprecated "Use Auth0.Api.Management.get_guardian_aws_sns_configuration/1 instead"
  @spec get_guardian_aws_sns_configuration(config) ::
          {:ok, map} | error
  def get_guardian_aws_sns_configuration(%Config{} = config) do
    Guardian.get_aws_sns_configuration(config) |> to_response
  end

  @doc """
  Update SNS configuration for push notifications.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Guardian/patch_sns

  """
  @deprecated "Use Auth0.Api.Management.patch_guardian_aws_sns_configuration/2 instead"
  @spec patch_guardian_aws_sns_configuration(
          map,
          config
        ) ::
          {:ok, map} | error
  def patch_guardian_aws_sns_configuration(
        %{} = params,
        %Config{} = config
      ) do
    Guardian.patch_aws_sns_configuration(params, config)
    |> to_response
  end

  @doc """
  Update AWS SNS push notification configuration.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Guardian/put_sns

  """
  @deprecated "Use Auth0.Api.Management.update_guardian_aws_sns_configuration/2 instead"
  @spec update_guardian_aws_sns_configuration(
          map,
          config
        ) ::
          {:ok, map} | error
  def update_guardian_aws_sns_configuration(
        %{} = params,
        %Config{} = config
      ) do
    Guardian.update_aws_sns_configuration(params, config)
    |> to_response
  end

  @doc """
  Get a job.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Jobs/get_jobs_by_id

  """
  @deprecated "Use Auth0.Api.Management.get_job/2 instead"
  @spec get_job(id, config) :: {:ok, map} | error
  def get_job(id, %Config{} = config) do
    Jobs.get(id, config) |> to_response
  end

  @doc """
  Get job error details.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Jobs/get_errors

  """
  @deprecated "Use Auth0.Api.Management.get_job_error/2 instead"
  @spec get_job_error(id, config) ::
          {:ok, map} | error
  def get_job_error(id, %Config{} = config) do
    Jobs.get_error(id, config) |> to_response
  end

  @doc """
  Create export users job.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Jobs/post_users_exports

  """
  @deprecated "Use Auth0.Api.Management.create_job_users_exports/2 instead"
  @spec create_job_users_exports(map, config) ::
          {:ok, map} | error
  def create_job_users_exports(%{} = params, %Config{} = config) do
    Jobs.create_users_exports(params, config)
    |> to_response
  end

  @doc """
  Create import users job.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Jobs/post_users_imports

  """
  @deprecated "Use Auth0.Api.Management.create_job_users_imports/2 instead"
  @spec create_job_users_imports(map, config) ::
          {:ok, map} | error
  def create_job_users_imports(%{} = params, %Config{} = config) do
    Jobs.create_users_imports(params, config)
    |> to_response
  end

  @doc """
  Send an email address verification email.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Jobs/post_verification_email

  """
  @deprecated "Use Auth0.Api.Management.send_job_verification_email/2 instead"
  @spec send_job_verification_email(map, config) ::
          {:ok, map} | error
  def send_job_verification_email(%{} = params, %Config{} = config) do
    Jobs.send_verification_email(params, config)
    |> to_response
  end

  @doc """
  Get all Application Signing Keys.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Keys/get_signing_keys

  """
  @deprecated "Use Auth0.Api.Management.get_signing_keys/1 instead"
  @spec get_signing_keys(config) ::
          {:ok, map} | error
  def get_signing_keys(%Config{} = config) do
    Keys.list_signing(config) |> to_response
  end

  @doc """
  Get an Application Signing Key by its key id.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Keys/get_signing_key

  """
  @deprecated "Use Auth0.Api.Management.get_signing_key/2 instead"
  @spec get_signing_key(kid, config) ::
          {:ok, map} | error
  def get_signing_key(kid, %Config{} = config) do
    Keys.get_signing(kid, config) |> to_response
  end

  @doc """
  Rotate the Application Signing Key.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Keys/post_signing_keys

  """
  @deprecated "Use Auth0.Api.Management.rotate_signing_key/1 instead"
  @spec rotate_signing_key(config) ::
          {:ok, map} | error
  def rotate_signing_key(%Config{} = config) do
    Keys.rotate_signing(config) |> to_response
  end

  @doc """
  Revoke an Application Signing Key by its key id.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Keys/put_signing_keys

  """
  @deprecated "Use Auth0.Api.Management.revoke_signing_key/2 instead"
  @spec revoke_signing_key(kid, config) ::
          {:ok, map} | error
  def revoke_signing_key(kid, %Config{} = config) do
    Keys.revoke_signing(kid, config) |> to_response
  end

  @doc """
  Get active users count.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Stats/get_active_users

  """
  @deprecated "Use Auth0.Api.Management.get_active_users_count/1 instead"
  @spec get_active_users_count(config) :: {:ok, integer} | error
  def get_active_users_count(%Config{} = config) do
    Stats.count_active_users(config) |> to_response
  end

  @doc """
  Get daily stats.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Stats/get_daily

  """
  @deprecated "Use Auth0.Api.Management.get_daily_stats/1 instead"
  @spec get_daily_stats(config) :: {:ok, map} | error
  def get_daily_stats(%Config{} = config) do
    Stats.list_daily(config) |> to_response
  end

  @doc """
  Get tenant settings.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Tenants/tenant_settings_route

  """
  @deprecated "Use Auth0.Api.Management.get_tenant_setting/2 instead"
  @spec get_tenant_setting(map, config) ::
          {:ok, map} | error
  def get_tenant_setting(%{} = params, %Config{} = config) do
    Tenants.get_setting(params, config)
    |> to_response
  end

  @doc """
  Update tenant settings.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Tenants/patch_settings

  """
  @deprecated "Use Auth0.Api.Management.update_tenant_setting/2 instead"
  @spec update_tenant_setting(map, config) ::
          {:ok, map} | error
  def update_tenant_setting(%{} = params, %Config{} = config) do
    Tenants.update_setting(params, config)
    |> to_response
  end

  @doc """
  Check if an IP address is blocked.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Anomaly/get_ips_by_id

  """
  @deprecated "Use Auth0.Api.Management.check_ip_blocked/2 instead"
  @spec check_ip_blocked(ip, config) :: {:ok, boolean} | error
  def check_ip_blocked(ip, %Config{} = config) do
    Anomaly.check_ip_blocked(ip, config) |> to_response
  end

  @doc """
  Remove the blocked IP address.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Anomaly/delete_ips_by_id

  """
  @deprecated "Use Auth0.Api.Management.remove_blocked_ip/2 instead"
  @spec remove_blocked_ip(ip, config) :: {:ok, String.t()} | error
  def remove_blocked_ip(ip, %Config{} = config) do
    Anomaly.remove_blocked_ip(ip, config) |> to_response
  end

  @doc """
  Create an email verification ticket.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Tickets/post_email_verification

  """
  @deprecated "Use Auth0.Api.Management.create_email_verification_ticket/2 instead"
  @spec create_email_verification_ticket(map, config) ::
          {:ok, map} | error
  def create_email_verification_ticket(
        %{} = params,
        %Config{} = config
      ) do
    Tickets.create_email_verification(params, config)
    |> to_response
  end

  @doc """
  Create a password change ticket.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Tickets/post_password_change

  """
  @deprecated "Use Auth0.Api.Management.create_password_change_ticket/2 instead"
  @spec create_password_change_ticket(map, config) ::
          {:ok, map} | error
  def create_password_change_ticket(
        %{} = params,
        %Config{} = config
      ) do
    Tickets.create_password_change(params, config)
    |> to_response
  end

  @doc """
  Get breached password detection settings.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Attack_Protection/get_breached_password_detection

  """
  @deprecated "Use Auth0.Api.Management.get_attack_protection_breached_password_detection/1 instead"
  @spec get_attack_protection_breached_password_detection(config) ::
          {:ok, map} | error
  def get_attack_protection_breached_password_detection(%Config{} = config) do
    AttackProtection.get_breached_password_detection(config)
    |> to_response
  end

  @doc """
  Update breached password detection settings.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Attack_Protection/patch_breached_password_detection

  """
  @deprecated "Use Auth0.Api.Management.update_attack_protection_breached_password_detection/2 instead"
  @spec update_attack_protection_breached_password_detection(
          map,
          config
        ) ::
          {:ok, map} | error
  def update_attack_protection_breached_password_detection(
        %{} = params,
        %Config{} = config
      ) do
    AttackProtection.update_breached_password_detection(params, config)
    |> to_response
  end

  @doc """
  Get the brute force configuration.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Attack_Protection/get_brute_force_protection

  """
  @deprecated "Use Auth0.Api.Management.get_attack_protection_brute_force_protection/1 instead"
  @spec get_attack_protection_brute_force_protection(config) ::
          {:ok, map} | error
  def get_attack_protection_brute_force_protection(%Config{} = config) do
    AttackProtection.get_brute_force_protection(config)
    |> to_response
  end

  @doc """
  Update the brute force configuration.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Attack_Protection/patch_brute_force_protection

  """
  @deprecated "Use Auth0.Api.Management.update_attack_protection_brute_force_protection/2 instead"
  @spec update_attack_protection_brute_force_protection(
          map,
          config
        ) ::
          {:ok, map, response_body} | error
  def update_attack_protection_brute_force_protection(
        %{} = params,
        %Config{} = config
      ) do
    AttackProtection.update_brute_force_protection(params, config)
    |> to_response
  end

  @doc """
  Get the suspicious IP throttling configuration.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Attack_Protection/get_suspicious_ip_throttling

  """
  @deprecated "Use Auth0.Api.Management.get_attack_protection_suspicious_ip_throttling/1 instead"
  @spec get_attack_protection_suspicious_ip_throttling(config) ::
          {:ok, map} | error
  def get_attack_protection_suspicious_ip_throttling(%Config{} = config) do
    AttackProtection.get_suspicious_ip_throttling(config)
    |> to_response
  end

  @doc """
  Update the suspicious IP throttling configuration.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Attack_Protection/patch_suspicious_ip_throttling

  """
  @deprecated "Use Auth0.Api.Management.update_attack_protection_suspicious_ip_throttling/2 instead"
  @spec update_attack_protection_suspicious_ip_throttling(
          map,
          config
        ) ::
          {:ok, map} | error
  def update_attack_protection_suspicious_ip_throttling(
        %{} = params,
        %Config{} = config
      ) do
    AttackProtection.update_suspicious_ip_throttling(params, config)
    |> to_response
  end

  defp to_response({:ok, %{} = struct, response_body}) do
    try do
      {:ok, response_body |> Util.decode_json!()}
    rescue
      _ ->
        {:ok, struct |> Util.to_map()}
    end
  end

  defp to_response({:ok, other, _response_body}), do: {:ok, other}

  defp to_response({:error, _, _} = response), do: response

  defp to_response({:error, _} = response), do: response
end
