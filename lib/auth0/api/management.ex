defmodule Auth0.Api.Management do
  @moduledoc """
  Documentation for Auth0 Management API.

  """

  alias Auth0.Config
  alias Auth0.Common.Util
  alias Auth0.Management.Actions
  alias Auth0.Management.Anomaly
  alias Auth0.Management.AttackProtection
  alias Auth0.Management.Blacklist
  alias Auth0.Management.Branding
  alias Auth0.Management.ClientGrants
  alias Auth0.Management.Clients
  alias Auth0.Management.Connections
  alias Auth0.Management.CustomDomains
  alias Auth0.Management.DeviceCredentials
  alias Auth0.Management.EmailTemplates
  alias Auth0.Management.Emails
  alias Auth0.Management.Grants
  alias Auth0.Management.Guardian
  alias Auth0.Management.Hooks
  alias Auth0.Management.Jobs
  alias Auth0.Management.Keys
  alias Auth0.Management.LogStreams
  alias Auth0.Management.Logs
  alias Auth0.Management.Organizations
  alias Auth0.Management.Prompts
  alias Auth0.Management.ResourceServers
  alias Auth0.Management.Roles
  alias Auth0.Management.Rules
  alias Auth0.Management.RulesConfigs
  alias Auth0.Management.Stats
  alias Auth0.Management.Tenants
  alias Auth0.Management.Tickets
  alias Auth0.Management.UserBlocks
  alias Auth0.Management.Users
  alias Auth0.Management.UsersByEmail

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
  @type client_id :: String.t()
  @type credential_id :: String.t()
  @type response_body :: String.t()
  @type error :: {:error, integer, term} | {:error, term}

  @doc """
  Get actions.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Actions/get_actions

  """
  @spec get_actions(map, config) ::
          {:ok, map} | error
  def get_actions(%{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Actions.list(params, config)
    |> to_response
  end

  @doc """
  Create an action.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Actions/post_action

  """
  @spec create_action(map, config) ::
          {:ok, map} | error
  def create_action(%{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Actions.create(params, config)
    |> to_response
  end

  @doc """
  Get an action.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Actions/get_action

  """
  @spec get_action(id, config) ::
          {:ok, map} | error
  def get_action(id, %Config{} = config \\ %Config{}) do
    Actions.get(id, config) |> to_response
  end

  @doc """
  Delete an action.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Actions/delete_action

  """
  @spec delete_action(id, map, config) ::
          {:ok, String.t()} | error
  def delete_action(id, %{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Actions.delete(id, params, config)
    |> to_response
  end

  @doc """
  Update an action.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Actions/patch_action

  """
  @spec update_action(id, map, config) ::
          {:ok, map} | error
  def update_action(id, %{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Actions.update(id, params, config)
    |> to_response
  end

  @doc """
  Get an action's versions.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Actions/get_action_versions

  """
  @spec get_action_versions(action_id, map, config) ::
          {:ok, map} | error
  def get_action_versions(action_id, %{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Actions.list_versions(action_id, params, config)
    |> to_response
  end

  @doc """
  Get a specific version of an action.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Actions/get_action_version

  """
  @spec get_action_version(action_id, id, config) ::
          {:ok, map} | error
  def get_action_version(action_id, id, %Config{} = config \\ %Config{}) do
    Actions.get_version(action_id, id, config) |> to_response
  end

  @doc """
  Roll back to a previous action version.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Actions/post_deploy_draft_version

  """
  @spec rollback_action_version(action_id, id, map, config) ::
          {:ok, map} | error
  def rollback_action_version(
        action_id,
        id,
        %{} = params \\ %{},
        %Config{} = config \\ %Config{}
      ) do
    Actions.rollback_version(action_id, id, params, config)
    |> to_response
  end

  @doc """
  Test an Action.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Actions/post_test_action

  """
  @spec test_action(id, map, config) ::
          {:ok, map} | error
  def test_action(id, %{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Actions.test(id, params, config)
    |> to_response
  end

  @doc """
  Deploy an action.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Actions/post_deploy_action

  """
  @spec deploy_action(id, config) ::
          {:ok, map} | error
  def deploy_action(id, %Config{} = config \\ %Config{}) do
    Actions.deploy(id, config) |> to_response
  end

  @doc """
  Get triggers.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Actions/get_triggers

  """
  @spec get_action_triggers(config) ::
          {:ok, map} | error
  def get_action_triggers(%Config{} = config \\ %Config{}) do
    Actions.get_triggers(config) |> to_response
  end

  @doc """
  Get trigger bindings.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Actions/get_bindings

  """
  @spec get_action_trigger_bindings(trigger_id, map, config) ::
          {:ok, map} | error
  def get_action_trigger_bindings(
        trigger_id,
        %{} = params \\ %{},
        %Config{} = config \\ %Config{}
      ) do
    Actions.get_bindings(trigger_id, params, config)
    |> to_response
  end

  @doc """
  Update trigger bindings.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Actions/patch_bindings

  """
  @spec update_action_trigger_bindings(
          trigger_id,
          map,
          config
        ) ::
          {:ok, map} | error
  def update_action_trigger_bindings(
        trigger_id,
        %{} = params \\ %{},
        %Config{} = config \\ %Config{}
      ) do
    Actions.update_bindings(trigger_id, params, config)
    |> to_response
  end

  @doc """
  Get actions service status.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Actions/get_service_status

  """
  @spec get_action_status(config) ::
          {:ok, map} | error
  def get_action_status(%Config{} = config \\ %Config{}) do
    Actions.get_status(config) |> to_response
  end

  @doc """
  Get an execution.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Actions/get_execution

  """
  @spec get_action_execution(id, config) ::
          {:ok, map} | error
  def get_action_execution(id, %Config{} = config \\ %Config{}) do
    Actions.get_execution(id, config) |> to_response
  end

  @doc """
  Check if an IP address is blocked.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Anomaly/get_ips_by_id

  """
  @spec check_ip_blocked(ip, config) :: {:ok, boolean} | error
  def check_ip_blocked(ip, %Config{} = config \\ %Config{}) do
    Anomaly.check_ip_blocked(ip, config) |> to_response
  end

  @doc """
  Remove the blocked IP address.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Anomaly/delete_ips_by_id

  """
  @spec remove_blocked_ip(ip, config) :: {:ok, String.t()} | error
  def remove_blocked_ip(ip, %Config{} = config \\ %Config{}) do
    Anomaly.remove_blocked_ip(ip, config) |> to_response
  end

  @doc """
  Get breached password detection settings.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Attack_Protection/get_breached_password_detection

  """
  @spec get_attack_protection_breached_password_detection(config) ::
          {:ok, map} | error
  def get_attack_protection_breached_password_detection(%Config{} = config \\ %Config{}) do
    AttackProtection.get_breached_password_detection(config)
    |> to_response
  end

  @doc """
  Update breached password detection settings.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Attack_Protection/patch_breached_password_detection

  """
  @spec update_attack_protection_breached_password_detection(
          map,
          config
        ) ::
          {:ok, map} | error
  def update_attack_protection_breached_password_detection(
        %{} = params \\ %{},
        %Config{} = config \\ %Config{}
      ) do
    AttackProtection.update_breached_password_detection(params, config)
    |> to_response
  end

  @doc """
  Get the brute force configuration.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Attack_Protection/get_brute_force_protection

  """
  @spec get_attack_protection_brute_force_protection(config) ::
          {:ok, map} | error
  def get_attack_protection_brute_force_protection(%Config{} = config \\ %Config{}) do
    AttackProtection.get_brute_force_protection(config)
    |> to_response
  end

  @doc """
  Update the brute force configuration.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Attack_Protection/patch_brute_force_protection

  """
  @spec update_attack_protection_brute_force_protection(
          map,
          config
        ) ::
          {:ok, map, response_body} | error
  def update_attack_protection_brute_force_protection(
        %{} = params \\ %{},
        %Config{} = config \\ %Config{}
      ) do
    AttackProtection.update_brute_force_protection(params, config)
    |> to_response
  end

  @doc """
  Get the suspicious IP throttling configuration.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Attack_Protection/get_suspicious_ip_throttling

  """
  @spec get_attack_protection_suspicious_ip_throttling(config) ::
          {:ok, map} | error
  def get_attack_protection_suspicious_ip_throttling(%Config{} = config \\ %Config{}) do
    AttackProtection.get_suspicious_ip_throttling(config)
    |> to_response
  end

  @doc """
  Update the suspicious IP throttling configuration.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Attack_Protection/patch_suspicious_ip_throttling

  """
  @spec update_attack_protection_suspicious_ip_throttling(
          map,
          config
        ) ::
          {:ok, map} | error
  def update_attack_protection_suspicious_ip_throttling(
        %{} = params \\ %{},
        %Config{} = config \\ %Config{}
      ) do
    AttackProtection.update_suspicious_ip_throttling(params, config)
    |> to_response
  end

  @doc """
  Get blacklisted tokens.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Blacklists/get_tokens

  """
  @spec get_blacklisted_tokens(map, config) ::
          {:ok, map} | error
  def get_blacklisted_tokens(%{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Blacklist.list_tokens(params, config)
    |> to_response
  end

  @doc """
  Blacklist a token.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Blacklists/post_tokens

  """
  @spec blacklist_token(map, config) ::
          {:ok, String.t()} | error
  def blacklist_token(%{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Blacklist.add_token(params, config)
    |> to_response
  end

  @doc """
  Get branding settings.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Branding/get_branding

  """
  @spec get_branding(config) :: {:ok, map} | error
  def get_branding(%Config{} = config \\ %Config{}) do
    Branding.get(config) |> to_response
  end

  @doc """
  Update branding settings.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Branding/patch_branding

  """
  @spec update_branding(map, config) ::
          {:ok, map} | error
  def update_branding(%{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Branding.update(params, config)
    |> to_response
  end

  @doc """
  Get template for New Universal Login Experience.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Branding/get_universal_login

  """
  @spec get_template_for_universal_login(config) ::
          {:ok, map} | error
  def get_template_for_universal_login(%Config{} = config \\ %Config{}) do
    Branding.get_universal_login(config) |> to_response
  end

  @doc """
  Delete template for New Universal Login Experience.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Branding/delete_universal_login

  """
  @spec delete_template_for_universal_login(config) :: {:ok, String.t()} | error
  def delete_template_for_universal_login(%Config{} = config \\ %Config{}) do
    Branding.delete_universal_login(config) |> to_response
  end

  @doc """
  Set template for New Universal Login Experience.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Branding/put_universal_login

  """
  @spec set_template_for_universal_login(map, config) ::
          {:ok, String.t()} | error
  def set_template_for_universal_login(
        %{} = params \\ %{},
        %Config{} = config \\ %Config{}
      ) do
    Branding.set_universal_login(params, config)
    |> to_response
  end

  @doc """
  Retrieve default branding theme.

  ## see
  https://auth0.com/docs/api/management/v2#!/Branding/get_default_branding_theme

  """
  @spec get_default_branding_theme(config) ::
          {:ok, map} | error
  def get_default_branding_theme(%Config{} = config \\ %Config{}) do
    Branding.get_default_theme(config) |> to_response
  end

  @doc """
  Get branding theme.

  ## see
  https://auth0.com/docs/api/management/v2#!/Branding/get_branding_theme

  """
  @spec get_branding_theme(theme_id, config) ::
          {:ok, map} | error
  def get_branding_theme(theme_id, %Config{} = config \\ %Config{}) do
    Branding.get_theme(theme_id, config) |> to_response
  end

  @doc """
  Delete branding theme.

  ## see
  https://auth0.com/docs/api/management/v2#!/Branding/delete_branding_theme

  """
  @spec delete_branding_theme(theme_id, config) ::
          {:ok, String.t()} | error
  def delete_branding_theme(theme_id, %Config{} = config \\ %Config{}) do
    Branding.delete_theme(theme_id, config) |> to_response
  end

  @doc """
  Update branding theme.

  ## see
  https://auth0.com/docs/api/management/v2#!/Branding/patch_branding_theme

  """
  @spec update_branding_theme(theme_id, map, config) ::
          {:ok, map} | error
  def update_branding_theme(theme_id, %{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Branding.update_theme(theme_id, params, config) |> to_response
  end

  @doc """
  Create branding theme.

  ## see
  https://auth0.com/docs/api/management/v2#!/Branding/post_branding_theme

  """
  @spec create_branding_theme(map, config) ::
          {:ok, map} | error
  def create_branding_theme(%{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Branding.create_theme(params, config) |> to_response
  end

  @doc """
  Get client grants.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Client_Grants/get_client_grants

  """
  @spec get_client_grants(map, config) ::
          {:ok, map} | error
  def get_client_grants(%{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    ClientGrants.list(params, config)
    |> to_response
  end

  @doc """
  Create client grant.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Client_Grants/post_client_grants

  """
  @spec create_client_grant(map, config) ::
          {:ok, map} | error
  def create_client_grant(%{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    ClientGrants.create(params, config)
    |> to_response
  end

  @doc """
  Delete client grant.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Client_Grants/delete_client_grants_by_id

  """
  @spec delete_client_grant(id, config) :: {:ok, String.t()} | error
  def delete_client_grant(id, %Config{} = config \\ %Config{}) do
    ClientGrants.delete(id, config) |> to_response
  end

  @doc """
  Update client grant.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Client_Grants/patch_client_grants_by_id

  """
  @spec update_client_grant(id, map, config) ::
          {:ok, map} | error
  def update_client_grant(id, %{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    ClientGrants.update(id, params, config)
    |> to_response
  end

  @doc """
  Get clients.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Clients/get_clients

  """
  @spec get_clients(map, config) ::
          {:ok, map} | error
  def get_clients(%{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Clients.list(params, config)
    |> to_response
  end

  @doc """
  Create a client.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Clients/post_clients

  """
  @spec create_client(map, config) ::
          {:ok, map} | error
  def create_client(%{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Clients.create(params, config)
    |> to_response
  end

  @doc """
  Get a client.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Clients/get_clients_by_id

  """
  @spec get_client(id, map, config) ::
          {:ok, map} | error
  def get_client(id, %{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Clients.get(id, params, config)
    |> to_response
  end

  @doc """
  Delete a client.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Clients/delete_clients_by_id

  """
  @spec delete_client(id, config) :: {:ok, String.t()} | error
  def delete_client(id, %Config{} = config \\ %Config{}) do
    Clients.delete(id, config) |> to_response
  end

  @doc """
  Update a client.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Clients/patch_clients_by_id

  """
  @spec update_client(id, map, config) ::
          {:ok, map} | error
  def update_client(id, %{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Clients.update(id, params, config)
    |> to_response
  end

  @doc """
  Rotate a client secret.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Clients/post_rotate_secret

  """
  @spec rotate_client_secret(id, config) ::
          {:ok, map} | error
  def rotate_client_secret(id, %Config{} = config \\ %Config{}) do
    Clients.rotate_secret(id, config) |> to_response
  end

  @doc """
  Get client credentials.

  ## see
  https://auth0.com/docs/api/management/v2/clients/get-credentials

  """
  @spec list_credentials(client_id, config) ::
          {:ok, list(map())} | error
  def list_credentials(client_id, %Config{} = config \\ %Config{}) do
    Clients.list_credentials(client_id, config) |> to_response
  end

  @doc """
  Create a client credential.

  ## see
  https://auth0.com/docs/api/management/v2/clients/post-credentials

  """
  @spec create_credential(client_id, map, config) ::
          {:ok, map} | error
  def create_credential(client_id, %{} = params, %Config{} = config \\ %Config{}) do
    Clients.create_credential(client_id, params, config) |> to_response
  end

  @doc """
  Get client credential.

  ## see
  https://auth0.com/docs/api/management/v2/clients/get-credentials-by-credential-id

  """
  @spec get_credential(client_id, credential_id, config) ::
          {:ok, map} | error
  def get_credential(client_id, credential_id, %Config{} = config \\ %Config{}) do
    Clients.get_credential(client_id, credential_id, config) |> to_response
  end

  @doc """
  Delete a client credential.

  ## see
  https://auth0.com/docs/api/management/v2/clients/delete-credentials-by-credential-id

  """
  @spec delete_credential(client_id, credential_id, config) ::
          {:ok, String.t()} | error
  def delete_credential(client_id, credential_id, %Config{} = config \\ %Config{}) do
    Clients.delete_credential(client_id, credential_id, config) |> to_response
  end

  @doc """
  Update a client credential.

  ## see
  https://auth0.com/docs/api/management/v2/clients/patch-credentials-by-credential-id

  """
  @spec update_credential(client_id, credential_id, map, config) ::
          {:ok, map} | error
  def update_credential(client_id, credential_id, %{} = params, %Config{} = config \\ %Config{}) do
    Clients.update_credential(client_id, credential_id, params, config) |> to_response
  end

  @doc """
  Get all connections.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Connections/get_connections

  """
  @spec get_connections(map, config) ::
          {:ok, map} | error
  def get_connections(%{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Connections.list(params, config)
    |> to_response
  end

  @doc """
  Create a connection.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Connections/post_connections

  """
  @spec create_connection(map, config) ::
          {:ok, map} | error
  def create_connection(%{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Connections.create(params, config)
    |> to_response
  end

  @doc """
  Get a connection.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Connections/get_connections_by_id

  """
  @spec get_connection(id, map, config) ::
          {:ok, map} | error
  def get_connection(id, %{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Connections.get(id, params, config)
    |> to_response
  end

  @doc """
  Delete a connection.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Connections/delete_connections_by_id

  """
  @spec delete_connection(id, config) :: {:ok, String.t()} | error
  def delete_connection(id, %Config{} = config \\ %Config{}) do
    Connections.delete(id, config) |> to_response
  end

  @doc """
  Update a connection.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Connections/patch_connections_by_id

  """
  @spec update_connection(id, map, config) ::
          {:ok, map} | error
  def update_connection(id, %{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Connections.update(id, params, config)
    |> to_response
  end

  @doc """
  Check connection status.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Connections/get_status

  """
  @spec get_connection_status(id, config) :: {:ok, boolean} | error
  def get_connection_status(id, %Config{} = config \\ %Config{}) do
    Connections.get_status(id, config) |> to_response
  end

  @doc """
  Delete a connection user.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Connections/delete_users_by_email

  """
  @spec delete_connection_users(id, map, config) ::
          {:ok, String.t()} | error
  def delete_connection_users(id, %{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Connections.delete_users(id, params, config)
    |> to_response
  end

  @doc """
  Get custom domains configurations.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Custom_Domains/get_custom_domains

  """
  @spec get_custom_domain_configurations(config) ::
          {:ok, map} | error
  def get_custom_domain_configurations(%Config{} = config \\ %Config{}) do
    CustomDomains.list(config) |> to_response
  end

  @doc """
  Configure a new custom domain.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Custom_Domains/post_custom_domains

  """
  @spec configure_custom_domain(map, config) ::
          {:ok, map} | error
  def configure_custom_domain(%{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    CustomDomains.configure(params, config)
    |> to_response
  end

  @doc """
  Get custom domain configuration.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Custom_Domains/get_custom_domains_by_id

  """
  @spec get_custom_domain_configuration(id, config) ::
          {:ok, map} | error
  def get_custom_domain_configuration(id, %Config{} = config \\ %Config{}) do
    CustomDomains.get(id, config) |> to_response
  end

  @doc """
  Delete custom domain configuration.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Custom_Domains/delete_custom_domains_by_id

  """
  @spec delete_custom_domain_configuration(id, config) :: {:ok, String.t()} | error
  def delete_custom_domain_configuration(id, %Config{} = config \\ %Config{}) do
    CustomDomains.delete(id, config) |> to_response
  end

  @doc """
  Update custom domain configuration.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Custom_Domains/patch_custom_domains_by_id

  """
  @spec update_custom_domain_configuration(id, map, config) ::
          {:ok, map} | error
  def update_custom_domain_configuration(
        id,
        %{} = params \\ %{},
        %Config{} = config \\ %Config{}
      ) do
    CustomDomains.update(id, params, config)
    |> to_response
  end

  @doc """
  Verify a custom domain.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Custom_Domains/post_verify

  """
  @spec verify_custom_domain(id, config) ::
          {:ok, map} | error
  def verify_custom_domain(id, %Config{} = config \\ %Config{}) do
    CustomDomains.verify(id, config) |> to_response
  end

  @doc """
  Retrieve device credentials.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Device_Credentials/get_device_credentials

  """
  @spec get_device_credentials(map, config) ::
          {:ok, map} | error
  def get_device_credentials(%{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    DeviceCredentials.list(params, config)
    |> to_response
  end

  @doc """
  Create a device public key credential.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Device_Credentials/post_device_credentials

  """
  @spec create_device_credential(map, config) ::
          {:ok, map} | error
  def create_device_credential(%{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    DeviceCredentials.create(params, config)
    |> to_response
  end

  @doc """
  Delete a device credential.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Device_Credentials/delete_device_credentials_by_id

  """
  @spec delete_device_credential(id, config) :: {:ok, String.t()} | error
  def delete_device_credential(id, %Config{} = config \\ %Config{}) do
    DeviceCredentials.delete(id, config) |> to_response
  end

  @doc """
  Get an email template.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Email_Templates/get_email_templates_by_templateName

  """
  @spec get_email_template(template_name, config) ::
          {:ok, map} | error
  def get_email_template(template_name, %Config{} = config \\ %Config{}) do
    EmailTemplates.get(template_name, config) |> to_response
  end

  @doc """
  Patch an email template.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Email_Templates/patch_email_templates_by_templateName

  """
  @spec patch_email_template(template_name, map, config) ::
          {:ok, map} | error
  def patch_email_template(
        template_name,
        %{} = params \\ %{},
        %Config{} = config \\ %Config{}
      ) do
    EmailTemplates.patch(template_name, params, config)
    |> to_response
  end

  @doc """
  Update an email template.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Email_Templates/put_email_templates_by_templateName

  """
  @spec update_email_template(template_name, map, config) ::
          {:ok, map} | error
  def update_email_template(
        template_name,
        %{} = params \\ %{},
        %Config{} = config \\ %Config{}
      ) do
    EmailTemplates.update(template_name, params, config)
    |> to_response
  end

  @doc """
  Create an email template.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Email_Templates/post_email_templates

  """
  @spec create_email_template(map, config) ::
          {:ok, map} | error
  def create_email_template(%{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    EmailTemplates.create(params, config)
    |> to_response
  end

  @doc """
  Get the email provider.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Emails/get_provider

  """
  @spec get_email_provider(map, config) ::
          {:ok, map} | error
  def get_email_provider(%{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Emails.get_provider(params, config)
    |> to_response
  end

  @doc """
  Delete the email provider.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Emails/delete_provider

  """
  @spec delete_email_provider(config) :: {:ok, String.t()} | error
  def delete_email_provider(%Config{} = config \\ %Config{}) do
    Emails.delete_provider(config) |> to_response
  end

  @doc """
  Update the email provider.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Emails/patch_provider

  """
  @spec update_email_provider(map, config) ::
          {:ok, map} | error
  def update_email_provider(%{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Emails.update_provider(params, config)
    |> to_response
  end

  @doc """
  Configure the email provider.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Emails/post_provider

  """
  @spec configure_email_provider(map, config) ::
          {:ok, map} | error
  def configure_email_provider(%{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Emails.configure_provider(params, config)
    |> to_response
  end

  @doc """
  Get grants.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Grants/get_grants

  """
  @spec get_grants(map, config) ::
          {:ok, map} | error
  def get_grants(%{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Grants.list(params, config)
    |> to_response
  end

  @doc """
  Delete a grant.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Grants/delete_grants_by_id

  """
  @spec delete_grant(id, config) :: {:ok, String.t()} | error
  def delete_grant(id, %Config{} = config \\ %Config{}) do
    Grants.delete(id, config) |> to_response
  end

  @doc """
  Delete a grant by user_id.

  ## see
  https://auth0.com/docs/api/management/v2/grants/delete-grants-by-user-id

  """
  @spec delete_grant_by_user_id(map, config) :: {:ok, String.t()} | error
  def delete_grant_by_user_id(%{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Grants.delete_by_user_id(params, config) |> to_response
  end

  @doc """
  Retrieve Factors and their Status.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Guardian/get_factors

  """
  @spec get_guardian_factors(config) ::
          {:ok, map} | error
  def get_guardian_factors(%Config{} = config \\ %Config{}) do
    Guardian.list_factors(config) |> to_response
  end

  @doc """
  Update a Multi-factor Authentication Factor.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Guardian/put_factors_by_name

  """
  @spec update_guardian_factor(name, map, config) ::
          {:ok, map} | error
  def update_guardian_factor(name, %{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Guardian.update_factor(name, params, config)
    |> to_response
  end

  @doc """
  Get the Multi-factor Authentication policies.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Guardian/get_policies

  """
  @spec list_guardian_policies(config) :: {:ok, list(map)} | error
  def list_guardian_policies(%Config{} = config \\ %Config{}) do
    Guardian.list_policies(config) |> to_response
  end

  @doc """
  Set the Multi-factor Authentication policies.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Guardian/put_policies

  """
  @spec set_guardian_policies(map, config) :: {:ok, list(map)} | error
  def set_guardian_policies(%{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Guardian.set_policies(params, config)
    |> to_response
  end

  @doc """
  Retrieve a multi-factor authentication enrollment.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Guardian/get_enrollments_by_id

  """
  @spec get_guardian_enrollment(id, config) ::
          {:ok, map} | error
  def get_guardian_enrollment(id, %Config{} = config \\ %Config{}) do
    Guardian.get_enrollment(id, config) |> to_response
  end

  @doc """
  Delete a multi-factor authentication enrollment.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Guardian/delete_enrollments_by_id

  """
  @spec delete_guardian_enrollment(id, config) :: {:ok, String.t()} | error
  def delete_guardian_enrollment(id, %Config{} = config \\ %Config{}) do
    Guardian.delete_enrollment(id, config) |> to_response
  end

  @doc """
  Create a multi-factor authentication enrollment ticket.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Guardian/post_ticket

  """
  @spec create_guardian_enrollment_ticket(map, config) ::
          {:ok, map} | error
  def create_guardian_enrollment_ticket(
        %{} = params \\ %{},
        %Config{} = config \\ %Config{}
      ) do
    Guardian.create_enrollment_ticket(params, config)
    |> to_response
  end

  @doc """
  Retrieve the Enabled Phone Factors.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Guardian/get_message_types

  """
  @spec get_guardian_phone_factor(config) ::
          {:ok, map} | error
  def get_guardian_phone_factor(%Config{} = config \\ %Config{}) do
    Guardian.get_phone_factor(config) |> to_response
  end

  @doc """
  Update the Enabled Phone Factors.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Guardian/put_message_types

  """
  @spec update_guardian_phone_factor(map, config) ::
          {:ok, map} | error
  def update_guardian_phone_factor(
        %{} = params \\ %{},
        %Config{} = config \\ %Config{}
      ) do
    Guardian.update_phone_factor(params, config)
    |> to_response
  end

  @doc """
  Retrieve phone configuration (one of auth0|twilio|phone-message-hook).

  ## see
  https://auth0.com/docs/api/management/v2/#!/Guardian/get_selected_provider

  """
  @spec get_guardian_phone_configuration(config) ::
          {:ok, map} | error
  def get_guardian_phone_configuration(%Config{} = config \\ %Config{}) do
    Guardian.get_phone_configuration(config) |> to_response
  end

  @doc """
  Update phone configuration (one of auth0|twilio|phone-message-hook).

  ## see
  https://auth0.com/docs/api/management/v2/#!/Guardian/put_selected_provider

  """
  @spec update_guardian_phone_configuration(map, config) ::
          {:ok, map} | error
  def update_guardian_phone_configuration(
        %{} = params \\ %{},
        %Config{} = config \\ %Config{}
      ) do
    Guardian.update_phone_configuration(params, config)
    |> to_response
  end

  @doc """
  Retrieve Enrollment and Verification Phone Templates.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Guardian/get_templates

  """
  @spec get_guardian_phone_template(config) ::
          {:ok, map} | error
  def get_guardian_phone_template(%Config{} = config \\ %Config{}) do
    Guardian.get_phone_template(config) |> to_response
  end

  @doc """
  Update Enrollment and Verification Phone Templates.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Guardian/put_templates

  """
  @spec update_guardian_phone_template(map, config) ::
          {:ok, map} | error
  def update_guardian_phone_template(
        %{} = params \\ %{},
        %Config{} = config \\ %Config{}
      ) do
    Guardian.update_phone_template(params, config)
    |> to_response
  end

  @doc """
  Retrieve SMS configuration (one of auth0|twilio|phone-message-hook).

  ## see
  https://auth0.com/docs/api/management/v2/#!/Guardian/get_selected_provider_0

  """
  @spec get_guardian_sms_configuration(config) ::
          {:ok, map} | error
  def get_guardian_sms_configuration(%Config{} = config \\ %Config{}) do
    Guardian.get_sms_configuration(config) |> to_response
  end

  @doc """
  Update SMS configuration (one of auth0|twilio|phone-message-hook).

  ## see
  https://auth0.com/docs/api/management/v2/#!/Guardian/put_selected_provider_0

  """
  @spec update_guardian_sms_configuration(map, config) ::
          {:ok, map} | error
  def update_guardian_sms_configuration(
        %{} = params \\ %{},
        %Config{} = config \\ %Config{}
      ) do
    Guardian.update_sms_configuration(params, config)
    |> to_response
  end

  @doc """
  Retrieve SMS Enrollment and Verification Templates.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Guardian/get_templates_0

  """
  @spec get_guardian_sms_template(config) ::
          {:ok, map} | error
  def get_guardian_sms_template(%Config{} = config \\ %Config{}) do
    Guardian.get_sms_template(config) |> to_response
  end

  @doc """
  Update SMS Enrollment and Verification Templates.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Guardian/put_templates_0

  """
  @spec update_guardian_sms_template(map, config) ::
          {:ok, map} | error
  def update_guardian_sms_template(
        %{} = params \\ %{},
        %Config{} = config \\ %Config{}
      ) do
    Guardian.update_sms_template(params, config)
    |> to_response
  end

  @doc """
  Retrieve Twilio phone configuration.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Guardian/get_twilio

  """
  @spec get_guardian_twilio_phone_configuration(config) ::
          {:ok, map} | error
  def get_guardian_twilio_phone_configuration(%Config{} = config \\ %Config{}) do
    Guardian.get_twilio_phone_configuration(config) |> to_response
  end

  @doc """
  Update Twilio phone configuration.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Guardian/put_twilio

  """
  @spec update_guardian_twilio_phone_configuration(
          map,
          config
        ) ::
          {:ok, map} | error
  def update_guardian_twilio_phone_configuration(
        %{} = params \\ %{},
        %Config{} = config \\ %Config{}
      ) do
    Guardian.update_twilio_phone_configuration(params, config)
    |> to_response
  end

  @doc """
  Retrieve Twilio SMS configuration.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Guardian/get_twilio_0

  """
  @spec get_guardian_twilio_sms_configuration(config) ::
          {:ok, map} | error
  def get_guardian_twilio_sms_configuration(%Config{} = config \\ %Config{}) do
    Guardian.get_twilio_sms_configuration(config) |> to_response
  end

  @doc """
  Update Twilio SMS configuration.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Guardian/put_twilio_0

  """
  @spec update_guardian_twilio_sms_configuration(
          map,
          config
        ) ::
          {:ok, map} | error
  def update_guardian_twilio_sms_configuration(
        %{} = params \\ %{},
        %Config{} = config \\ %Config{}
      ) do
    Guardian.update_twilio_sms_configuration(params, config)
    |> to_response
  end

  @doc """
  Retrieve AWS SNS push notification configuration.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Guardian/get_sns

  """
  @spec get_guardian_aws_sns_configuration(config) ::
          {:ok, map} | error
  def get_guardian_aws_sns_configuration(%Config{} = config \\ %Config{}) do
    Guardian.get_aws_sns_configuration(config) |> to_response
  end

  @doc """
  Update SNS configuration for push notifications.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Guardian/patch_sns

  """
  @spec patch_guardian_aws_sns_configuration(
          map,
          config
        ) ::
          {:ok, map} | error
  def patch_guardian_aws_sns_configuration(
        %{} = params \\ %{},
        %Config{} = config \\ %Config{}
      ) do
    Guardian.patch_aws_sns_configuration(params, config)
    |> to_response
  end

  @doc """
  Update AWS SNS push notification configuration.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Guardian/put_sns

  """
  @spec update_guardian_aws_sns_configuration(
          map,
          config
        ) ::
          {:ok, map} | error
  def update_guardian_aws_sns_configuration(
        %{} = params \\ %{},
        %Config{} = config \\ %Config{}
      ) do
    Guardian.update_aws_sns_configuration(params, config)
    |> to_response
  end

  @doc """
  Get hooks.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Hooks/get_hooks

  """
  @spec get_hooks(map, config) ::
          {:ok, map} | error
  def get_hooks(%{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Hooks.list(params, config)
    |> to_response
  end

  @doc """
  Create a hook.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Hooks/post_hooks

  """
  @spec create_hook(map, config) ::
          {:ok, map} | error
  def create_hook(%{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Hooks.create(params, config)
    |> to_response
  end

  @doc """
  Get a hook.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Hooks/get_hooks_by_id

  """
  @spec get_hook(id, map, config) ::
          {:ok, map} | error
  def get_hook(id, %{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Hooks.get(id, params, config)
    |> to_response
  end

  @doc """
  Delete a hook.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Hooks/delete_hooks_by_id

  """
  @spec delete_hook(id, config) :: {:ok, String.t(), response_body} | error
  def delete_hook(id, %Config{} = config \\ %Config{}) do
    Hooks.delete(id, config) |> to_response
  end

  @doc """
  Update a hook.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Hooks/patch_hooks_by_id

  """
  @spec update_hook(id, map, config) ::
          {:ok, map} | error
  def update_hook(id, %{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Hooks.update(id, params, config)
    |> to_response
  end

  @doc """
  Get hook secrets.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Hooks/get_secrets

  """
  @spec get_hook_secrets(id, config) ::
          {:ok, map} | error
  def get_hook_secrets(id, %Config{} = config \\ %Config{}) do
    Hooks.get_secrets(id, config) |> to_response
  end

  @doc """
  Delete hook secrets.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Hooks/delete_secrets

  """
  @spec delete_hook_secrets(id, map, config) ::
          {:ok, String.t()} | error
  def delete_hook_secrets(id, %{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Hooks.delete_secrets(id, params, config)
    |> to_response
  end

  @doc """
  Update hook secrets.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Hooks/patch_hooks_by_id

  """
  @spec update_hook_secrets(id, map, config) ::
          {:ok, map} | error
  def update_hook_secrets(id, %{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Hooks.update_secrets(id, params, config)
    |> to_response
  end

  @doc """
  Add hook secrets.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Hooks/post_secrets

  """
  @spec add_hook_secrets(id, map, config) ::
          {:ok, map} | error
  def add_hook_secrets(id, %{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Hooks.add_secrets(id, params, config)
    |> to_response
  end

  @doc """
  Get a job.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Jobs/get_jobs_by_id

  """
  @spec get_job(id, config) :: {:ok, map} | error
  def get_job(id, %Config{} = config \\ %Config{}) do
    Jobs.get(id, config) |> to_response
  end

  @doc """
  Get job error details.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Jobs/get_errors

  """
  @spec get_job_error(id, config) ::
          {:ok, map} | error
  def get_job_error(id, %Config{} = config \\ %Config{}) do
    Jobs.get_error(id, config) |> to_response
  end

  @doc """
  Create export users job.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Jobs/post_users_exports

  """
  @spec create_job_users_exports(map, config) ::
          {:ok, map} | error
  def create_job_users_exports(%{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Jobs.create_users_exports(params, config)
    |> to_response
  end

  @doc """
  Create import users job.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Jobs/post_users_imports

  """
  @spec create_job_users_imports(map, config) ::
          {:ok, map} | error
  def create_job_users_imports(%{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Jobs.create_users_imports(params, config)
    |> to_response
  end

  @doc """
  Send an email address verification email.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Jobs/post_verification_email

  """
  @spec send_job_verification_email(map, config) ::
          {:ok, map} | error
  def send_job_verification_email(%{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Jobs.send_verification_email(params, config)
    |> to_response
  end

  @doc """
  Get all Application Signing Keys.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Keys/get_signing_keys

  """
  @spec get_signing_keys(config) ::
          {:ok, map} | error
  def get_signing_keys(%Config{} = config \\ %Config{}) do
    Keys.list_signing(config) |> to_response
  end

  @doc """
  Get an Application Signing Key by its key id.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Keys/get_signing_key

  """
  @spec get_signing_key(kid, config) ::
          {:ok, map} | error
  def get_signing_key(kid, %Config{} = config \\ %Config{}) do
    Keys.get_signing(kid, config) |> to_response
  end

  @doc """
  Rotate the Application Signing Key.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Keys/post_signing_keys

  """
  @spec rotate_signing_key(config) ::
          {:ok, map} | error
  def rotate_signing_key(%Config{} = config \\ %Config{}) do
    Keys.rotate_signing(config) |> to_response
  end

  @doc """
  Revoke an Application Signing Key by its key id.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Keys/put_signing_keys

  """
  @spec revoke_signing_key(kid, config) ::
          {:ok, map} | error
  def revoke_signing_key(kid, %Config{} = config \\ %Config{}) do
    Keys.revoke_signing(kid, config) |> to_response
  end

  @doc """
  Get log streams.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Log_Streams/get_log_streams

  """
  @spec get_log_streams(config) :: {:ok, map} | error
  def get_log_streams(%Config{} = config \\ %Config{}) do
    LogStreams.list(config) |> to_response
  end

  @doc """
  Create a log stream.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Log_Streams/post_log_streams

  """
  @spec create_log_stream(map, config) ::
          {:ok, map} | error
  def create_log_stream(%{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    LogStreams.create(params, config)
    |> to_response
  end

  @doc """
  Get log stream by ID.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Log_Streams/get_log_streams_by_id

  """
  @spec get_log_stream(id, config) ::
          {:ok, map} | error
  def get_log_stream(id, %Config{} = config \\ %Config{}) do
    LogStreams.get(id, config) |> to_response
  end

  @doc """
  Delete log stream.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Log_Streams/delete_log_streams_by_id

  """
  @spec delete_log_stream(id, config) :: {:ok, String.t()} | error
  def delete_log_stream(id, %Config{} = config \\ %Config{}) do
    LogStreams.delete(id, config) |> to_response
  end

  @doc """
  Update a log stream.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Log_Streams/patch_log_streams_by_id

  """
  @spec update_log_stream(id, map, config) ::
          {:ok, map} | error
  def update_log_stream(id, %{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    LogStreams.update(id, params, config)
    |> to_response
  end

  @doc """
  Search log events.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Logs/get_logs

  """
  @spec get_log_events(map, config) ::
          {:ok, map} | error
  def get_log_events(%{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Logs.list(params, config)
    |> to_response
  end

  @doc """
  Get a log event by id.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Logs/get_logs_by_id

  """
  @spec get_log_event(id, config) :: {:ok, map} | error
  def get_log_event(id, %Config{} = config \\ %Config{}) do
    Logs.get(id, config) |> to_response
  end

  @doc """
  Get organizations.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Organizations/get_organizations

  """
  @spec get_organizations(map, config) ::
          {:ok, map} | error
  def get_organizations(%{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Organizations.list(params, config)
    |> to_response
  end

  @doc """
  Create an Organization.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Organizations/post_organizations

  """
  @spec create_organization(map, config) ::
          {:ok, map} | error
  def create_organization(%{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Organizations.create(params, config)
    |> to_response
  end

  @doc """
  Get organization.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Organizations/get_organizations_by_id

  """
  @spec get_organization(id, config) ::
          {:ok, map} | error
  def get_organization(id, %Config{} = config \\ %Config{}) do
    Organizations.get(id, config) |> to_response
  end

  @doc """
  Delete organization.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Organizations/delete_organizations_by_id

  """
  @spec delete_organization(id, config) :: {:ok, String.t()} | error
  def delete_organization(id, %Config{} = config \\ %Config{}) do
    Organizations.delete(id, config) |> to_response
  end

  @doc """
  Modify an Organization.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Organizations/patch_organizations_by_id

  """
  @spec modify_organization(id, map, config) ::
          {:ok, map} | error
  def modify_organization(id, %{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Organizations.modify(id, params, config)
    |> to_response
  end

  @doc """
  Get organization by name.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Organizations/get_name_by_name

  """
  @spec get_organization_by_name(name, config) ::
          {:ok, map} | error
  def get_organization_by_name(name, %Config{} = config \\ %Config{}) do
    Organizations.get_by_name(name, config) |> to_response
  end

  @doc """
  Get connections enabled for an organization.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Organizations/get_enabled_connections

  """
  @spec get_organization_connections(id, map, config) ::
          {:ok, map} | error
  def get_organization_connections(
        id,
        %{} = params \\ %{},
        %Config{} = config \\ %Config{}
      ) do
    Organizations.list_connections(id, params, config)
    |> to_response
  end

  @doc """
  Add connections to an organization.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Organizations/post_enabled_connections

  """
  @spec add_organization_connection(
          id,
          map,
          config
        ) ::
          {:ok, map} | error
  def add_organization_connection(
        id,
        %{} = params \\ %{},
        %Config{} = config \\ %Config{}
      ) do
    Organizations.add_connection(id, params, config)
    |> to_response
  end

  @doc """
  Get an enabled connection for an organization.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Organizations/get_enabled_connections_by_connectionId

  """
  @spec get_organization_connection(id, connection_id, config) ::
          {:ok, map} | error
  def get_organization_connection(id, connection_id, %Config{} = config \\ %Config{}) do
    Organizations.get_connection(id, connection_id, config) |> to_response
  end

  @doc """
  Delete connections from an organization.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Organizations/delete_enabled_connections_by_connectionId

  """
  @spec delete_organization_connection(id, connection_id, config) ::
          {:ok, String.t()} | error
  def delete_organization_connection(id, connection_id, %Config{} = config \\ %Config{}) do
    Organizations.delete_connection(id, connection_id, config) |> to_response
  end

  @doc """
  Modify an Organizations Connection.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Organizations/patch_enabled_connections_by_connectionId

  """
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
        %{} = params \\ %{},
        %Config{} = config \\ %Config{}
      ) do
    Organizations.modify_connection(id, connection_id, params, config)
    |> to_response
  end

  @doc """
  Get invitations to organization.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Organizations/get_invitations

  """
  @spec get_organization_invitations(id, map, config) ::
          {:ok, map} | error
  def get_organization_invitations(
        id,
        %{} = params \\ %{},
        %Config{} = config \\ %Config{}
      ) do
    Organizations.list_invitations(id, params, config)
    |> to_response
  end

  @doc """
  Create invitations to organization.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Organizations/post_invitations

  """
  @spec create_organization_invitation(id, map, config) ::
          {:ok, map} | error
  def create_organization_invitation(
        id,
        %{} = params \\ %{},
        %Config{} = config \\ %Config{}
      ) do
    Organizations.create_invitation(id, params, config)
    |> to_response
  end

  @doc """
  Get an invitation to organization.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Organizations/get_invitations_by_invitation_id

  """
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
        %{} = params \\ %{},
        %Config{} = config \\ %Config{}
      ) do
    Organizations.get_invitation(id, invitation_id, params, config)
    |> to_response
  end

  @doc """
  Delete an invitation to organization.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Organizations/delete_invitations_by_invitation_id

  """
  @spec delete_organization_invitation(id, invitation_id, config) ::
          {:ok, String.t()} | error
  def delete_organization_invitation(id, invitation_id, %Config{} = config \\ %Config{}) do
    Organizations.delete_invitation(id, invitation_id, config) |> to_response
  end

  @doc """
  Get members who belong to an organization.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Organizations/get_members

  """
  @spec get_organization_members(id, map, config) ::
          {:ok, map} | error
  def get_organization_members(
        id,
        %{} = params \\ %{},
        %Config{} = config \\ %Config{}
      ) do
    Organizations.list_members(id, params, config)
    |> to_response
  end

  @doc """
  Delete members from an organization.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Organizations/delete_members

  """
  @spec delete_organization_members(id, map, config) ::
          {:ok, String.t()} | error
  def delete_organization_members(
        id,
        %{} = params \\ %{},
        %Config{} = config \\ %Config{}
      ) do
    Organizations.delete_members(id, params, config)
    |> to_response
  end

  @doc """
  Add members to an organization.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Organizations/post_members

  """
  @spec add_organization_members(id, map, config) ::
          {:ok, String.t()} | error
  def add_organization_members(
        id,
        %{} = params \\ %{},
        %Config{} = config \\ %Config{}
      ) do
    Organizations.add_members(id, params, config)
    |> to_response
  end

  @doc """
  Get the roles assigned to an organization member.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Organizations/get_organization_member_roles

  """
  @spec get_organization_roles(id, user_id, map, config) ::
          {:ok, map} | error
  def get_organization_roles(
        id,
        user_id,
        %{} = params \\ %{},
        %Config{} = config \\ %Config{}
      ) do
    Organizations.list_roles(id, user_id, params, config)
    |> to_response
  end

  @doc """
  Delete members from an organization.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Organizations/delete_members

  """
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
        %{} = params \\ %{},
        %Config{} = config \\ %Config{}
      ) do
    Organizations.delete_roles(id, user_id, params, config)
    |> to_response
  end

  @doc """
  Add members to an organization.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Organizations/post_members

  """
  @spec assign_organization_roles(id, user_id, map, config) ::
          {:ok, String.t()} | error
  def assign_organization_roles(
        id,
        user_id,
        %{} = params \\ %{},
        %Config{} = config \\ %Config{}
      ) do
    Organizations.assign_roles(id, user_id, params, config)
    |> to_response
  end

  @doc """
  Get prompts settings.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Prompts/get_prompts

  """
  @spec get_prompt_setting(config) :: {:ok, map} | error
  def get_prompt_setting(%Config{} = config \\ %Config{}) do
    Prompts.get(config) |> to_response
  end

  @doc """
  Update prompts settings.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Prompts/patch_prompts

  """
  @spec update_prompt_setting(map, config) ::
          {:ok, map} | error
  def update_prompt_setting(%{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Prompts.update(params, config)
    |> to_response
  end

  @doc """
  Get custom text for a prompt.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Prompts/get_custom_text_by_language

  """
  @spec get_prompt_custom_text(prompt, language, config) ::
          {:ok, map} | error
  def get_prompt_custom_text(prompt, language, %Config{} = config \\ %Config{}) do
    Prompts.get_custom_text(prompt, language, config) |> to_response
  end

  @doc """
  Set custom text for a specific prompt.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Prompts/put_custom_text_by_language

  """
  @spec set_prompt_custom_text(prompt, language, map, config) ::
          {:ok, map} | error
  def set_prompt_custom_text(
        prompt,
        language,
        %{} = params \\ %{},
        %Config{} = config \\ %Config{}
      ) do
    Prompts.set_custom_text(prompt, language, params, config)
    |> to_response
  end

  @doc """
  Get resource servers.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Resource_Servers/get_resource_servers

  """
  @spec get_resource_servers(map, config) ::
          {:ok, map} | error
  def get_resource_servers(%{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    ResourceServers.list(params, config)
    |> to_response
  end

  @doc """
  Create a resource server.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Resource_Servers/post_resource_servers

  """
  @spec create_resource_server(map, config) ::
          {:ok, map} | error
  def create_resource_server(%{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    ResourceServers.create(params, config)
    |> to_response
  end

  @doc """
  Get a resource server.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Resource_Servers/get_resource_servers_by_id

  """
  @spec get_resource_server(id, map, config) ::
          {:ok, map} | error
  def get_resource_server(id, %{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    ResourceServers.get(id, params, config)
    |> to_response
  end

  @doc """
  Delete a resource server.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Resource_Servers/delete_resource_servers_by_id

  """
  @spec delete_resource_server(id, config) :: {:ok, String.t()} | error
  def delete_resource_server(id, %Config{} = config \\ %Config{}) do
    ResourceServers.delete(id, config) |> to_response
  end

  @doc """
  Update a resource server.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Resource_Servers/get_resource_servers_by_id

  """
  @spec update_resource_server(id, map, config) ::
          {:ok, map} | error
  def update_resource_server(id, %{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    ResourceServers.update(id, params, config)
    |> to_response
  end

  @doc """
  Get roles.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Roles/get_roles

  """
  @spec get_roles(map, config) ::
          {:ok, map} | error
  def get_roles(%{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Roles.list(params, config)
    |> to_response
  end

  @doc """
  Create a role.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Roles/post_roles

  """
  @spec create_role(map, config) ::
          {:ok, map} | error
  def create_role(%{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Roles.create(params, config)
    |> to_response
  end

  @doc """
  Get a role.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Roles/get_roles_by_id

  """
  @spec get_role(id, config) :: {:ok, map} | error
  def get_role(id, %Config{} = config \\ %Config{}) do
    Roles.get(id, config) |> to_response
  end

  @doc """
  Delete a role.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Roles/delete_roles_by_id

  """
  @spec delete_role(id, config) :: {:ok, String.t()} | error
  def delete_role(id, %Config{} = config \\ %Config{}) do
    Roles.delete(id, config) |> to_response
  end

  @doc """
  Update a role.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Roles/patch_roles_by_id

  """
  @spec update_role(id, map, config) ::
          {:ok, map} | error
  def update_role(id, %{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Roles.update(id, params, config)
    |> to_response
  end

  @doc """
  Get permissions granted by role.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Roles/get_role_permission

  """
  @spec get_role_permissions(id, map, config) ::
          {:ok, map} | error
  def get_role_permissions(id, %{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Roles.list_permissions(id, params, config)
    |> to_response
  end

  @doc """
  Remove permissions from a role.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Roles/delete_role_permission_assignment

  """
  @spec remove_role_permissions(id, map, config) ::
          {:ok, String.t()} | error
  def remove_role_permissions(id, %{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Roles.remove_permissions(id, params, config)
    |> to_response
  end

  @doc """
  Associate permissions with a role.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Roles/post_role_permission_assignment

  """
  @spec associate_role_permissions(id, map, config) ::
          {:ok, String.t()} | error
  def associate_role_permissions(
        id,
        %{} = params \\ %{},
        %Config{} = config \\ %Config{}
      ) do
    Roles.associate_permissions(id, params, config)
    |> to_response
  end

  @doc """
  Get a role's users.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Roles/get_role_user

  """
  @spec get_role_users(id, map, config) ::
          {:ok, map} | error
  def get_role_users(id, %{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Roles.list_users(id, params, config)
    |> to_response
  end

  @doc """
  Assign users to a role.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Roles/post_role_users

  """
  @spec assign_role_users(id, map, config) ::
          {:ok, String.t()} | error
  def assign_role_users(id, %{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Roles.assign_users(id, params, config)
    |> to_response
  end

  @doc """
  Get rules.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Rules/get_rules

  """
  @spec get_rules(map, config) ::
          {:ok, map} | error
  def get_rules(%{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Rules.list(params, config)
    |> to_response
  end

  @doc """
  Create a rule.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Rules/post_rules

  """
  @spec create_rule(map, config) ::
          {:ok, map} | error
  def create_rule(%{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Rules.create(params, config)
    |> to_response
  end

  @doc """
  Get a rule.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Rules/get_rules_by_id

  """
  @spec get_rule(id, map, config) ::
          {:ok, map} | error
  def get_rule(id, %{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Rules.get(id, params, config)
    |> to_response
  end

  @doc """
  Delete a rule.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Rules/delete_rules_by_id

  """
  @spec delete_rule(id, config) :: {:ok, String.t()} | error
  def delete_rule(id, %Config{} = config \\ %Config{}) do
    Rules.delete(id, config) |> to_response
  end

  @doc """
  Update a rule.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Rules/patch_rules_by_id

  """
  @spec update_rule(id, map, config) ::
          {:ok, map} | error
  def update_rule(id, %{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Rules.update(id, params, config)
    |> to_response
  end

  @doc """
  Retrieve config variable keys for rules (get_rules-configs).

  ## see
  https://auth0.com/docs/api/management/v2/#!/Rules_Configs/get_rules_configs

  """
  @spec get_rules_configs(config) ::
          {:ok, map} | error
  def get_rules_configs(%Config{} = config \\ %Config{}) do
    RulesConfigs.list(config) |> to_response
  end

  @doc """
  Delete rules config for a given key.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Rules_Configs/delete_rules_configs_by_key

  """
  @spec delete_rules_config(key, config) :: {:ok, String.t()} | error
  def delete_rules_config(key, %Config{} = config \\ %Config{}) do
    RulesConfigs.delete(key, config) |> to_response
  end

  @doc """
  Set rules config for a given key.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Rules_Configs/put_rules_configs_by_key

  """
  @spec set_rules_config(key, map, config) ::
          {:ok, map} | error
  def set_rules_config(key, %{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    RulesConfigs.set(key, params, config)
    |> to_response
  end

  @doc """
  Get active users count.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Stats/get_active_users

  """
  @spec get_active_users_count(config) :: {:ok, integer} | error
  def get_active_users_count(%Config{} = config \\ %Config{}) do
    Stats.count_active_users(config) |> to_response
  end

  @doc """
  Get daily stats.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Stats/get_daily

  """
  @spec get_daily_stats(config) :: {:ok, map} | error
  def get_daily_stats(%Config{} = config \\ %Config{}) do
    Stats.list_daily(config) |> to_response
  end

  @doc """
  Get tenant settings.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Tenants/tenant_settings_route

  """
  @spec get_tenant_setting(map, config) ::
          {:ok, map} | error
  def get_tenant_setting(%{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Tenants.get_setting(params, config)
    |> to_response
  end

  @doc """
  Update tenant settings.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Tenants/patch_settings

  """
  @spec update_tenant_setting(map, config) ::
          {:ok, map} | error
  def update_tenant_setting(%{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Tenants.update_setting(params, config)
    |> to_response
  end

  @doc """
  Create an email verification ticket.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Tickets/post_email_verification

  """
  @spec create_email_verification_ticket(map, config) ::
          {:ok, map} | error
  def create_email_verification_ticket(
        %{} = params \\ %{},
        %Config{} = config \\ %Config{}
      ) do
    Tickets.create_email_verification(params, config)
    |> to_response
  end

  @doc """
  Create a password change ticket.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Tickets/post_password_change

  """
  @spec create_password_change_ticket(map, config) ::
          {:ok, map} | error
  def create_password_change_ticket(
        %{} = params \\ %{},
        %Config{} = config \\ %Config{}
      ) do
    Tickets.create_password_change(params, config)
    |> to_response
  end

  @doc """
  Get blocks by identifier.

  ## see
  https://auth0.com/docs/api/management/v2/#!/User_Blocks/get_user_blocks

  """
  @spec get_user_block(map, config) ::
          {:ok, map} | error
  def get_user_block(%{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    UserBlocks.get(params, config)
    |> to_response
  end

  @doc """
  Unblock by identifier.

  ## see
  https://auth0.com/docs/api/management/v2/#!/User_Blocks/delete_user_blocks

  """
  @spec unblock_user_block(map, config) ::
          {:ok, String.t()} | error
  def unblock_user_block(%{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    UserBlocks.unblock(params, config)
    |> to_response
  end

  @doc """
  Get a user's blocks.

  ## see
  https://auth0.com/docs/api/management/v2/#!/User_Blocks/get_user_blocks_by_id

  """
  @spec get_user_block_by_user_id(id, map, config) ::
          {:ok, map} | error
  def get_user_block_by_user_id(id, %{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    UserBlocks.get_by_user_id(id, params, config)
    |> to_response
  end

  @doc """
  Unblock a user.

  ## see
  https://auth0.com/docs/api/management/v2/#!/User_Blocks/delete_user_blocks_by_id

  """
  @spec unblock_user_block_by_user_id(id, config) :: {:ok, String.t()} | error
  def unblock_user_block_by_user_id(id, %Config{} = config \\ %Config{}) do
    UserBlocks.unblock_by_user_id(id, config) |> to_response
  end

  @doc """
  List or Search Users.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Users/get_users

  """
  @spec get_users(map, config) ::
          {:ok, map} | error
  def get_users(%{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Users.list(params, config)
    |> to_response
  end

  @doc """
  Create a User.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Users/post_users

  """
  @spec create_user(map, config) ::
          {:ok, map} | error
  def create_user(%{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Users.create(params, config)
    |> to_response
  end

  @doc """
  Get a User.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Users/get_users_by_id

  """
  @spec get_user(id, map, config) ::
          {:ok, map} | error
  def get_user(id, %{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Users.get(id, params, config)
    |> to_response
  end

  @doc """
  Delete a User.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Users/delete_users_by_id

  """
  @spec delete_user(id, config) :: {:ok, String.t()} | error
  def delete_user(id, %Config{} = config \\ %Config{}) do
    Users.delete(id, config) |> to_response
  end

  @doc """
  Update a User.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Users/patch_users_by_id

  """
  @spec update_user(id, map, config) ::
          {:ok, map} | error
  def update_user(id, %{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Users.update(id, params, config)
    |> to_response
  end

  @doc """
  Get the First Confirmed Multi-factor Authentication Enrollment.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Users/get_enrollments

  """
  @spec get_user_enrollments(id, config) ::
          {:ok, map} | error
  def get_user_enrollments(id, %Config{} = config \\ %Config{}) do
    Users.get_enrollments(id, config) |> to_response
  end

  @doc """
  Get a user's roles.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Users/get_user_roles

  """
  @spec get_user_roles(id, map, config) ::
          {:ok, map} | error
  def get_user_roles(id, %{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Users.get_roles(id, params, config)
    |> to_response
  end

  @doc """
  Removes roles from a user.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Users/delete_user_roles

  """
  @spec remove_user_roles(id, map, config) ::
          {:ok, String.t()} | error
  def remove_user_roles(id, %{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Users.remove_roles(id, params, config)
    |> to_response
  end

  @doc """
  Assign roles to a user.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Users/post_user_roles

  """
  @spec assign_user_roles(id, map, config) ::
          {:ok, String.t()} | error
  def assign_user_roles(id, %{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Users.assign_roles(id, params, config)
    |> to_response
  end

  @doc """
  Get user's log events.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Users/get_logs_by_user

  """
  @spec get_user_logs(id, map, config) ::
          {:ok, map} | error
  def get_user_logs(id, %{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Users.get_logs(id, params, config)
    |> to_response
  end

  @doc """
  List user's organizations.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Users/get_user_organizations

  """
  @spec get_user_organizations(id, map, config) ::
          {:ok, map} | error
  def get_user_organizations(id, %{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Users.get_organizations(id, params, config)
    |> to_response
  end

  @doc """
  Get a User's Permissions.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Users/get_permissions

  """
  @spec get_user_permissions(id, map, config) ::
          {:ok, map} | error
  def get_user_permissions(id, %{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Users.get_permissions(id, params, config)
    |> to_response
  end

  @doc """
  Remove Permissions from a User.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Users/delete_permissions

  """
  @spec remove_user_permissions(id, map, config) ::
          {:ok, String.t()} | error
  def remove_user_permissions(id, %{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Users.remove_permissions(id, params, config)
    |> to_response
  end

  @doc """
  Assign Permissions to a User.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Users/post_permissions

  """
  @spec assign_user_permissions(id, map, config) ::
          {:ok, String.t()} | error
  def assign_user_permissions(id, %{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Users.assign_permissions(id, params, config)
    |> to_response
  end

  @doc """
  Delete a User's Multi-factor Provider.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Users/delete_multifactor_by_provider

  """
  @spec delete_user_multifactor(id, map, config) ::
          {:ok, String.t()} | error
  def delete_user_multifactor(
        id,
        %{} = params \\ %{},
        %Config{} = config \\ %Config{}
      ) do
    Users.delete_multifactor(id, params, config)
    |> to_response
  end

  @doc """
  Invalidate All Remembered Browsers for Multi-factor Authentication.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Users/post_invalidate_remember_browser

  """
  @spec invalidate_user_remembered_browser_for_multifactor(id, config) ::
          {:ok, String.t()} | error
  def invalidate_user_remembered_browser_for_multifactor(
        id,
        %Config{} = config \\ %Config{}
      ) do
    Users.invalidate_remembered_browser_for_multifactor(id, config) |> to_response
  end

  @doc """
  Link a User Account.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Users/post_identities

  """
  @spec link_user_identities(id, map, config) ::
          {:ok, map} | error
  def link_user_identities(
        id,
        %{} = params \\ %{},
        %Config{} = config \\ %Config{}
      ) do
    Users.link_identities(id, params, config)
    |> to_response
  end

  @doc """
  Unlink a User Identity.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Users/delete_user_identity_by_user_id

  """
  @spec unlink_user_identities(id, provider, user_id, config) ::
          {:ok, map} | error
  def unlink_user_identities(
        id,
        provider,
        user_id,
        %Config{} = config \\ %Config{}
      ) do
    Users.unlink_identities(id, provider, user_id, config)
    |> to_response
  end

  @doc """
  Generate New Multi-factor Authentication Recovery Code.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Users/post_recovery_code_regeneration

  """
  @spec regenerate_user_recovery_code(id, config) ::
          {:ok, map} | error
  def regenerate_user_recovery_code(
        id,
        %Config{} = config \\ %Config{}
      ) do
    Users.regenerate_recovery_code(id, config) |> to_response
  end

  @doc """
  Search Users by Email.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Users_By_Email/get_users_by_email

  """
  @spec get_users_by_email(map, config) ::
          {:ok, map} | error
  def get_users_by_email(%{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    UsersByEmail.list(params, config)
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
