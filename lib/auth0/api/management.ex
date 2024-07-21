defmodule Auth0.Api.Management do
  @moduledoc """
  Documentation for Auth0 Management API.

  """

  alias Auth0.Config
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
  alias Auth0.Management.RefreshTokens
  alias Auth0.Management.ResourceServers
  alias Auth0.Management.Roles
  alias Auth0.Management.Rules
  alias Auth0.Management.RulesConfigs
  alias Auth0.Management.Sessions
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
  @type error :: {:error, integer, term} | {:error, term}

  @doc """
  Retrieve all actions.

  ## see
  https://auth0.com/docs/api/management/v2/actions/get-actions

  """
  @spec get_actions(map, config) ::
          {:ok, map} | error
  def get_actions(%{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Actions.list(params, config)
  end

  @doc """
  Create an action. Once an action is created, it must be deployed, and then bound to a trigger before it will be executed as part of a flow.

  ## see
  https://auth0.com/docs/api/management/v2/actions/post-action

  """
  @spec create_action(map, config) ::
          {:ok, map} | error
  def create_action(%{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Actions.create(params, config)
  end

  @doc """
  Retrieve an action by its ID.

  ## see
  https://auth0.com/docs/api/management/v2/actions/get-action

  """
  @spec get_action(id, config) ::
          {:ok, map} | error
  def get_action(id, %Config{} = config \\ %Config{}) do
    Actions.get(id, config)
  end

  @doc """
  Deletes an action and all of its associated versions. An action must be unbound from all triggers before it can be deleted.

  ## see
  https://auth0.com/docs/api/management/v2/actions/delete-action

  """
  @spec delete_action(id, map, config) ::
          {:ok, String.t()} | error
  def delete_action(id, %{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Actions.delete(id, params, config)
  end

  @doc """
  Update an existing action. If this action is currently bound to a trigger, updating it will not affect any user flows until the action is deployed.

  ## see
  https://auth0.com/docs/api/management/v2/actions/patch-action

  """
  @spec update_action(id, map, config) ::
          {:ok, map} | error
  def update_action(id, %{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Actions.update(id, params, config)
  end

  @doc """
  Retrieve all of an action's versions. An action version is created whenever an action is deployed. An action version is immutable, once created.

  ## see
  https://auth0.com/docs/api/management/v2/actions/get-action-versions

  """
  @spec get_action_versions(action_id, map, config) ::
          {:ok, map} | error
  def get_action_versions(action_id, %{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Actions.list_versions(action_id, params, config)
  end

  @doc """
  Retrieve a specific version of an action. An action version is created whenever an action is deployed. An action version is immutable, once created.

  ## see
  https://auth0.com/docs/api/management/v2/actions/get-action-version

  """
  @spec get_action_version(action_id, id, config) ::
          {:ok, map} | error
  def get_action_version(action_id, id, %Config{} = config \\ %Config{}) do
    Actions.get_version(action_id, id, config)
  end

  @doc """
  Performs the equivalent of a roll-back of an action to an earlier, specified version. Creates a new, deployed action version that is identical to the specified version. If this action is currently bound to a trigger, the system will begin executing the newly-created version immediately.

  ## see
  https://auth0.com/docs/api/management/v2/actions/post-deploy-draft-version

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
  end

  @doc """
  Test an action. After updating an action, it can be tested prior to being deployed to ensure it behaves as expected.

  ## see
  https://auth0.com/docs/api/management/v2/actions/post-test-action

  """
  @spec test_action(id, map, config) ::
          {:ok, map} | error
  def test_action(id, %{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Actions.test(id, params, config)
  end

  @doc """
  Deploy an action. Deploying an action will create a new immutable version of the action. If the action is currently bound to a trigger, then the system will begin executing the newly deployed version of the action immediately. Otherwise, the action will only be executed as a part of a flow once it is bound to that flow.

  ## see
  https://auth0.com/docs/api/management/v2/actions/post-deploy-action

  """
  @spec deploy_action(id, config) ::
          {:ok, map} | error
  def deploy_action(id, %Config{} = config \\ %Config{}) do
    Actions.deploy(id, config)
  end

  @doc """
  Retrieve the set of triggers currently available within actions. A trigger is an extensibility point to which actions can be bound.

  ## see
  https://auth0.com/docs/api/management/v2/actions/get-triggers

  """
  @spec get_action_triggers(config) ::
          {:ok, map} | error
  def get_action_triggers(%Config{} = config \\ %Config{}) do
    Actions.get_triggers(config)
  end

  @doc """
  Retrieve the actions that are bound to a trigger. Once an action is created and deployed, it must be attached (i.e. bound) to a trigger so that it will be executed as part of a flow. The list of actions returned reflects the order in which they will be executed during the appropriate flow.

  ## see
  https://auth0.com/docs/api/management/v2/actions/get-bindings

  """
  @spec get_action_trigger_bindings(trigger_id, map, config) ::
          {:ok, map} | error
  def get_action_trigger_bindings(
        trigger_id,
        %{} = params \\ %{},
        %Config{} = config \\ %Config{}
      ) do
    Actions.get_bindings(trigger_id, params, config)
  end

  @doc """
  Update the actions that are bound (i.e. attached) to a trigger. Once an action is created and deployed, it must be attached (i.e. bound) to a trigger so that it will be executed as part of a flow. The order in which the actions are provided will determine the order in which they are executed.

  ## see
  https://auth0.com/docs/api/management/v2/actions/patch-bindings

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
  end

  @doc """
  Retrieve information about a specific execution of a trigger. Relevant execution IDs will be included in tenant logs generated as part of that authentication flow. Executions will only be stored for 10 days after their creation.

  ## see
  https://auth0.com/docs/api/management/v2/actions/get-execution

  """
  @spec get_action_execution(id, config) ::
          {:ok, map} | error
  def get_action_execution(id, %Config{} = config \\ %Config{}) do
    Actions.get_execution(id, config)
  end

  @doc """
  Check if the given IP address is blocked via the Suspicious IP Throttling due to multiple suspicious attempts.

  ## see
  https://auth0.com/docs/api/management/v2/anomaly/get-ips-by-id

  """
  @spec check_ip_blocked(ip, config) :: {:ok, boolean} | error
  def check_ip_blocked(ip, %Config{} = config \\ %Config{}) do
    Anomaly.check_ip_blocked(ip, config)
  end

  @doc """
  Remove a block imposed by Suspicious IP Throttling for the given IP address.

  ## see
  https://auth0.com/docs/api/management/v2/anomaly/delete-ips-by-id

  """
  @spec remove_blocked_ip(ip, config) :: {:ok, String.t()} | error
  def remove_blocked_ip(ip, %Config{} = config \\ %Config{}) do
    Anomaly.remove_blocked_ip(ip, config)
  end

  @doc """
  Retrieve details of the Breached Password Detection configuration of your tenant.

  ## see
  https://auth0.com/docs/api/management/v2/attack-protection/get-breached-password-detection

  """
  @spec get_attack_protection_breached_password_detection(config) ::
          {:ok, map} | error
  def get_attack_protection_breached_password_detection(%Config{} = config \\ %Config{}) do
    AttackProtection.get_breached_password_detection(config)
  end

  @doc """
  Update details of the Breached Password Detection configuration of your tenant.

  ## see
  https://auth0.com/docs/api/management/v2/attack-protection/patch-breached-password-detection

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
  end

  @doc """
  Retrieve details of the Brute-force Protection configuration of your tenant.

  ## see
  https://auth0.com/docs/api/management/v2/attack-protection/get-brute-force-protection

  """
  @spec get_attack_protection_brute_force_protection(config) ::
          {:ok, map} | error
  def get_attack_protection_brute_force_protection(%Config{} = config \\ %Config{}) do
    AttackProtection.get_brute_force_protection(config)
  end

  @doc """
  Update the Brute-force Protection configuration of your tenant.

  ## see
  https://auth0.com/docs/api/management/v2/attack-protection/patch-brute-force-protection

  """
  @spec update_attack_protection_brute_force_protection(
          map,
          config
        ) ::
          {:ok, map} | error
  def update_attack_protection_brute_force_protection(
        %{} = params \\ %{},
        %Config{} = config \\ %Config{}
      ) do
    AttackProtection.update_brute_force_protection(params, config)
  end

  @doc """
  Retrieve details of the Suspicious IP Throttling configuration of your tenant.

  ## see
  https://auth0.com/docs/api/management/v2/attack-protection/get-suspicious-ip-throttling

  """
  @spec get_attack_protection_suspicious_ip_throttling(config) ::
          {:ok, map} | error
  def get_attack_protection_suspicious_ip_throttling(%Config{} = config \\ %Config{}) do
    AttackProtection.get_suspicious_ip_throttling(config)
  end

  @doc """
  Update the details of the Suspicious IP Throttling configuration of your tenant.

  ## see
  https://auth0.com/docs/api/management/v2/attack-protection/patch-suspicious-ip-throttling

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
  end

  @doc """
  Retrieve the jti and aud of all tokens that are blacklisted.

  ## see
  https://auth0.com/docs/api/management/v2/blacklists/get-tokens

  """
  @spec get_blacklisted_tokens(map, config) ::
          {:ok, map} | error
  def get_blacklisted_tokens(%{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Blacklist.list_tokens(params, config)
  end

  @doc """
  Add the token identified by the jti to a blacklist for the tenant.

  ## see
  https://auth0.com/docs/api/management/v2/blacklists/post-tokens

  """
  @spec blacklist_token(map, config) ::
          {:ok, String.t()} | error
  def blacklist_token(%{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Blacklist.add_token(params, config)
  end

  @doc """
  Retrieve branding settings.

  ## see
  https://auth0.com/docs/api/management/v2/branding/get-branding

  """
  @spec get_branding(config) :: {:ok, map} | error
  def get_branding(%Config{} = config \\ %Config{}) do
    Branding.get(config)
  end

  @doc """
  Update branding settings.

  ## see
  https://auth0.com/docs/api/management/v2/branding/patch-branding

  """
  @spec update_branding(map, config) ::
          {:ok, map} | error
  def update_branding(%{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Branding.update(params, config)
  end

  @doc """
  Get template for New Universal Login Experience

  ## see
  https://auth0.com/docs/api/management/v2/branding/get-universal-login

  """
  @spec get_template_for_universal_login(config) ::
          {:ok, map} | error
  def get_template_for_universal_login(%Config{} = config \\ %Config{}) do
    Branding.get_universal_login(config)
  end

  @doc """
  Delete template for New Universal Login Experience

  ## see
  https://auth0.com/docs/api/management/v2/branding/delete-universal-login

  """
  @spec delete_template_for_universal_login(config) :: {:ok, String.t()} | error
  def delete_template_for_universal_login(%Config{} = config \\ %Config{}) do
    Branding.delete_universal_login(config)
  end

  @doc """
  Update the Universal Login branding template.

  ## see
  https://auth0.com/docs/api/management/v2/branding/put-universal-login

  """
  @spec set_template_for_universal_login(map, config) ::
          {:ok, String.t()} | error
  def set_template_for_universal_login(
        %{} = params \\ %{},
        %Config{} = config \\ %Config{}
      ) do
    Branding.set_universal_login(params, config)
  end

  @doc """
  Retrieve default branding theme.

  ## see
  https://auth0.com/docs/api/management/v2/branding/get-default-branding-theme

  """
  @spec get_default_branding_theme(config) ::
          {:ok, map} | error
  def get_default_branding_theme(%Config{} = config \\ %Config{}) do
    Branding.get_default_theme(config)
  end

  @doc """
  Retrieve branding theme.

  ## see
  https://auth0.com/docs/api/management/v2/branding/get-branding-theme

  """
  @spec get_branding_theme(theme_id, config) ::
          {:ok, map} | error
  def get_branding_theme(theme_id, %Config{} = config \\ %Config{}) do
    Branding.get_theme(theme_id, config)
  end

  @doc """
  Delete branding theme.

  ## see
  https://auth0.com/docs/api/management/v2/branding/delete-branding-theme

  """
  @spec delete_branding_theme(theme_id, config) ::
          {:ok, String.t()} | error
  def delete_branding_theme(theme_id, %Config{} = config \\ %Config{}) do
    Branding.delete_theme(theme_id, config)
  end

  @doc """
  Update branding theme.

  ## see
  https://auth0.com/docs/api/management/v2/branding/patch-branding-theme

  """
  @spec update_branding_theme(theme_id, map, config) ::
          {:ok, map} | error
  def update_branding_theme(theme_id, %{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Branding.update_theme(theme_id, params, config)
  end

  @doc """
  Create branding theme.

  ## see
  https://auth0.com/docs/api/management/v2/branding/post-branding-theme

  """
  @spec create_branding_theme(map, config) ::
          {:ok, map} | error
  def create_branding_theme(%{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Branding.create_theme(params, config)
  end

  @doc """
  Retrieve a list of client grants, including the scopes associated with the application/API pair.

  ## see
  https://auth0.com/docs/api/management/v2/client-grants/get-client-grants

  """
  @spec get_client_grants(map, config) ::
          {:ok, map} | error
  def get_client_grants(%{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    ClientGrants.list(params, config)
  end

  @doc """
  Create a client grant for a machine-to-machine login flow.

  ## see
  https://auth0.com/docs/api/management/v2/client-grants/post-client-grants

  """
  @spec create_client_grant(map, config) ::
          {:ok, map} | error
  def create_client_grant(%{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    ClientGrants.create(params, config)
  end

  @doc """
  Delete the Client Credential Flow from your machine-to-machine application.

  ## see
  https://auth0.com/docs/api/management/v2/client-grants/delete-client-grants-by-id

  """
  @spec delete_client_grant(id, config) :: {:ok, String.t()} | error
  def delete_client_grant(id, %Config{} = config \\ %Config{}) do
    ClientGrants.delete(id, config)
  end

  @doc """
  Update a client grant.

  ## see
  https://auth0.com/docs/api/management/v2/client-grants/patch-client-grants-by-id

  """
  @spec update_client_grant(id, map, config) ::
          {:ok, map} | error
  def update_client_grant(id, %{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    ClientGrants.update(id, params, config)
  end

  @doc """
  Retrieve clients (applications and SSO integrations) matching provided filters. A list of fields to include or exclude may also be specified.

  ## see
  https://auth0.com/docs/api/management/v2/clients/get-clients

  """
  @spec get_clients(map, config) ::
          {:ok, map} | error
  def get_clients(%{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Clients.list(params, config)
  end

  @doc """
  Create a new client (application or SSO integration).

  ## see
  https://auth0.com/docs/api/management/v2/clients/post-clients

  """
  @spec create_client(map, config) ::
          {:ok, map} | error
  def create_client(%{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Clients.create(params, config)
  end

  @doc """
  Retrieve client details by ID. Clients are SSO connections or Applications linked with your Auth0 tenant. A list of fields to include or exclude may also be specified.

  ## see
  https://auth0.com/docs/api/management/v2/clients/get-clients-by-id

  """
  @spec get_client(id, map, config) ::
          {:ok, map} | error
  def get_client(id, %{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Clients.get(id, params, config)
  end

  @doc """
  Delete a client and related configuration (rules, connections, etc).

  ## see
  https://auth0.com/docs/api/management/v2/clients/delete-clients-by-id

  """
  @spec delete_client(id, config) :: {:ok, String.t()} | error
  def delete_client(id, %Config{} = config \\ %Config{}) do
    Clients.delete(id, config)
  end

  @doc """
  Updates a client's settings

  ## see
  https://auth0.com/docs/api/management/v2/clients/patch-clients-by-id

  """
  @spec update_client(id, map, config) ::
          {:ok, map} | error
  def update_client(id, %{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Clients.update(id, params, config)
  end

  @doc """
  Rotate a client secret.

  ## see
  https://auth0.com/docs/api/management/v2/clients/post-rotate-secret

  """
  @spec rotate_client_secret(id, config) ::
          {:ok, map} | error
  def rotate_client_secret(id, %Config{} = config \\ %Config{}) do
    Clients.rotate_secret(id, config)
  end

  @doc """
  Get the details of a client credential.

  ## see
  https://auth0.com/docs/api/management/v2/clients/get-credentials

  """
  @spec list_credentials(client_id, config) ::
          {:ok, list(map())} | error
  def list_credentials(client_id, %Config{} = config \\ %Config{}) do
    Clients.list_credentials(client_id, config)
  end

  @doc """
  Create a client credential associated to your application. The credential will be created but not yet enabled for use with Private Key JWT authentication method. To enable the credential, set the client_authentication_methods property on the client.

  ## see
  https://auth0.com/docs/api/management/v2/clients/post-credentials

  """
  @spec create_credential(client_id, map, config) ::
          {:ok, map} | error
  def create_credential(client_id, %{} = params, %Config{} = config \\ %Config{}) do
    Clients.create_credential(client_id, params, config)
  end

  @doc """
  Get the details of a client credential.

  ## see
  https://auth0.com/docs/api/management/v2/clients/get-credentials-by-credential-id

  """
  @spec get_credential(client_id, credential_id, config) ::
          {:ok, map} | error
  def get_credential(client_id, credential_id, %Config{} = config \\ %Config{}) do
    Clients.get_credential(client_id, credential_id, config)
  end

  @doc """
  Delete a client credential you previously created. May be enabled or disabled.

  ## see
  https://auth0.com/docs/api/management/v2/clients/delete-credentials-by-credential-id

  """
  @spec delete_credential(client_id, credential_id, config) ::
          {:ok, String.t()} | error
  def delete_credential(client_id, credential_id, %Config{} = config \\ %Config{}) do
    Clients.delete_credential(client_id, credential_id, config)
  end

  @doc """
  Change a client credential you previously created. May be enabled or disabled.

  ## see
  https://auth0.com/docs/api/management/v2/clients/patch-credentials-by-credential-id

  """
  @spec update_credential(client_id, credential_id, map, config) ::
          {:ok, map} | error
  def update_credential(client_id, credential_id, %{} = params, %Config{} = config \\ %Config{}) do
    Clients.update_credential(client_id, credential_id, params, config)
  end

  @doc """
  Retrieves detailed list of all connections that match the specified strategy. If no strategy is provided, all connections within your tenant are retrieved. This action can accept a list of fields to include or exclude from the resulting list of connections.

  ## see
  https://auth0.com/docs/api/management/v2/connections/get-connections

  """
  @spec get_connections(map, config) ::
          {:ok, map} | error
  def get_connections(%{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Connections.list(params, config)
  end

  @doc """
  Creates a new connection according to the JSON object received in body.

  ## see
  https://auth0.com/docs/api/management/v2/connections/post-connections

  """
  @spec create_connection(map, config) ::
          {:ok, map} | error
  def create_connection(%{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Connections.create(params, config)
  end

  @doc """
  Retrieve details for a specified connection along with options that can be used for identity provider configuration.

  ## see
  https://auth0.com/docs/api/management/v2/connections/get-connections-by-id

  """
  @spec get_connection(id, map, config) ::
          {:ok, map} | error
  def get_connection(id, %{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Connections.get(id, params, config)
  end

  @doc """
  Removes a specific connection from your tenant. This action cannot be undone. Once removed, users can no longer use this connection to authenticate.

  ## see
  https://auth0.com/docs/api/management/v2/connections/delete-connections-by-id

  """
  @spec delete_connection(id, config) :: {:ok, String.t()} | error
  def delete_connection(id, %Config{} = config \\ %Config{}) do
    Connections.delete(id, config)
  end

  @doc """
  Update details for a specific connection, including option properties for identity provider configuration.

  ## see
  https://auth0.com/docs/api/management/v2/connections/patch-connections-by-id

  """
  @spec update_connection(id, map, config) ::
          {:ok, map} | error
  def update_connection(id, %{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Connections.update(id, params, config)
  end

  @doc """
  Retrieves the status of an ad/ldap connection referenced by its ID. 200 OK http status code response is returned when the connection is online, otherwise a 404 status code is returned along with an error message

  ## see
  https://auth0.com/docs/api/management/v2/connections/get-status

  """
  @spec get_connection_status(id, config) :: {:ok, boolean} | error
  def get_connection_status(id, %Config{} = config \\ %Config{}) do
    Connections.get_status(id, config)
  end

  @doc """
  Deletes a specified connection user by its email (you cannot delete all users from specific connection). Currently, only Database Connections are supported.

  ## see
  https://auth0.com/docs/api/management/v2/connections/delete-users-by-email

  """
  @spec delete_connection_users(id, map, config) ::
          {:ok, String.t()} | error
  def delete_connection_users(id, %{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Connections.delete_users(id, params, config)
  end

  @doc """
  Retrieve details on custom domains.

  ## see
  https://auth0.com/docs/api/management/v2/custom-domains/get-custom-domains

  """
  @spec get_custom_domain_configurations(config) ::
          {:ok, map} | error
  def get_custom_domain_configurations(%Config{} = config \\ %Config{}) do
    CustomDomains.list(config)
  end

  @doc """
  Create a new custom domain.

  ## see
  https://auth0.com/docs/api/management/v2/custom-domains/post-custom-domains

  """
  @spec configure_custom_domain(map, config) ::
          {:ok, map} | error
  def configure_custom_domain(%{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    CustomDomains.configure(params, config)
  end

  @doc """
  Get custom domain configuration.

  ## see
  https://auth0.com/docs/api/management/v2/custom-domains/get-custom-domains-by-id

  """
  @spec get_custom_domain_configuration(id, config) ::
          {:ok, map} | error
  def get_custom_domain_configuration(id, %Config{} = config \\ %Config{}) do
    CustomDomains.get(id, config)
  end

  @doc """
  Delete a custom domain and stop serving requests for it.

  ## see
  https://auth0.com/docs/api/management/v2/custom-domains/delete-custom-domains-by-id

  """
  @spec delete_custom_domain_configuration(id, config) :: {:ok, String.t()} | error
  def delete_custom_domain_configuration(id, %Config{} = config \\ %Config{}) do
    CustomDomains.delete(id, config)
  end

  @doc """
  Update a custom domain.

  ## see
  https://auth0.com/docs/api/management/v2/custom-domains/patch-custom-domains-by-id

  """
  @spec update_custom_domain_configuration(id, map, config) ::
          {:ok, map} | error
  def update_custom_domain_configuration(
        id,
        %{} = params \\ %{},
        %Config{} = config \\ %Config{}
      ) do
    CustomDomains.update(id, params, config)
  end

  @doc """
  Run the verification process on a custom domain.

  ## see
  https://auth0.com/docs/api/management/v2/custom-domains/post-verify

  """
  @spec verify_custom_domain(id, config) ::
          {:ok, map} | error
  def verify_custom_domain(id, %Config{} = config \\ %Config{}) do
    CustomDomains.verify(id, config)
  end

  @doc """
  Retrieve device credential information (public_key, refresh_token, or rotating_refresh_token) associated with a specific user.

  ## see
  https://auth0.com/docs/api/management/v2/device-credentials/get-device-credentials

  """
  @spec get_device_credentials(map, config) ::
          {:ok, map} | error
  def get_device_credentials(%{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    DeviceCredentials.list(params, config)
  end

  @doc """
  Create a device credential public key to manage refresh token rotation for a given user_id. Device Credentials APIs are designed for ad-hoc administrative use only and paging is by default enabled for GET requests.

  ## see
  https://auth0.com/docs/api/management/v2/device-credentials/post-device-credentials

  """
  @spec create_device_credential(map, config) ::
          {:ok, map} | error
  def create_device_credential(%{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    DeviceCredentials.create(params, config)
  end

  @doc """
  Permanently delete a device credential (such as a refresh token or public key) with the given ID.

  ## see
  https://auth0.com/docs/api/management/v2/device-credentials/delete-device-credentials-by-id

  """
  @spec delete_device_credential(id, config) :: {:ok, String.t()} | error
  def delete_device_credential(id, %Config{} = config \\ %Config{}) do
    DeviceCredentials.delete(id, config)
  end

  @doc """
  Modify an email template.

  ## see
  https://auth0.com/docs/api/management/v2/email-templates/patch-email-templates-by-template-name

  """
  @spec get_email_template(template_name, config) ::
          {:ok, map} | error
  def get_email_template(template_name, %Config{} = config \\ %Config{}) do
    EmailTemplates.get(template_name, config)
  end

  @doc """
  Update an email template.

  ## see
  https://auth0.com/docs/api/management/v2/email-templates/put-email-templates-by-template-name

  """
  @spec patch_email_template(template_name, map, config) ::
          {:ok, map} | error
  def patch_email_template(
        template_name,
        %{} = params \\ %{},
        %Config{} = config \\ %Config{}
      ) do
    EmailTemplates.patch(template_name, params, config)
  end

  @doc """
  Update an email template.

  ## see
  https://auth0.com/docs/api/management/v2/email-templates/put-email-templates-by-template-name

  """
  @spec update_email_template(template_name, map, config) ::
          {:ok, map} | error
  def update_email_template(
        template_name,
        %{} = params \\ %{},
        %Config{} = config \\ %Config{}
      ) do
    EmailTemplates.update(template_name, params, config)
  end

  @doc """
  Create an email template.

  ## see
  https://auth0.com/docs/api/management/v2/email-templates/post-email-templates

  """
  @spec create_email_template(map, config) ::
          {:ok, map} | error
  def create_email_template(%{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    EmailTemplates.create(params, config)
  end

  @doc """
  Retrieve details of the email provider configuration in your tenant. A list of fields to include or exclude may also be specified.

  ## see
  https://auth0.com/docs/api/management/v2/emails/get-provider

  """
  @spec get_email_provider(map, config) ::
          {:ok, map} | error
  def get_email_provider(%{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Emails.get_provider(params, config)
  end

  @doc """
  Update an email provider. The credentials object requires different properties depending on the email provider (which is specified using the name property):

  ## see
  https://auth0.com/docs/api/management/v2/emails/patch-provider

  """
  @spec update_email_provider(map, config) ::
          {:ok, map} | error
  def update_email_provider(%{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Emails.update_provider(params, config)
  end

  @doc """
  Create an email provider. The credentials object requires different properties depending on the email provider (which is specified using the name property):

  ## see
  https://auth0.com/docs/api/management/v2/emails/post-provider

  """
  @spec configure_email_provider(map, config) ::
          {:ok, map} | error
  def configure_email_provider(%{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Emails.configure_provider(params, config)
  end

  @doc """
  Retrieve the grants associated with your account.

  ## see
  https://auth0.com/docs/api/management/v2/grants/get-grants

  """
  @spec get_grants(map, config) ::
          {:ok, map} | error
  def get_grants(%{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Grants.list(params, config)
  end

  @doc """
  Delete a grant associated with your account.

  ## see
  https://auth0.com/docs/api/management/v2/grants/delete-grants-by-id

  """
  @spec delete_grant(id, config) :: {:ok, String.t()} | error
  def delete_grant(id, %Config{} = config \\ %Config{}) do
    Grants.delete(id, config)
  end

  @doc """
  Delete a grant associated with your account.

  ## see
  https://auth0.com/docs/api/management/v2/grants/delete-grants-by-user-id

  """
  @spec delete_grant_by_user_id(map, config) :: {:ok, String.t()} | error
  def delete_grant_by_user_id(%{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Grants.delete_by_user_id(params, config)
  end

  @doc """
  Retrieve details of all multi-factor authentication factors associated with your tenant.

  ## see
  https://auth0.com/docs/api/management/v2/guardian/get-factors

  """
  @spec get_guardian_factors(config) ::
          {:ok, map} | error
  def get_guardian_factors(%Config{} = config \\ %Config{}) do
    Guardian.list_factors(config)
  end

  @doc """
  Update the status (i.e., enabled or disabled) of a specific multi-factor authentication factor.

  ## see
  https://auth0.com/docs/api/management/v2/guardian/put-factors-by-name

  """
  @spec update_guardian_factor(name, map, config) ::
          {:ok, map} | error
  def update_guardian_factor(name, %{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Guardian.update_factor(name, params, config)
  end

  @doc """
  Retrieve the multi-factor authentication (MFA) policies configured for your tenant.

  ## see
  https://auth0.com/docs/api/management/v2/guardian/get-policies

  """
  @spec list_guardian_policies(config) :: {:ok, list(map)} | error
  def list_guardian_policies(%Config{} = config \\ %Config{}) do
    Guardian.list_policies(config)
  end

  @doc """
  Set multi-factor authentication (MFA) policies for your tenant.

  ## see
  https://auth0.com/docs/api/management/v2/guardian/put-policies

  """
  @spec set_guardian_policies(map, config) :: {:ok, list(map)} | error
  def set_guardian_policies(%{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Guardian.set_policies(params, config)
  end

  @doc """
  Retrieve details, such as status and type, for a specific multi-factor authentication enrollment registered to a user account.

  ## see
  https://auth0.com/docs/api/management/v2/guardian/get-enrollments-by-id

  """
  @spec get_guardian_enrollment(id, config) ::
          {:ok, map} | error
  def get_guardian_enrollment(id, %Config{} = config \\ %Config{}) do
    Guardian.get_enrollment(id, config)
  end

  @doc """
  Remove a specific multi-factor authentication (MFA) enrollment from a user's account. This allows the user to re-enroll with MFA.

  ## see
  https://auth0.com/docs/api/management/v2/guardian/delete-enrollments-by-id

  """
  @spec delete_guardian_enrollment(id, config) :: {:ok, String.t()} | error
  def delete_guardian_enrollment(id, %Config{} = config \\ %Config{}) do
    Guardian.delete_enrollment(id, config)
  end

  @doc """
  Create a multi-factor authentication (MFA) enrollment ticket, and optionally send an email with the created ticket, to a given user.

  ## see
  https://auth0.com/docs/api/management/v2/guardian/post-ticket

  """
  @spec create_guardian_enrollment_ticket(map, config) ::
          {:ok, map} | error
  def create_guardian_enrollment_ticket(
        %{} = params \\ %{},
        %Config{} = config \\ %Config{}
      ) do
    Guardian.create_enrollment_ticket(params, config)
  end

  @doc """
  Retrieve list of phone-type MFA factors (i.e., sms and voice) that are enabled for your tenant.

  ## see
  https://auth0.com/docs/api/management/v2/guardian/get-message-types

  """
  @spec get_guardian_phone_factor(config) ::
          {:ok, map} | error
  def get_guardian_phone_factor(%Config{} = config \\ %Config{}) do
    Guardian.get_phone_factor(config)
  end

  @doc """
  Replace the list of phone-type MFA factors (i.e., sms and voice) that are enabled for your tenant.

  ## see
  https://auth0.com/docs/api/management/v2/guardian/put-message-types

  """
  @spec update_guardian_phone_factor(map, config) ::
          {:ok, map} | error
  def update_guardian_phone_factor(
        %{} = params \\ %{},
        %Config{} = config \\ %Config{}
      ) do
    Guardian.update_phone_factor(params, config)
  end

  @doc """
  Retrieve details of the multi-factor authentication phone provider configured for your tenant.

  ## see
  https://auth0.com/docs/api/management/v2/guardian/get-guardian-phone-providers

  """
  @spec get_guardian_phone_configuration(config) ::
          {:ok, map} | error
  def get_guardian_phone_configuration(%Config{} = config \\ %Config{}) do
    Guardian.get_phone_configuration(config)
  end

  @doc """
  Update phone provider configuration

  ## see
  https://auth0.com/docs/api/management/v2/guardian/put-phone-providers

  """
  @spec update_guardian_phone_configuration(map, config) ::
          {:ok, map} | error
  def update_guardian_phone_configuration(
        %{} = params \\ %{},
        %Config{} = config \\ %Config{}
      ) do
    Guardian.update_phone_configuration(params, config)
  end

  @doc """
  Retrieve details of the multi-factor authentication enrollment and verification templates for phone-type factors available in your tenant.

  ## see
  https://auth0.com/docs/api/management/v2/guardian/get-factor-phone-templates

  """
  @spec get_guardian_phone_template(config) ::
          {:ok, map} | error
  def get_guardian_phone_template(%Config{} = config \\ %Config{}) do
    Guardian.get_phone_template(config)
  end

  @doc """
  Customize the messages sent to complete phone enrollment and verification (subscription required).

  ## see
  https://auth0.com/docs/api/management/v2/guardian/put-factor-phone-templates

  """
  @spec update_guardian_phone_template(map, config) ::
          {:ok, map} | error
  def update_guardian_phone_template(
        %{} = params \\ %{},
        %Config{} = config \\ %Config{}
      ) do
    Guardian.update_phone_template(params, config)
  end

  @doc """
  Retrieve SMS configuration (one of auth0|twilio|phone-message-hook).

  ## see
  https://auth0.com/docs/api/management/v2/guardian/get-sms-providers

  """
  @spec get_guardian_sms_configuration(config) ::
          {:ok, map} | error
  def get_guardian_sms_configuration(%Config{} = config \\ %Config{}) do
    Guardian.get_sms_configuration(config)
  end

  @doc """
  Update SMS configuration (one of auth0|twilio|phone-message-hook).

  ## see
  https://auth0.com/docs/api/management/v2/guardian/put-sms-providers

  """
  @spec update_guardian_sms_configuration(map, config) ::
          {:ok, map} | error
  def update_guardian_sms_configuration(
        %{} = params \\ %{},
        %Config{} = config \\ %Config{}
      ) do
    Guardian.update_sms_configuration(params, config)
  end

  @doc """
  Retrieve SMS Enrollment and Verification Templates.

  ## see
  https://auth0.com/docs/api/management/v2/guardian/get-factor-sms-templates

  """
  @spec get_guardian_sms_template(config) ::
          {:ok, map} | error
  def get_guardian_sms_template(%Config{} = config \\ %Config{}) do
    Guardian.get_sms_template(config)
  end

  @doc """
  Update SMS Enrollment and Verification Templates.

  ## see
  https://auth0.com/docs/api/management/v2/guardian/put-factor-sms-templates

  """
  @spec update_guardian_sms_template(map, config) ::
          {:ok, map} | error
  def update_guardian_sms_template(
        %{} = params \\ %{},
        %Config{} = config \\ %Config{}
      ) do
    Guardian.update_sms_template(params, config)
  end

  @doc """
  Retrieve configuration details for a Twilio phone provider that has been set up in your tenant.

  ## see
  https://auth0.com/docs/api/management/v2/guardian/get-phone-twilio-factor-provider

  """
  @spec get_guardian_twilio_phone_configuration(config) ::
          {:ok, map} | error
  def get_guardian_twilio_phone_configuration(%Config{} = config \\ %Config{}) do
    Guardian.get_twilio_phone_configuration(config)
  end

  @doc """
  Update the configuration of a Twilio phone provider that has been set up in your tenant.

  ## see
  https://auth0.com/docs/api/management/v2/guardian/put-twilio

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
  end

  @doc """
  Retrieve Twilio SMS configuration.

  ## see
  https://auth0.com/docs/api/management/v2/guardian/get-sms-twilio-factor-provider

  """
  @spec get_guardian_twilio_sms_configuration(config) ::
          {:ok, map} | error
  def get_guardian_twilio_sms_configuration(%Config{} = config \\ %Config{}) do
    Guardian.get_twilio_sms_configuration(config)
  end

  @doc """
  Update Twilio SMS configuration.

  ## see
  https://auth0.com/docs/api/management/v2/guardian/put-sms-twilio-factor-provider

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
  end

  @doc """
  Retrieve configuration details for an AWS SNS push notification provider that has been enabled for MFA.

  ## see
  https://auth0.com/docs/api/management/v2/guardian/get-sns

  """
  @spec get_guardian_aws_sns_configuration(config) ::
          {:ok, map} | error
  def get_guardian_aws_sns_configuration(%Config{} = config \\ %Config{}) do
    Guardian.get_aws_sns_configuration(config)
  end

  @doc """
  Configure the AWS SNS push notification provider configuration (subscription required).

  ## see
  https://auth0.com/docs/api/management/v2/guardian/patch-sns

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
  end

  @doc """
  Configure the AWS SNS push notification provider configuration (subscription required).

  ## see
  https://auth0.com/docs/api/management/v2/guardian/put-sns

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
  end

  @doc """
  Retrieve all hooks. Accepts a list of fields to include or exclude in the result.

  ## see
  https://auth0.com/docs/api/management/v2/hooks/get-hooks

  """
  @spec get_hooks(map, config) ::
          {:ok, map} | error
  def get_hooks(%{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Hooks.list(params, config)
  end

  @doc """
  Create a new hook.

  ## see
  https://auth0.com/docs/api/management/v2/hooks/post-hooks

  """
  @spec create_hook(map, config) ::
          {:ok, map} | error
  def create_hook(%{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Hooks.create(params, config)
  end

  @doc """
  Retrieve a hook by its ID. Accepts a list of fields to include in the result.

  ## see
  https://auth0.com/docs/api/management/v2/hooks/get-hooks-by-id

  """
  @spec get_hook(id, map, config) ::
          {:ok, map} | error
  def get_hook(id, %{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Hooks.get(id, params, config)
  end

  @doc """
  Delete a hook.

  ## see
  https://auth0.com/docs/api/management/v2/hooks/delete-hooks-by-id

  """
  @spec delete_hook(id, config) :: {:ok, String.t()} | error
  def delete_hook(id, %Config{} = config \\ %Config{}) do
    Hooks.delete(id, config)
  end

  @doc """
  Update an existing hook.

  ## see
  https://auth0.com/docs/api/management/v2/hooks/patch-hooks-by-id

  """
  @spec update_hook(id, map, config) ::
          {:ok, map} | error
  def update_hook(id, %{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Hooks.update(id, params, config)
  end

  @doc """
  Retrieve a hook's secrets by the ID of the hook.

  ## see
  https://auth0.com/docs/api/management/v2/hooks/get-secrets

  """
  @spec get_hook_secrets(id, config) ::
          {:ok, map} | error
  def get_hook_secrets(id, %Config{} = config \\ %Config{}) do
    Hooks.get_secrets(id, config)
  end

  @doc """
  Delete one or more existing secrets for a given hook. Accepts an array of secret names to delete.

  ## see
  https://auth0.com/docs/api/management/v2/hooks/delete-secrets

  """
  @spec delete_hook_secrets(id, map, config) ::
          {:ok, String.t()} | error
  def delete_hook_secrets(id, %{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Hooks.delete_secrets(id, params, config)
  end

  @doc """
  Update an existing hook.

  ## see
  https://auth0.com/docs/api/management/v2/hooks/patch-hooks-by-id

  """
  @spec update_hook_secrets(id, map, config) ::
          {:ok, map} | error
  def update_hook_secrets(id, %{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Hooks.update_secrets(id, params, config)
  end

  @doc """
  Add one or more secrets to an existing hook. Accepts an object of key-value pairs, where the key is the name of the secret. A hook can have a maximum of 20 secrets.

  ## see
  https://auth0.com/docs/api/management/v2/hooks/post-secrets

  """
  @spec add_hook_secrets(id, map, config) ::
          {:ok, map} | error
  def add_hook_secrets(id, %{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Hooks.add_secrets(id, params, config)
  end

  @doc """
  Retrieves a job. Useful to check its status.

  ## see
  https://auth0.com/docs/api/management/v2/jobs/get-jobs-by-id

  """
  @spec get_job(id, config) :: {:ok, map} | error
  def get_job(id, %Config{} = config \\ %Config{}) do
    Jobs.get(id, config)
  end

  @doc """
  Retrieve error details of a failed job.

  ## see
  https://auth0.com/docs/api/management/v2/jobs/get-errors

  """
  @spec get_job_error(id, config) ::
          {:ok, map} | error
  def get_job_error(id, %Config{} = config \\ %Config{}) do
    Jobs.get_error(id, config)
  end

  @doc """
  Export all users to a file via a long-running job.

  ## see
  https://auth0.com/docs/api/management/v2/jobs/post-users-exports

  """
  @spec create_job_users_exports(map, config) ::
          {:ok, map} | error
  def create_job_users_exports(%{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Jobs.create_users_exports(params, config)
  end

  @doc """
  Import users from a formatted file into a connection via a long-running job.

  ## see
  https://auth0.com/docs/api/management/v2/jobs/post-users-imports

  """
  @spec create_job_users_imports(map, config) ::
          {:ok, map} | error
  def create_job_users_imports(%{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Jobs.create_users_imports(params, config)
  end

  @doc """
  Send an email to the specified user that asks them to click a link to verify their email address.

  ## see
  https://auth0.com/docs/api/management/v2/jobs/post-verification-email

  """
  @spec send_job_verification_email(map, config) ::
          {:ok, map} | error
  def send_job_verification_email(%{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Jobs.send_verification_email(params, config)
  end

  @doc """
  Retrieve details of all the application signing keys associated with your tenant.

  ## see
  https://auth0.com/docs/api/management/v2/keys/get-signing-keys

  """
  @spec get_signing_keys(config) ::
          {:ok, map} | error
  def get_signing_keys(%Config{} = config \\ %Config{}) do
    Keys.list_signing(config)
  end

  @doc """
  Retrieve details of the application signing key with the given ID.

  ## see
  https://auth0.com/docs/api/management/v2/keys/get-signing-key

  """
  @spec get_signing_key(kid, config) ::
          {:ok, map} | error
  def get_signing_key(kid, %Config{} = config \\ %Config{}) do
    Keys.get_signing(kid, config)
  end

  @doc """
  Rotate the application signing key of your tenant.

  ## see
  https://auth0.com/docs/api/management/v2/keys/post-signing-keys

  """
  @spec rotate_signing_key(config) ::
          {:ok, map} | error
  def rotate_signing_key(%Config{} = config \\ %Config{}) do
    Keys.rotate_signing(config)
  end

  @doc """
  Revoke the application signing key with the given ID.

  ## see
  https://auth0.com/docs/api/management/v2/keys/put-signing-keys

  """
  @spec revoke_signing_key(kid, config) ::
          {:ok, map} | error
  def revoke_signing_key(kid, %Config{} = config \\ %Config{}) do
    Keys.revoke_signing(kid, config)
  end

  @doc """
  Retrieve details on log streams.

  ## see
  https://auth0.com/docs/api/management/v2/log-streams/get-log-streams

  """
  @spec get_log_streams(config) :: {:ok, map} | error
  def get_log_streams(%Config{} = config \\ %Config{}) do
    LogStreams.list(config)
  end

  @doc """
  Create a log stream.

  ## see
  https://auth0.com/docs/api/management/v2/log-streams/post-log-streams

  """
  @spec create_log_stream(map, config) ::
          {:ok, map} | error
  def create_log_stream(%{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    LogStreams.create(params, config)
  end

  @doc """
  Retrieve a log stream configuration and status.

  ## see
  https://auth0.com/docs/api/management/v2#!/Log_Streams/get_log_streams_by_id

  """
  @spec get_log_stream(id, config) ::
          {:ok, map} | error
  def get_log_stream(id, %Config{} = config \\ %Config{}) do
    LogStreams.get(id, config)
  end

  @doc """
  Delete a log stream.

  ## see
  https://auth0.com/docs/api/management/v2/log-streams/delete-log-streams-by-id

  """
  @spec delete_log_stream(id, config) :: {:ok, String.t()} | error
  def delete_log_stream(id, %Config{} = config \\ %Config{}) do
    LogStreams.delete(id, config)
  end

  @doc """
  Update a log stream.

  ## see
  https://auth0.com/docs/api/management/v2/log-streams/patch-log-streams-by-id

  """
  @spec update_log_stream(id, map, config) ::
          {:ok, map} | error
  def update_log_stream(id, %{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    LogStreams.update(id, params, config)
  end

  @doc """
  Retrieve log entries that match the specified search criteria (or all log entries if no criteria specified).

  ## see
  https://auth0.com/docs/api/management/v2/logs/get-logs

  """
  @spec get_log_events(map, config) ::
          {:ok, map} | error
  def get_log_events(%{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Logs.list(params, config)
  end

  @doc """
  Retrieve an individual log event.

  ## see
  https://auth0.com/docs/api/management/v2/logs/get-logs-by-id

  """
  @spec get_log_event(id, config) :: {:ok, map} | error
  def get_log_event(id, %Config{} = config \\ %Config{}) do
    Logs.get(id, config)
  end

  @doc """
  Retrive detailed list of all Organizations available in your tenant.

  ## see
  https://auth0.com/docs/api/management/v2/organizations/get-organizations

  """
  @spec get_organizations(map, config) ::
          {:ok, map} | error
  def get_organizations(%{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Organizations.list(params, config)
  end

  @doc """
  Create a new Organization within your tenant.

  ## see
  https://auth0.com/docs/api/management/v2/organizations/post-organizations

  """
  @spec create_organization(map, config) ::
          {:ok, map} | error
  def create_organization(%{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Organizations.create(params, config)
  end

  @doc """
  Retrieve details about a single Organization specified by ID.

  ## see
  https://auth0.com/docs/api/management/v2/organizations/get-organizations-by-id

  """
  @spec get_organization(id, config) ::
          {:ok, map} | error
  def get_organization(id, %Config{} = config \\ %Config{}) do
    Organizations.get(id, config)
  end

  @doc """
  Remove an Organization from your tenant. This action cannot be undone.

  ## see
  https://auth0.com/docs/api/management/v2/organizations/delete-organizations-by-id

  """
  @spec delete_organization(id, config) :: {:ok, String.t()} | error
  def delete_organization(id, %Config{} = config \\ %Config{}) do
    Organizations.delete(id, config)
  end

  @doc """
  Update the details of a specific Organization, such as name and display name, branding options, and metadata.

  ## see
  https://auth0.com/docs/api/management/v2/organizations/patch-organizations-by-id

  """
  @spec modify_organization(id, map, config) ::
          {:ok, map} | error
  def modify_organization(id, %{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Organizations.modify(id, params, config)
  end

  @doc """
  Retrieve details about a single Organization specified by name.

  ## see
  https://auth0.com/docs/api/management/v2/organizations/get-name-by-name

  """
  @spec get_organization_by_name(name, config) ::
          {:ok, map} | error
  def get_organization_by_name(name, %Config{} = config \\ %Config{}) do
    Organizations.get_by_name(name, config)
  end

  @doc """
  Retrieve details about a specific connection currently enabled for an Organization. Information returned includes details such as connection ID, name, strategy, and whether the connection automatically grants membership upon login.

  ## see
  https://auth0.com/docs/api/management/v2/organizations/get-enabled-connections

  """
  @spec get_organization_connections(id, map, config) ::
          {:ok, map} | error
  def get_organization_connections(
        id,
        %{} = params \\ %{},
        %Config{} = config \\ %Config{}
      ) do
    Organizations.list_connections(id, params, config)
  end

  @doc """
  Enable a specific connection for a given Organization. To enable a connection, it must already exist within your tenant; connections cannot be created through this action.

  ## see
  https://auth0.com/docs/api/management/v2/organizations/post-enabled-connections

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
  end

  @doc """
  Retrieve details about a specific connection currently enabled for an Organization. Information returned includes details such as connection ID, name, strategy, and whether the connection automatically grants membership upon login.

  ## see
  https://auth0.com/docs/api/management/v2/organizations/get-enabled-connections-by-connection-id

  """
  @spec get_organization_connection(id, connection_id, config) ::
          {:ok, map} | error
  def get_organization_connection(id, connection_id, %Config{} = config \\ %Config{}) do
    Organizations.get_connection(id, connection_id, config)
  end

  @doc """
  Disable a specific connection for an Organization. Once disabled, Organization members can no longer use that connection to authenticate.

  ## see
  https://auth0.com/docs/api/management/v2/organizations/delete-enabled-connections-by-connection-id

  """
  @spec delete_organization_connection(id, connection_id, config) ::
          {:ok, String.t()} | error
  def delete_organization_connection(id, connection_id, %Config{} = config \\ %Config{}) do
    Organizations.delete_connection(id, connection_id, config)
  end

  @doc """
  Modify the details of a specific connection currently enabled for an Organization.

  ## see
  https://auth0.com/docs/api/management/v2/organizations/patch-enabled-connections-by-connection-id

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
  end

  @doc """
  Retrieve a detailed list of invitations sent to users for a specific Organization. The list includes details such as inviter and invitee information, invitation URLs, and dates of creation and expiration.

  ## see
  https://auth0.com/docs/api/management/v2/organizations/get-invitations

  """
  @spec get_organization_invitations(id, map, config) ::
          {:ok, map} | error
  def get_organization_invitations(
        id,
        %{} = params \\ %{},
        %Config{} = config \\ %Config{}
      ) do
    Organizations.list_invitations(id, params, config)
  end

  @doc """
  Create a user invitation for a specific Organization. Upon creation, the listed user receives an email inviting them to join the Organization.

  ## see
  https://auth0.com/docs/api/management/v2/organizations/post-invitations

  """
  @spec create_organization_invitation(id, map, config) ::
          {:ok, map} | error
  def create_organization_invitation(
        id,
        %{} = params \\ %{},
        %Config{} = config \\ %Config{}
      ) do
    Organizations.create_invitation(id, params, config)
  end

  @doc """
  Get a specific invitation to an Organization

  ## see
  https://auth0.com/docs/api/management/v2/organizations/get-invitations-by-invitation-id

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
  end

  @doc """
  Delete an invitation to an Organization

  ## see
  https://auth0.com/docs/api/management/v2/organizations/delete-invitations-by-invitation-id

  """
  @spec delete_organization_invitation(id, invitation_id, config) ::
          {:ok, String.t()} | error
  def delete_organization_invitation(id, invitation_id, %Config{} = config \\ %Config{}) do
    Organizations.delete_invitation(id, invitation_id, config)
  end

  @doc """
  List organization members.

  ## see
  https://auth0.com/docs/api/management/v2/organizations/get-members

  """
  @spec get_organization_members(id, map, config) ::
          {:ok, map} | error
  def get_organization_members(
        id,
        %{} = params \\ %{},
        %Config{} = config \\ %Config{}
      ) do
    Organizations.list_members(id, params, config)
  end

  @doc """
  Delete members from an organization

  ## see
  https://auth0.com/docs/api/management/v2/organizations/delete-members

  """
  @spec delete_organization_members(id, map, config) ::
          {:ok, String.t()} | error
  def delete_organization_members(
        id,
        %{} = params \\ %{},
        %Config{} = config \\ %Config{}
      ) do
    Organizations.delete_members(id, params, config)
  end

  @doc """
  Set one or more existing users as members of a specific Organization.

  ## see
  https://auth0.com/docs/api/management/v2/organizations/post-members

  """
  @spec add_organization_members(id, map, config) ::
          {:ok, String.t()} | error
  def add_organization_members(
        id,
        %{} = params \\ %{},
        %Config{} = config \\ %Config{}
      ) do
    Organizations.add_members(id, params, config)
  end

  @doc """
  Retrieve detailed list of roles assigned to a given user within the context of a specific Organization.

  ## see
  https://auth0.com/docs/api/management/v2/organizations/get-organization-member-roles

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
  end

  @doc """
  Remove one or more Organization-specific roles from a given user.

  ## see
  https://auth0.com/docs/api/management/v2/organizations/delete-organization-member-roles

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
  end

  @doc """
  Assign one or more roles to a user to determine their access for a specific Organization.

  ## see
  https://auth0.com/docs/api/management/v2/organizations/post-organization-member-roles

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
  end

  @doc """
  Retrieve details of the Universal Login configuration of your tenant. This includes the Identifier First Authentication and WebAuthn with Device Biometrics for MFA features.

  ## see
  https://auth0.com/docs/api/management/v2/prompts/get-prompts

  """
  @spec get_prompt_setting(config) :: {:ok, map} | error
  def get_prompt_setting(%Config{} = config \\ %Config{}) do
    Prompts.get(config)
  end

  @doc """
  Update the Universal Login configuration of your tenant. This includes the Identifier First Authentication and WebAuthn with Device Biometrics for MFA features.

  ## see
  https://auth0.com/docs/api/management/v2/prompts/patch-prompts

  """
  @spec update_prompt_setting(map, config) ::
          {:ok, map} | error
  def update_prompt_setting(%{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Prompts.update(params, config)
  end

  @doc """
  Retrieve custom text for a specific prompt and language.

  ## see
  https://auth0.com/docs/api/management/v2/prompts/get-custom-text-by-language

  """
  @spec get_prompt_custom_text(prompt, language, config) ::
          {:ok, map} | error
  def get_prompt_custom_text(prompt, language, %Config{} = config \\ %Config{}) do
    Prompts.get_custom_text(prompt, language, config)
  end

  @doc """
  Set custom text for a specific prompt. Existing texts will be overwritten.

  ## see
  https://auth0.com/docs/api/management/v2/prompts/put-custom-text-by-language

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
  end

  @doc """
  Retrieve refresh token information.

  ## see
  https://auth0.com/docs/api/management/v2/refresh-tokens/get-refresh-token

  """
  @spec get_refresh_token(id, config) ::
          {:ok, map} | error
  def get_refresh_token(id, %Config{} = config \\ %Config{}) do
    RefreshTokens.get(id, config)
  end

  @doc """
  Delete a refresh token by its ID.

  ## see
  https://auth0.com/docs/api/management/v2/refresh-tokens/delete-refresh-token

  """
  @spec delete_refresh_token(id, config) ::
          {:ok, map} | error
  def delete_refresh_token(id, %Config{} = config \\ %Config{}) do
    RefreshTokens.delete(id, config)
  end

  @doc """
  Retrieve details of all APIs associated with your tenant.

  ## see
  https://auth0.com/docs/api/management/v2/resource-servers/get-resource-servers

  """
  @spec get_resource_servers(map, config) ::
          {:ok, map} | error
  def get_resource_servers(%{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    ResourceServers.list(params, config)
  end

  @doc """
  Create a new API associated with your tenant. Note that all new APIs must be registered with Auth0.

  ## see
  https://auth0.com/docs/api/management/v2/resource-servers/post-resource-servers

  """
  @spec create_resource_server(map, config) ::
          {:ok, map} | error
  def create_resource_server(%{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    ResourceServers.create(params, config)
  end

  @doc """
  Retrieve API details with the given ID.

  ## see
  https://auth0.com/docs/api/management/v2/resource-servers/get-resource-servers-by-id

  """
  @spec get_resource_server(id, map, config) ::
          {:ok, map} | error
  def get_resource_server(id, %{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    ResourceServers.get(id, params, config)
  end

  @doc """
  Delete an existing API by ID.

  ## see
  https://auth0.com/docs/api/management/v2/resource-servers/delete-resource-servers-by-id

  """
  @spec delete_resource_server(id, config) :: {:ok, String.t()} | error
  def delete_resource_server(id, %Config{} = config \\ %Config{}) do
    ResourceServers.delete(id, config)
  end

  @doc """
  Change an existing API setting by resource server ID.

  ## see
  https://auth0.com/docs/api/management/v2/resource-servers/patch-resource-servers-by-id

  """
  @spec update_resource_server(id, map, config) ::
          {:ok, map} | error
  def update_resource_server(id, %{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    ResourceServers.update(id, params, config)
  end

  @doc """
  Retrieve detailed list of user roles created in your tenant.

  ## see
  https://auth0.com/docs/api/management/v2/roles/get-roles

  """
  @spec get_roles(map, config) ::
          {:ok, map} | error
  def get_roles(%{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Roles.list(params, config)
  end

  @doc """
  Create a user role for Role-Based Access Control.

  ## see
  https://auth0.com/docs/api/management/v2/roles/post-roles

  """
  @spec create_role(map, config) ::
          {:ok, map} | error
  def create_role(%{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Roles.create(params, config)
  end

  @doc """
  Retrieve details about a specific user role specified by ID.

  ## see
  https://auth0.com/docs/api/management/v2/roles/get-roles-by-id

  """
  @spec get_role(id, config) :: {:ok, map} | error
  def get_role(id, %Config{} = config \\ %Config{}) do
    Roles.get(id, config)
  end

  @doc """
  Delete a specific user role from your tenant. Once deleted, it is removed from any user who was previously assigned that role. This action cannot be undone.

  ## see
  https://auth0.com/docs/api/management/v2/roles/delete-roles-by-id

  """
  @spec delete_role(id, config) :: {:ok, String.t()} | error
  def delete_role(id, %Config{} = config \\ %Config{}) do
    Roles.delete(id, config)
  end

  @doc """
  Modify the details of a specific user role specified by ID.

  ## see
  https://auth0.com/docs/api/management/v2/roles/patch-roles-by-id

  """
  @spec update_role(id, map, config) ::
          {:ok, map} | error
  def update_role(id, %{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Roles.update(id, params, config)
  end

  @doc """
  Retrieve detailed list (name, description, resource server) of permissions granted by a specified user role.

  ## see
  https://auth0.com/docs/api/management/v2/roles/get-role-permission

  """
  @spec get_role_permissions(id, map, config) ::
          {:ok, map} | error
  def get_role_permissions(id, %{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Roles.list_permissions(id, params, config)
  end

  @doc """
  Remove one or more permissions from a specified user role.

  ## see
  https://auth0.com/docs/api/management/v2/roles/delete-role-permission-assignment

  """
  @spec remove_role_permissions(id, map, config) ::
          {:ok, String.t()} | error
  def remove_role_permissions(id, %{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Roles.remove_permissions(id, params, config)
  end

  @doc """
  Add one or more permissions to a specified user role.

  ## see
  https://auth0.com/docs/api/management/v2/roles/post-role-permission-assignment

  """
  @spec associate_role_permissions(id, map, config) ::
          {:ok, String.t()} | error
  def associate_role_permissions(
        id,
        %{} = params \\ %{},
        %Config{} = config \\ %Config{}
      ) do
    Roles.associate_permissions(id, params, config)
  end

  @doc """
  Retrieve list of users associated with a specific role.

  ## see
  https://auth0.com/docs/api/management/v2/roles/get-role-user

  """
  @spec get_role_users(id, map, config) ::
          {:ok, map} | error
  def get_role_users(id, %{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Roles.list_users(id, params, config)
  end

  @doc """
  Assign one or more users to an existing user role.

  ## see
  https://auth0.com/docs/api/management/v2/roles/post-role-users

  """
  @spec assign_role_users(id, map, config) ::
          {:ok, String.t()} | error
  def assign_role_users(id, %{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Roles.assign_users(id, params, config)
  end

  @doc """
  Retrieve a filtered list of rules. Accepts a list of fields to include or exclude.

  ## see
  https://auth0.com/docs/api/management/v2/rules/get-rules

  """
  @spec get_rules(map, config) ::
          {:ok, map} | error
  def get_rules(%{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Rules.list(params, config)
  end

  @doc """
  Create a new rule.

  ## see
  https://auth0.com/docs/api/management/v2/rules/post-rules

  """
  @spec create_rule(map, config) ::
          {:ok, map} | error
  def create_rule(%{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Rules.create(params, config)
  end

  @doc """
  Retrieve rule details. Accepts a list of fields to include or exclude in the result.

  ## see
  https://auth0.com/docs/api/management/v2/rules/get-rules-by-id

  """
  @spec get_rule(id, map, config) ::
          {:ok, map} | error
  def get_rule(id, %{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Rules.get(id, params, config)
  end

  @doc """
  Delete a rule.

  ## see
  https://auth0.com/docs/api/management/v2/rules/delete-rules-by-id

  """
  @spec delete_rule(id, config) :: {:ok, String.t()} | error
  def delete_rule(id, %Config{} = config \\ %Config{}) do
    Rules.delete(id, config)
  end

  @doc """
  Update an existing rule.

  ## see
  https://auth0.com/docs/api/management/v2/rules/patch-rules-by-id

  """
  @spec update_rule(id, map, config) ::
          {:ok, map} | error
  def update_rule(id, %{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Rules.update(id, params, config)
  end

  @doc """
  Retrieve rules config variable keys.

  ## see
  https://auth0.com/docs/api/management/v2/rules-configs/get-rules-configs

  """
  @spec get_rules_configs(config) ::
          {:ok, map} | error
  def get_rules_configs(%Config{} = config \\ %Config{}) do
    RulesConfigs.list(config)
  end

  @doc """
  Delete a rules config variable identified by its key.

  ## see
  https://auth0.com/docs/api/management/v2/rules-configs/delete-rules-configs-by-key

  """
  @spec delete_rules_config(key, config) :: {:ok, String.t()} | error
  def delete_rules_config(key, %Config{} = config \\ %Config{}) do
    RulesConfigs.delete(key, config)
  end

  @doc """
  Sets a rules config variable.

  ## see
  https://auth0.com/docs/api/management/v2/rules-configs/put-rules-configs-by-key

  """
  @spec set_rules_config(key, map, config) ::
          {:ok, map} | error
  def set_rules_config(key, %{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    RulesConfigs.set(key, params, config)
  end

  @doc """
  Retrieve session information.

  ## see
  https://auth0.com/docs/api/management/v2/sessions/get-session

  """
  @spec get_session(id, config) ::
          {:ok, map} | error
  def get_session(id, %Config{} = config \\ %Config{}) do
    Sessions.get(id, config)
  end

  @doc """
  Delete a session by ID.

  ## see
  https://auth0.com/docs/api/management/v2/sessions/delete-session

  """
  @spec delete_session(id, config) ::
          {:ok, map} | error
  def delete_session(id, %Config{} = config \\ %Config{}) do
    Sessions.delete(id, config)
  end

  @doc """
  Retrieve the number of active users that logged in during the last 30 days.

  ## see
  https://auth0.com/docs/api/management/v2/stats/get-active-users

  """
  @spec get_active_users_count(config) :: {:ok, integer} | error
  def get_active_users_count(%Config{} = config \\ %Config{}) do
    Stats.count_active_users(config)
  end

  @doc """
  Retrieve the number of logins, signups and breached-password detections (subscription required) that occurred each day within a specified date range.

  ## see
  https://auth0.com/docs/api/management/v2/stats/get-daily

  """
  @spec get_daily_stats(config) :: {:ok, map} | error
  def get_daily_stats(%Config{} = config \\ %Config{}) do
    Stats.list_daily(config)
  end

  @doc """
  Retrieve tenant settings. A list of fields to include or exclude may also be specified.

  ## see
  https://auth0.com/docs/api/management/v2/tenants/tenant-settings-route

  """
  @spec get_tenant_setting(map, config) ::
          {:ok, map} | error
  def get_tenant_setting(%{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Tenants.get_setting(params, config)
  end

  @doc """
  Update settings for a tenant.

  ## see
  https://auth0.com/docs/api/management/v2/tenants/patch-settings

  """
  @spec update_tenant_setting(map, config) ::
          {:ok, map} | error
  def update_tenant_setting(%{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Tenants.update_setting(params, config)
  end

  @doc """
  Create an email verification ticket for a given user. An email verification ticket is a generated URL that the user can consume to verify their email address.

  ## see
  https://auth0.com/docs/api/management/v2/tickets/post-email-verification

  """
  @spec create_email_verification_ticket(map, config) ::
          {:ok, map} | error
  def create_email_verification_ticket(
        %{} = params \\ %{},
        %Config{} = config \\ %Config{}
      ) do
    Tickets.create_email_verification(params, config)
  end

  @doc """
  Create a password change ticket for a given user. A password change ticket is a generated URL that the user can consume to start a reset password flow.

  ## see
  https://auth0.com/docs/api/management/v2/tickets/post-password-change

  """
  @spec create_password_change_ticket(map, config) ::
          {:ok, map} | error
  def create_password_change_ticket(
        %{} = params \\ %{},
        %Config{} = config \\ %Config{}
      ) do
    Tickets.create_password_change(params, config)
  end

  @doc """
  Retrieve details of all Brute-force Protection blocks for a user with the given identifier (username, phone number, or email).

  ## see
  https://auth0.com/docs/api/management/v2/user-blocks/get-user-blocks

  """
  @spec get_user_block(map, config) ::
          {:ok, map} | error
  def get_user_block(%{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    UserBlocks.get(params, config)
  end

  @doc """
  Remove all Brute-force Protection blocks for the user with the given identifier (username, phone number, or email).

  ## see
  https://auth0.com/docs/api/management/v2/user-blocks/delete-user-blocks

  """
  @spec unblock_user_block(map, config) ::
          {:ok, String.t()} | error
  def unblock_user_block(%{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    UserBlocks.unblock(params, config)
  end

  @doc """
  Retrieve details of all Brute-force Protection blocks for the user with the given ID.

  ## see
  https://auth0.com/docs/api/management/v2/user-blocks/get-user-blocks-by-id

  """
  @spec get_user_block_by_user_id(id, map, config) ::
          {:ok, map} | error
  def get_user_block_by_user_id(id, %{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    UserBlocks.get_by_user_id(id, params, config)
  end

  @doc """
  Remove all Brute-force Protection blocks for the user with the given ID.

  ## see
  https://auth0.com/docs/api/management/v2/user-blocks/delete-user-blocks-by-id

  """
  @spec unblock_user_block_by_user_id(id, config) :: {:ok, String.t()} | error
  def unblock_user_block_by_user_id(id, %Config{} = config \\ %Config{}) do
    UserBlocks.unblock_by_user_id(id, config)
  end

  @doc """
  Retrieve details of users.

  ## see
  https://auth0.com/docs/api/management/v2/users/get-users

  """
  @spec get_users(map, config) ::
          {:ok, map} | error
  def get_users(%{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Users.list(params, config)
  end

  @doc """
  Create a new user for a given database or passwordless connection.

  ## see
  https://auth0.com/docs/api/management/v2/users/post-users

  """
  @spec create_user(map, config) ::
          {:ok, map} | error
  def create_user(%{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Users.create(params, config)
  end

  @doc """
  Retrieve user details. A list of fields to include or exclude may also be specified.

  ## see
  https://auth0.com/docs/api/management/v2/users/get-users-by-id

  """
  @spec get_user(id, map, config) ::
          {:ok, map} | error
  def get_user(id, %{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Users.get(id, params, config)
  end

  @doc """
  Delete a user by user ID. This action cannot be undone.

  ## see
  https://auth0.com/docs/api/management/v2/users/delete-users-by-id

  """
  @spec delete_user(id, config) :: {:ok, String.t()} | error
  def delete_user(id, %Config{} = config \\ %Config{}) do
    Users.delete(id, config)
  end

  @doc """
  Update a user.

  ## see
  https://auth0.com/docs/api/management/v2/users/patch-users-by-id

  """
  @spec update_user(id, map, config) ::
          {:ok, map} | error
  def update_user(id, %{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Users.update(id, params, config)
  end

  @doc """
  Retrieve the first multi-factor authentication enrollment that a specific user has confirmed.

  ## see
  https://auth0.com/docs/api/management/v2/users/get-enrollments

  """
  @spec get_user_enrollments(id, config) ::
          {:ok, map} | error
  def get_user_enrollments(id, %Config{} = config \\ %Config{}) do
    Users.get_enrollments(id, config)
  end

  @doc """
  Retrieve detailed list of all user roles currently assigned to a user.

  ## see
  https://auth0.com/docs/api/management/v2/users/get-user-roles

  """
  @spec get_user_roles(id, map, config) ::
          {:ok, map} | error
  def get_user_roles(id, %{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Users.get_roles(id, params, config)
  end

  @doc """
  Remove one or more specified user roles assigned to a user.

  ## see
  https://auth0.com/docs/api/management/v2/users/delete-user-roles

  """
  @spec remove_user_roles(id, map, config) ::
          {:ok, String.t()} | error
  def remove_user_roles(id, %{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Users.remove_roles(id, params, config)
  end

  @doc """
  Assign one or more existing user roles to a user.

  ## see
  https://auth0.com/docs/api/management/v2/users/post-user-roles

  """
  @spec assign_user_roles(id, map, config) ::
          {:ok, String.t()} | error
  def assign_user_roles(id, %{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Users.assign_roles(id, params, config)
  end

  @doc """
  Retrieve log events for a specific user.

  ## see
  https://auth0.com/docs/api/management/v2/users/get-logs-by-user

  """
  @spec get_user_logs(id, map, config) ::
          {:ok, map} | error
  def get_user_logs(id, %{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Users.get_logs(id, params, config)
  end

  @doc """
  Retrieve list of the specified user's current Organization memberships. User must be specified by user ID.

  ## see
  https://auth0.com/docs/api/management/v2/users/get-user-organizations

  """
  @spec get_user_organizations(id, map, config) ::
          {:ok, map} | error
  def get_user_organizations(id, %{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Users.get_organizations(id, params, config)
  end

  @doc """
  Retrieve all permissions associated with the user.

  ## see
  https://auth0.com/docs/api/management/v2/users/get-permissions

  """
  @spec get_user_permissions(id, map, config) ::
          {:ok, map} | error
  def get_user_permissions(id, %{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Users.get_permissions(id, params, config)
  end

  @doc """
  Remove permissions from a user.

  ## see
  https://auth0.com/docs/api/management/v2/users/delete-permissions

  """
  @spec remove_user_permissions(id, map, config) ::
          {:ok, String.t()} | error
  def remove_user_permissions(id, %{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Users.remove_permissions(id, params, config)
  end

  @doc """
  Assign permissions to a user.

  ## see
  https://auth0.com/docs/api/management/v2/users/post-permissions

  """
  @spec assign_user_permissions(id, map, config) ::
          {:ok, String.t()} | error
  def assign_user_permissions(id, %{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Users.assign_permissions(id, params, config)
  end

  @doc """
  Remove a multifactor authentication configuration from a user's account. This forces the user to manually reconfigure the multi-factor provider.

  ## see
  https://auth0.com/docs/api/management/v2/users/delete-multifactor-by-provider

  """
  @spec delete_user_multifactor(id, map, config) ::
          {:ok, String.t()} | error
  def delete_user_multifactor(
        id,
        %{} = params \\ %{},
        %Config{} = config \\ %Config{}
      ) do
    Users.delete_multifactor(id, params, config)
  end

  @doc """
  Invalidate all remembered browsers across all authentication factors for a user.

  ## see
  https://auth0.com/docs/api/management/v2/users/post-invalidate-remember-browser

  """
  @spec invalidate_user_remembered_browser_for_multifactor(id, config) ::
          {:ok, String.t()} | error
  def invalidate_user_remembered_browser_for_multifactor(
        id,
        %Config{} = config \\ %Config{}
      ) do
    Users.invalidate_remembered_browser_for_multifactor(id, config)
  end

  @doc """
  Link two user accounts together forming a primary and secondary relationship. On successful linking, the endpoint returns the new array of the primary account identities.

  ## see
  https://auth0.com/docs/api/management/v2/users/post-identities

  """
  @spec link_user_identities(id, map, config) ::
          {:ok, map} | error
  def link_user_identities(
        id,
        %{} = params \\ %{},
        %Config{} = config \\ %Config{}
      ) do
    Users.link_identities(id, params, config)
  end

  @doc """
  Unlink a specific secondary account from a target user. This action requires the ID of both the target user and the secondary account.

  ## see
  https://auth0.com/docs/api/management/v2/users/delete-user-identity-by-user-id

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
  end

  @doc """
  Remove an existing multi-factor authentication (MFA) recovery code and generate a new one. If a user cannot access the original device or account used for MFA enrollment, they can use a recovery code to authenticate.

  ## see
  https://auth0.com/docs/api/management/v2/users/post-recovery-code-regeneration

  """
  @spec regenerate_user_recovery_code(id, config) ::
          {:ok, map} | error
  def regenerate_user_recovery_code(
        id,
        %Config{} = config \\ %Config{}
      ) do
    Users.regenerate_recovery_code(id, config)
  end

  @doc """
  Retrieve details for a user's refresh tokens.

  ## see
  https://auth0.com/docs/api/management/v2/users/get-refresh-tokens-for-user

  """
  @spec get_user_refresh_tokens(id, map, config) ::
          {:ok, map} | error
  def get_user_refresh_tokens(id, %{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Users.get_refresh_tokens(id, params, config)
  end

  @doc """
  Delete all refresh tokens for a user.

  ## see
  https://auth0.com/docs/api/management/v2/users/delete-refresh-tokens-for-user

  """
  @spec delete_user_refresh_tokens(id, config) ::
          {:ok, map} | error
  def delete_user_refresh_tokens(id, %Config{} = config \\ %Config{}) do
    Users.delete_refresh_tokens(id, config)
  end

  @doc """
  Retrieve details for a user's sessions.

  ## see
  https://auth0.com/docs/api/management/v2/users/get-sessions-for-user

  """
  @spec get_user_sessions(id, map, config) ::
          {:ok, map} | error
  def get_user_sessions(id, %{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Users.get_sessions(id, params, config)
  end

  @doc """
  Retrieve details for a user's sessions.

  ## see
  https://auth0.com/docs/api/management/v2/users/get-sessions-for-user

  """
  @spec delete_user_sessions(id, config) ::
          {:ok, map} | error
  def delete_user_sessions(id, %Config{} = config \\ %Config{}) do
    Users.delete_sessions(id, config)
  end

  @doc """
  Find users by email. If Auth0 is the identity provider (idP), the email address associated with a user is saved in lower case, regardless of how you initially provided it.

  ## see
  https://auth0.com/docs/api/management/v2/users-by-email/get-users-by-email

  """
  @spec get_users_by_email(map, config) ::
          {:ok, map} | error
  def get_users_by_email(%{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    UsersByEmail.list(params, config)
  end
end
