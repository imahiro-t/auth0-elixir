defmodule Auth0.Api.Management do
  @moduledoc """
  Documentation for Auth0 Management API.

  """

  alias Auth0.Config
  alias Auth0.Management.Actions
  alias Auth0.Management.Agents
  alias Auth0.Management.Anomaly
  alias Auth0.Management.AttackProtection
  alias Auth0.Management.Blacklist
  alias Auth0.Management.Branding
  alias Auth0.Management.ClientGrants
  alias Auth0.Management.Clients
  alias Auth0.Management.Connections
  alias Auth0.Management.ConnectionProfiles
  alias Auth0.Management.CustomDomains
  alias Auth0.Management.DeviceCredentials
  alias Auth0.Management.EmailTemplates
  alias Auth0.Management.Emails
  alias Auth0.Management.EventStreams
  alias Auth0.Management.Flows
  alias Auth0.Management.Forms
  alias Auth0.Management.Grants
  alias Auth0.Management.Groups
  alias Auth0.Management.Guardian
  alias Auth0.Management.Hooks
  alias Auth0.Management.Jobs
  alias Auth0.Management.Keys
  alias Auth0.Management.LogStreams
  alias Auth0.Management.Logs
  alias Auth0.Management.NetworkAcls
  alias Auth0.Management.Organizations
  alias Auth0.Management.Prompts
  alias Auth0.Management.RateLimitPolicies
  alias Auth0.Management.RefreshTokens
  alias Auth0.Management.ResourceServers
  alias Auth0.Management.RiskAssessments
  alias Auth0.Management.Roles
  alias Auth0.Management.Rules
  alias Auth0.Management.RulesConfigs
  alias Auth0.Management.SelfServiceProfiles
  alias Auth0.Management.Sessions
  alias Auth0.Management.Stats
  alias Auth0.Management.SupplementalSignals
  alias Auth0.Management.Tenants
  alias Auth0.Management.Tickets
  alias Auth0.Management.TokenExchangeProfiles
  alias Auth0.Management.UserAttributeProfiles
  alias Auth0.Management.UserBlocks
  alias Auth0.Management.Users
  alias Auth0.Management.UsersByEmail
  alias Auth0.Management.VerifiableCredentials

  @type config :: Config.t()
  @type theme_id :: String.t()
  @type id :: String.t()
  @type token_id :: String.t()
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
  @type authentication_method_id :: String.t()
  @type error :: {:error, integer, term} | {:error, term}
  @type request_opts :: [custom_domain: String.t()]
  @type value_params :: %{required(:value) => list() | map(), optional(any()) => any()}
  @type provider_params :: %{required(:provider) => String.t(), optional(any()) => any()}

  @doc """
  Retrieve all actions.

  ## query parameters
  - `triggerId`
  - `actionName`
  - `deployed`
  - `page`
  - `per_page`
  - `installed`

  ## see
  https://auth0.com/docs/api/management/v2/actions/get-actions

  """
  @spec get_actions(map(), config) ::
          {:ok, map()} | error
  def get_actions(%{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Actions.list(params, config)
  end

  @doc """
  Create an action. Once an action is created, it must be deployed, and then bound to a trigger before it will be executed as part of a flow.

  ## see
  https://auth0.com/docs/api/management/v2/actions/post-action

  """
  @spec create_action(map(), config) ::
          {:ok, map()} | error
  def create_action(%{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Actions.create(params, config)
  end

  @doc """
  Retrieve all of an action's versions. An action version is created whenever an action is deployed. An action version is immutable, once created.

  ## query parameters
  - `page`
  - `per_page`

  ## see
  https://auth0.com/docs/api/management/v2/actions/get-action-versions

  """
  @spec get_action_versions(action_id, map(), config) ::
          {:ok, map()} | error
  def get_action_versions(action_id, %{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Actions.list_versions(action_id, params, config)
  end

  @doc """
  Retrieve a specific version of an action. An action version is created whenever an action is deployed. An action version is immutable, once created.

  ## see
  https://auth0.com/docs/api/management/v2/actions/get-action-version

  """
  @spec get_action_version(action_id, id, config) ::
          {:ok, map()} | error
  def get_action_version(action_id, id, %Config{} = config \\ %Config{}) do
    Actions.get_version(action_id, id, config)
  end

  @doc """
  Performs the equivalent of a roll-back of an action to an earlier, specified version. Creates a new, deployed action version that is identical to the specified version. If this action is currently bound to a trigger, the system will begin executing the newly-created version immediately.

  ## see
  https://auth0.com/docs/api/management/v2/actions/post-deploy-draft-version

  """
  @spec rollback_action_version(action_id, id, map(), config) ::
          {:ok, map()} | error
  def rollback_action_version(
        action_id,
        id,
        %{} = params \\ %{},
        %Config{} = config \\ %Config{}
      ) do
    Actions.rollback_version(action_id, id, params, config)
  end

  @doc """
  Retrieve an action by its ID.

  ## see
  https://auth0.com/docs/api/management/v2/actions/get-action

  """
  @spec get_action(id, config) ::
          {:ok, map()} | error
  def get_action(id, %Config{} = config \\ %Config{}) do
    Actions.get(id, config)
  end

  @doc """
  Deletes an action and all of its associated versions. An action must be unbound from all triggers before it can be deleted.

  ## query parameters
  - `force`

  ## see
  https://auth0.com/docs/api/management/v2/actions/delete-action

  """
  @spec delete_action(id, map(), config) ::
          {:ok, String.t()} | error
  def delete_action(id, %{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Actions.delete(id, params, config)
  end

  @doc """
  Update an existing action. If this action is currently bound to a trigger, updating it will not affect any user flows until the action is deployed.

  ## see
  https://auth0.com/docs/api/management/v2/actions/patch-action

  """
  @spec update_action(id, map(), config) ::
          {:ok, map()} | error
  def update_action(id, %{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Actions.update(id, params, config)
  end

  @doc """
  Deploy an action. Deploying an action will create a new immutable version of the action. If the action is currently bound to a trigger, then the system will begin executing the newly deployed version of the action immediately. Otherwise, the action will only be executed as a part of a flow once it is bound to that flow.

  ## see
  https://auth0.com/docs/api/management/v2/actions/post-deploy-action

  """
  @spec deploy_action(id, config) ::
          {:ok, map()} | error
  def deploy_action(id, %Config{} = config \\ %Config{}) do
    Actions.deploy(id, config)
  end

  @doc """
  Test an action. After updating an action, it can be tested prior to being deployed to ensure it behaves as expected.

  ## see
  https://auth0.com/docs/api/management/v2/actions/post-test-action

  """
  @spec test_action(id, map(), config) ::
          {:ok, map()} | error
  def test_action(id, %{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Actions.test(id, params, config)
  end

  @doc """
  Retrieve information about a specific execution of a trigger. Relevant execution IDs will be included in tenant logs generated as part of that authentication flow. Executions will only be stored for 10 days after their creation.

  ## see
  https://auth0.com/docs/api/management/v2/actions/get-execution

  """
  @spec get_action_execution(id, config) ::
          {:ok, map()} | error
  def get_action_execution(id, %Config{} = config \\ %Config{}) do
    Actions.get_execution(id, config)
  end

  @doc """
  Retrieve the set of triggers currently available within actions. A trigger is an extensibility point to which actions can be bound.

  ## see
  https://auth0.com/docs/api/management/v2/actions/get-triggers

  """
  @spec get_action_triggers(config) ::
          {:ok, map()} | error
  def get_action_triggers(%Config{} = config \\ %Config{}) do
    Actions.get_triggers(config)
  end

  @doc """
  Retrieve the actions that are bound to a trigger. Once an action is created and deployed, it must be attached (i.e. bound) to a trigger so that it will be executed as part of a flow. The list of actions returned reflects the order in which they will be executed during the appropriate flow.

  ## query parameters
  - `page`
  - `per_page`

  ## see
  https://auth0.com/docs/api/management/v2/actions/get-bindings

  """
  @spec get_action_trigger_bindings(trigger_id, map(), config) ::
          {:ok, map()} | error
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
          map(),
          config
        ) ::
          {:ok, map()} | error
  def update_action_trigger_bindings(
        trigger_id,
        %{} = params \\ %{},
        %Config{} = config \\ %Config{}
      ) do
    Actions.update_bindings(trigger_id, params, config)
  end

  @doc """
  Get agents.

  **Early Access**: this endpoint is marked as Early Access (`x-release-lifecycle: EA`) in the Auth0 Management API specification and may not be available on every tenant.

  ## query parameters
  - `from`
  - `take`

  ## see
  https://auth0.com/docs/api/management/v2/agents/get-agents

  """
  @spec get_agents(map(), config) :: {:ok, map()} | error
  def get_agents(%{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Agents.list(params, config)
  end

  @doc """
  Create an agent.

  **Early Access**: this endpoint is marked as Early Access (`x-release-lifecycle: EA`) in the Auth0 Management API specification and may not be available on every tenant.

  ## see
  https://auth0.com/docs/api/management/v2/agents/post-agent

  """
  @spec create_agent(map(), config) :: {:ok, map()} | error
  def create_agent(%{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Agents.create(params, config)
  end

  @doc """
  Get an agent.

  **Early Access**: this endpoint is marked as Early Access (`x-release-lifecycle: EA`) in the Auth0 Management API specification and may not be available on every tenant.

  Path parameters are percent-encoded before they are placed in the request path.

  ## see
  https://auth0.com/docs/api/management/v2/agents/get-agent

  """
  @spec get_agent(String.t(), config) :: {:ok, map()} | error
  def get_agent(id, %Config{} = config \\ %Config{}) do
    Agents.get(id, config)
  end

  @doc """
  Update an agent.

  **Early Access**: this endpoint is marked as Early Access (`x-release-lifecycle: EA`) in the Auth0 Management API specification and may not be available on every tenant.

  Path parameters are percent-encoded before they are placed in the request path.

  ## see
  https://auth0.com/docs/api/management/v2/agents/patch-agent

  """
  @spec update_agent(String.t(), map(), config) :: {:ok, map()} | error
  def update_agent(id, %{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Agents.update(id, params, config)
  end

  @doc """
  Delete an agent.

  **Early Access**: this endpoint is marked as Early Access (`x-release-lifecycle: EA`) in the Auth0 Management API specification and may not be available on every tenant.

  Path parameters are percent-encoded before they are placed in the request path.

  ## see
  https://auth0.com/docs/api/management/v2/agents/delete-agent

  """
  @spec delete_agent(String.t(), config) :: {:ok, String.t()} | error
  def delete_agent(id, %Config{} = config \\ %Config{}) do
    Agents.delete(id, config)
  end

  @doc """
  List Actions Modules.

  Retrieve a paginated list of all Actions Modules with optional filtering and totals.

  **Early Access**: this endpoint is marked as Early Access (`x-release-lifecycle: EA`) in the Auth0 Management API specification and may not be available on every tenant.

  ## query parameters
  - `page`
  - `per_page`

  ## see
  https://auth0.com/docs/api/management/v2/actions/get-action-modules

  """
  @spec get_action_modules(map(), config) :: {:ok, map()} | error
  def get_action_modules(%{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Actions.list_modules(params, config)
  end

  @doc """
  Create a new Actions Module.

  Create a new Actions Module for reusable code across actions.

  **Early Access**: this endpoint is marked as Early Access (`x-release-lifecycle: EA`) in the Auth0 Management API specification and may not be available on every tenant.

  ## see
  https://auth0.com/docs/api/management/v2/actions/post-action-module

  """
  @spec create_action_module(map(), config) :: {:ok, map()} | error
  def create_action_module(%{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Actions.create_module(params, config)
  end

  @doc """
  Get a specific Actions Module by ID.

  Retrieve details of a specific Actions Module by its unique identifier.

  **Early Access**: this endpoint is marked as Early Access (`x-release-lifecycle: EA`) in the Auth0 Management API specification and may not be available on every tenant.

  Path parameters are percent-encoded before they are placed in the request path.

  ## see
  https://auth0.com/docs/api/management/v2/actions/get-action-module

  """
  @spec get_action_module(String.t(), config) :: {:ok, map()} | error
  def get_action_module(id, %Config{} = config \\ %Config{}) do
    Actions.get_module(id, config)
  end

  @doc """
  Update a specific Actions Module.

  Update properties of an existing Actions Module, such as code, dependencies, or secrets.

  **Early Access**: this endpoint is marked as Early Access (`x-release-lifecycle: EA`) in the Auth0 Management API specification and may not be available on every tenant.

  Path parameters are percent-encoded before they are placed in the request path.

  ## see
  https://auth0.com/docs/api/management/v2/actions/patch-action-module

  """
  @spec update_action_module(String.t(), map(), config) :: {:ok, map()} | error
  def update_action_module(id, %{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Actions.update_module(id, params, config)
  end

  @doc """
  Delete a specific Actions Module by ID.

  Permanently delete an Actions Module. This will fail if the module is still in use by any actions.

  **Early Access**: this endpoint is marked as Early Access (`x-release-lifecycle: EA`) in the Auth0 Management API specification and may not be available on every tenant.

  Path parameters are percent-encoded before they are placed in the request path.

  ## see
  https://auth0.com/docs/api/management/v2/actions/delete-action-module

  """
  @spec delete_action_module(String.t(), config) :: {:ok, String.t()} | error
  def delete_action_module(id, %Config{} = config \\ %Config{}) do
    Actions.delete_module(id, config)
  end

  @doc """
  List all actions using an Actions Module.

  Lists all actions that are using a specific Actions Module, showing which deployed action versions reference this Actions Module.

  **Early Access**: this endpoint is marked as Early Access (`x-release-lifecycle: EA`) in the Auth0 Management API specification and may not be available on every tenant.

  ## query parameters
  - `page`
  - `per_page`

  Path parameters are percent-encoded before they are placed in the request path.

  ## see
  https://auth0.com/docs/api/management/v2/actions/get-action-module-actions

  """
  @spec get_action_module_actions(String.t(), map(), config) :: {:ok, map()} | error
  def get_action_module_actions(id, %{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Actions.list_module_actions(id, params, config)
  end

  @doc """
  Rollback an Actions Module to a previous version.

  Rolls back an Actions Module's draft to a previously created version. This action copies the code, dependencies, and secrets from the specified version into the current draft.

  **Early Access**: this endpoint is marked as Early Access (`x-release-lifecycle: EA`) in the Auth0 Management API specification and may not be available on every tenant.

  Path parameters are percent-encoded before they are placed in the request path.

  ## see
  https://auth0.com/docs/api/management/v2/actions/post-action-module-rollback

  """
  @spec rollback_action_module(String.t(), map(), config) :: {:ok, map()} | error
  def rollback_action_module(id, %{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Actions.rollback_module(id, params, config)
  end

  @doc """
  List all versions of an Actions Module.

  List all published versions of a specific Actions Module.

  **Early Access**: this endpoint is marked as Early Access (`x-release-lifecycle: EA`) in the Auth0 Management API specification and may not be available on every tenant.

  ## query parameters
  - `page`
  - `per_page`

  Path parameters are percent-encoded before they are placed in the request path.

  ## see
  https://auth0.com/docs/api/management/v2/actions/get-action-module-versions

  """
  @spec get_action_module_versions(String.t(), map(), config) :: {:ok, map()} | error
  def get_action_module_versions(id, %{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Actions.list_module_versions(id, params, config)
  end

  @doc """
  Create a new version of an Actions Module.

  Creates a new immutable version of an Actions Module from the current draft version. This publishes the draft as a new version that can be referenced by actions, while maintaining the existing draft for continued development.

  **Early Access**: this endpoint is marked as Early Access (`x-release-lifecycle: EA`) in the Auth0 Management API specification and may not be available on every tenant.

  Path parameters are percent-encoded before they are placed in the request path.

  ## see
  https://auth0.com/docs/api/management/v2/actions/post-action-module-version

  """
  @spec create_action_module_version(String.t(), config) :: {:ok, map()} | error
  def create_action_module_version(id, %Config{} = config \\ %Config{}) do
    Actions.create_module_version(id, config)
  end

  @doc """
  Get a specific version of an Actions Module.

  Retrieve the details of a specific, immutable version of an Actions Module.

  **Early Access**: this endpoint is marked as Early Access (`x-release-lifecycle: EA`) in the Auth0 Management API specification and may not be available on every tenant.

  Path parameters are percent-encoded before they are placed in the request path.

  ## see
  https://auth0.com/docs/api/management/v2/actions/get-action-module-version

  """
  @spec get_action_module_version(String.t(), String.t(), config) :: {:ok, map()} | error
  def get_action_module_version(id, version_id, %Config{} = config \\ %Config{}) do
    Actions.get_module_version(id, version_id, config)
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
          {:ok, map()} | error
  def get_attack_protection_breached_password_detection(%Config{} = config \\ %Config{}) do
    AttackProtection.get_breached_password_detection(config)
  end

  @doc """
  Update details of the Breached Password Detection configuration of your tenant.

  ## see
  https://auth0.com/docs/api/management/v2/attack-protection/patch-breached-password-detection

  """
  @spec update_attack_protection_breached_password_detection(
          map(),
          config
        ) ::
          {:ok, map()} | error
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
          {:ok, map()} | error
  def get_attack_protection_brute_force_protection(%Config{} = config \\ %Config{}) do
    AttackProtection.get_brute_force_protection(config)
  end

  @doc """
  Update the Brute-force Protection configuration of your tenant.

  ## body properties to note
  The request body is sent as given. These properties have a non-GA lifecycle in the Auth0 specification:
  - `form_submission_mode` (beta)

  ## see
  https://auth0.com/docs/api/management/v2/attack-protection/patch-brute-force-protection

  """
  @spec update_attack_protection_brute_force_protection(
          map(),
          config
        ) ::
          {:ok, map()} | error
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
          {:ok, map()} | error
  def get_attack_protection_suspicious_ip_throttling(%Config{} = config \\ %Config{}) do
    AttackProtection.get_suspicious_ip_throttling(config)
  end

  @doc """
  Update the details of the Suspicious IP Throttling configuration of your tenant.

  ## see
  https://auth0.com/docs/api/management/v2/attack-protection/patch-suspicious-ip-throttling

  """
  @spec update_attack_protection_suspicious_ip_throttling(
          map(),
          config
        ) ::
          {:ok, map()} | error
  def update_attack_protection_suspicious_ip_throttling(
        %{} = params \\ %{},
        %Config{} = config \\ %Config{}
      ) do
    AttackProtection.update_suspicious_ip_throttling(params, config)
  end

  @doc """
  Get the CAPTCHA configuration for a tenant.

  Get the CAPTCHA configuration for your client.

  ## see
  https://auth0.com/docs/api/management/v2/attack-protection/get-captcha

  """
  @spec get_attack_protection_captcha(config) :: {:ok, map()} | error
  def get_attack_protection_captcha(%Config{} = config \\ %Config{}) do
    AttackProtection.get_captcha(config)
  end

  @doc """
  Partial Update for CAPTCHA Configuration.

  Update existing CAPTCHA configuration for your client.

  ## see
  https://auth0.com/docs/api/management/v2/attack-protection/patch-captcha

  """
  @spec update_attack_protection_captcha(map(), config) :: {:ok, map()} | error
  def update_attack_protection_captcha(%{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    AttackProtection.update_captcha(params, config)
  end

  @doc """
  Get Phone Provider Protection settings.

  Get the phone provider protection configuration for a tenant.

  ## see
  https://auth0.com/docs/api/management/v2/attack-protection/get-phone-provider-protection

  """
  @spec get_attack_protection_phone_provider_protection(config) :: {:ok, map()} | error
  def get_attack_protection_phone_provider_protection(%Config{} = config \\ %Config{}) do
    AttackProtection.get_phone_provider_protection(config)
  end

  @doc """
  Update Phone Provider Protection settings.

  Update the phone provider protection configuration for a tenant.

  ## see
  https://auth0.com/docs/api/management/v2/attack-protection/patch-phone-provider-protection

  """
  @spec update_attack_protection_phone_provider_protection(map(), config) :: {:ok, map()} | error
  def update_attack_protection_phone_provider_protection(
        %{} = params \\ %{},
        %Config{} = config \\ %Config{}
      ) do
    AttackProtection.update_phone_provider_protection(params, config)
  end

  @doc """
  Get the Bot Detection configuration of your tenant.

  ## see
  https://auth0.com/docs/api/management/v2/attack-protection/get-bot-detection

  """
  @spec get_attack_protection_bot_detection(config) :: {:ok, map()} | error
  def get_attack_protection_bot_detection(%Config{} = config \\ %Config{}) do
    AttackProtection.get_bot_detection(config)
  end

  @doc """
  Update the Bot Detection configuration of your tenant.

  ## see
  https://auth0.com/docs/api/management/v2/attack-protection/patch-bot-detection

  """
  @spec update_attack_protection_bot_detection(map(), config) :: {:ok, map()} | error
  def update_attack_protection_bot_detection(
        %{} = params \\ %{},
        %Config{} = config \\ %Config{}
      ) do
    AttackProtection.update_bot_detection(params, config)
  end

  @doc """
  Retrieve the jti and aud of all tokens that are blacklisted.

  ## see
  https://auth0.com/docs/api/management/v2/blacklists/get-tokens

  """
  @spec get_blacklisted_tokens(map(), config) ::
          {:ok, list(map())} | error
  def get_blacklisted_tokens(%{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Blacklist.list_tokens(params, config)
  end

  @doc """
  Add the token identified by the jti to a blacklist for the tenant.

  ## see
  https://auth0.com/docs/api/management/v2/blacklists/post-tokens

  """
  @spec blacklist_token(map(), config) ::
          {:ok, String.t()} | error
  def blacklist_token(%{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Blacklist.add_token(params, config)
  end

  @doc """
  Retrieve branding settings.

  ## see
  https://auth0.com/docs/api/management/v2/branding/get-branding

  """
  @spec get_branding(config) :: {:ok, map()} | error
  def get_branding(%Config{} = config \\ %Config{}) do
    Branding.get(config)
  end

  @doc """
  Update branding settings.

  ## see
  https://auth0.com/docs/api/management/v2/branding/patch-branding

  """
  @spec update_branding(map(), config) ::
          {:ok, map()} | error
  def update_branding(%{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Branding.update(params, config)
  end

  @doc """
  Retrieve a list ofphone providers details set for a Tenant. A list of fields to include or exclude may also be specified.

  ## query parameters
  - `disabled`

  ## see
  https://auth0.com/docs/api/management/v2/branding/get-branding-phone-providers

  """
  @spec list_branding_phone_providers(map(), config) ::
          {:ok, map()} | error
  def list_branding_phone_providers(%{} = params, %Config{} = config) do
    Branding.list_phone_providers(params, config)
  end

  @doc """
  Create an phone provider.

  ## see
  https://auth0.com/docs/api/management/v2/branding/create-phone-provider

  """
  @spec configure_branding_phone_provider(map(), config) ::
          {:ok, map()} | error
  def configure_branding_phone_provider(%{} = params, %Config{} = config) do
    Branding.configure_phone_provider(params, config)
  end

  @doc """
  Retrieve phone provider details. A list of fields to include or exclude may also be specified.

  ## see
  https://auth0.com/docs/api/management/v2/branding/get-phone-provider

  """
  @spec get_branding_phone_provider(id, config) ::
          {:ok, map()} | error
  def get_branding_phone_provider(id, %Config{} = config) do
    Branding.get_phone_provider(id, config)
  end

  @doc """
  Delete the configured phone provider.

  ## see
  https://auth0.com/docs/api/management/v2/branding/delete-phone-provider

  """
  @spec delete_branding_phone_provider(id, config) ::
          {:ok, map()} | error
  def delete_branding_phone_provider(id, %Config{} = config) do
    Branding.delete_phone_provider(id, config)
  end

  @doc """
  Update an phone provider.

  ## see
  https://auth0.com/docs/api/management/v2/branding/update-phone-provider

  """
  @spec update_branding_phone_provider(id, map(), config) ::
          {:ok, map()} | error
  def update_branding_phone_provider(id, %{} = params, %Config{} = config) do
    Branding.update_phone_provider(id, params, config)
  end

  @doc """
  Send a test phone notification for the configured provider

  ## see
  https://auth0.com/docs/api/management/v2/branding/try-phone-provider

  """
  @spec test_branding_phone_provider(id, map(), config) ::
          {:ok, map()} | error
  def test_branding_phone_provider(id, %{} = params, %Config{} = config) do
    Branding.test_phone_provider(id, params, config)
  end

  @doc """
  Get a list of phone notification templates

  ## query parameters
  - `disabled`

  ## see
  https://auth0.com/docs/api/management/v2/branding/get-phone-templates

  """
  @spec list_branding_phone_templates(map(), config) ::
          {:ok, map()} | error
  def list_branding_phone_templates(%{} = params, %Config{} = config) do
    Branding.list_phone_templates(params, config)
  end

  @doc """
  Create a phone notification template

  ## see
  https://auth0.com/docs/api/management/v2/branding/create-phone-template

  """
  @spec create_branding_phone_template(map(), config) ::
          {:ok, map()} | error
  def create_branding_phone_template(%{} = params, %Config{} = config) do
    Branding.create_phone_template(params, config)
  end

  @doc """
  Get a phone notification template

  ## see
  https://auth0.com/docs/api/management/v2/branding/get-phone-template

  """
  @spec get_branding_phone_template(id, config) ::
          {:ok, map()} | error
  def get_branding_phone_template(id, %Config{} = config) do
    Branding.get_phone_template(id, config)
  end

  @doc """
  Delete a phone notification template

  ## see
  https://auth0.com/docs/api/management/v2/branding/delete-phone-template

  """
  @spec delete_branding_phone_template(id, config) ::
          {:ok, map()} | error
  def delete_branding_phone_template(id, %Config{} = config) do
    Branding.delete_phone_template(id, config)
  end

  @doc """
  Update a phone notification template

  ## see
  https://auth0.com/docs/api/management/v2/branding/update-phone-template

  """
  @spec update_branding_phone_template(id, map(), config) ::
          {:ok, map()} | error
  def update_branding_phone_template(id, %{} = params, %Config{} = config) do
    Branding.update_phone_template(id, params, config)
  end

  @doc """
  Resets a phone notification template values

  ## see
  https://auth0.com/docs/api/management/v2/branding/reset-phone-template

  """
  @spec reset_branding_phone_template(id, map(), config) ::
          {:ok, map()} | error
  def reset_branding_phone_template(id, %{} = params, %Config{} = config) do
    Branding.reset_phone_template(id, params, config)
  end

  @doc """
  Send a test phone notification for the configured template

  ## options
  - `:custom_domain` - sent as the `auth0-custom-domain` header so that Auth0 uses
    this custom domain (host name, optionally with a port) for links it generates.
    An invalid value raises `ArgumentError`.

  ## see
  https://auth0.com/docs/api/management/v2/branding/try-phone-template

  """
  @spec test_branding_phone_template(id, map(), config, request_opts) ::
          {:ok, map()} | error
  def test_branding_phone_template(id, %{} = params, %Config{} = config, opts \\ []) do
    Branding.test_phone_template(id, params, config, opts)
  end

  @doc """
  Get template for New Universal Login Experience

  ## see
  https://auth0.com/docs/api/management/v2/branding/get-universal-login

  """
  @spec get_template_for_universal_login(config) ::
          {:ok, map() | String.t()} | error
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
  @spec set_template_for_universal_login(map(), config) ::
          {:ok, String.t()} | error
  def set_template_for_universal_login(
        %{} = params \\ %{},
        %Config{} = config \\ %Config{}
      ) do
    Branding.set_universal_login(params, config)
  end

  @doc """
  Create branding theme.

  ## body properties to note
  The request body is sent as given. These properties have a non-GA lifecycle in the Auth0 specification:
  - `identifiers` (Early Access)

  ## see
  https://auth0.com/docs/api/management/v2/branding/post-branding-theme

  """
  @spec create_branding_theme(map(), config) ::
          {:ok, map()} | error
  def create_branding_theme(%{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Branding.create_theme(params, config)
  end

  @doc """
  Retrieve default branding theme.

  ## see
  https://auth0.com/docs/api/management/v2/branding/get-default-branding-theme

  """
  @spec get_default_branding_theme(config) ::
          {:ok, map()} | error
  def get_default_branding_theme(%Config{} = config \\ %Config{}) do
    Branding.get_default_theme(config)
  end

  @doc """
  Retrieve branding theme.

  ## see
  https://auth0.com/docs/api/management/v2/branding/get-branding-theme

  """
  @spec get_branding_theme(theme_id, config) ::
          {:ok, map()} | error
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

  ## body properties to note
  The request body is sent as given. These properties have a non-GA lifecycle in the Auth0 specification:
  - `identifiers` (Early Access)

  ## see
  https://auth0.com/docs/api/management/v2/branding/patch-branding-theme

  """
  @spec update_branding_theme(theme_id, map(), config) ::
          {:ok, map()} | error
  def update_branding_theme(theme_id, %{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Branding.update_theme(theme_id, params, config)
  end

  @doc """
  Retrieve a list of client grants, including the scopes associated with the application/API pair.

  ## query parameters
  - `per_page`
  - `page`
  - `include_totals`
  - `from`
  - `take`
  - `audience`
  - `client_id`
  - `allow_any_organization`
  - `subject_type`
  - `default_for`

  ## see
  https://auth0.com/docs/api/management/v2/client-grants/get-client-grants

  """
  @spec get_client_grants(map(), config) ::
          {:ok, list(map()) | map()} | error
  def get_client_grants(%{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    ClientGrants.list(params, config)
  end

  @doc """
  Create a client grant for a machine-to-machine login flow.

  ## see
  https://auth0.com/docs/api/management/v2/client-grants/post-client-grants

  """
  @spec create_client_grant(map(), config) ::
          {:ok, map()} | error
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
  @spec update_client_grant(id, map(), config) ::
          {:ok, map()} | error
  def update_client_grant(id, %{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    ClientGrants.update(id, params, config)
  end

  @doc """
  Get client grant.

  Retrieve a single [client grant](https://auth0.com/docs/get-started/applications/application-access-to-apis-client-grants), including the scopes associated with the application/API pair.

  Path parameters are percent-encoded before they are placed in the request path.

  ## see
  https://auth0.com/docs/api/management/v2/client-grants/get-client-grant

  """
  @spec get_client_grant(String.t(), config) :: {:ok, map()} | error
  def get_client_grant(id, %Config{} = config \\ %Config{}) do
    ClientGrants.get(id, config)
  end

  @doc """
  Get the organizations associated to a client grant.

  ## query parameters
  - `page`
  - `per_page`
  - `include_totals`
  - `from`
  - `take`

  Path parameters are percent-encoded before they are placed in the request path.

  ## see
  https://auth0.com/docs/api/management/v2/client-grants/get-client-grant-organizations

  """
  @spec get_client_grant_organizations(String.t(), map(), config) ::
          {:ok, map() | list(map())} | error
  def get_client_grant_organizations(id, %{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    ClientGrants.list_organizations(id, params, config)
  end

  @doc """
  Retrieve clients (applications and SSO integrations) matching provided filters. A list of fields to include or exclude may also be specified.

  ## query parameters
  - `fields`
  - `include_fields`
  - `page`
  - `per_page`
  - `include_totals`
  - `from`
  - `take`
  - `is_global`
  - `is_first_party`
  - `app_type`
  - `external_client_id`
  - `q`

  ## see
  https://auth0.com/docs/api/management/v2/clients/get-clients

  """
  @spec get_clients(map(), config) ::
          {:ok, list(map()) | map()} | error
  def get_clients(%{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Clients.list(params, config)
  end

  @doc """
  Create a new client (application or SSO integration).

  ## body properties to note
  The request body is sent as given. These properties have a non-GA lifecycle in the Auth0 specification:
  - `anonymous_sessions` (Early Access)
  - `b2b_integration_configuration` (Early Access)
  - `fedcm_login` (Early Access)
  - `identity_assertion_authorization_grant` (Early Access)
  - `my_organization_configuration` (Early Access)
  - `organization_discovery_methods` (Early Access)
  - `token_quota` (Early Access)
  - `token_vault_privileged_access` (Early Access)

  ## see
  https://auth0.com/docs/api/management/v2/clients/post-clients

  """
  @spec create_client(map(), config) ::
          {:ok, map()} | error
  def create_client(%{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Clients.create(params, config)
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
  @spec create_credential(client_id, map(), config) ::
          {:ok, map()} | error
  def create_credential(client_id, %{} = params, %Config{} = config \\ %Config{}) do
    Clients.create_credential(client_id, params, config)
  end

  @doc """
  Get the details of a client credential.

  ## see
  https://auth0.com/docs/api/management/v2/clients/get-credentials-by-credential-id

  """
  @spec get_credential(client_id, credential_id, config) ::
          {:ok, map()} | error
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
  @spec update_credential(client_id, credential_id, map(), config) ::
          {:ok, map()} | error
  def update_credential(client_id, credential_id, %{} = params, %Config{} = config \\ %Config{}) do
    Clients.update_credential(client_id, credential_id, params, config)
  end

  @doc """
  Retrieve client details by ID. Clients are SSO connections or Applications linked with your Auth0 tenant. A list of fields to include or exclude may also be specified.

  ## query parameters
  - `fields`
  - `include_fields`

  ## see
  https://auth0.com/docs/api/management/v2/clients/get-clients-by-id

  """
  @spec get_client(id, map(), config) ::
          {:ok, map()} | error
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

  ## body properties to note
  The request body is sent as given. These properties have a non-GA lifecycle in the Auth0 specification:
  - `anonymous_sessions` (Early Access)
  - `b2b_integration_configuration` (Early Access)
  - `fedcm_login` (Early Access)
  - `identity_assertion_authorization_grant` (Early Access)
  - `my_organization_configuration` (Early Access)
  - `organization_discovery_methods` (Early Access)
  - `token_quota` (Early Access)
  - `token_vault_privileged_access` (Early Access)

  ## see
  https://auth0.com/docs/api/management/v2/clients/patch-clients-by-id

  """
  @spec update_client(id, map(), config) ::
          {:ok, map()} | error
  def update_client(id, %{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Clients.update(id, params, config)
  end

  @doc """
  Rotate a client secret.

  ## see
  https://auth0.com/docs/api/management/v2/clients/post-rotate-secret

  """
  @spec rotate_client_secret(id, config) ::
          {:ok, map()} | error
  def rotate_client_secret(id, %Config{} = config \\ %Config{}) do
    Clients.rotate_secret(id, config)
  end

  @doc """
  Preview and validate Client ID Metadata Document.

  Fetches and validates a Client ID Metadata Document without creating a client. Returns the raw metadata and how it would be mapped to Auth0 client fields. This endpoint is useful for testing metadata URIs before creating CIMD clients.

  ## see
  https://auth0.com/docs/api/management/v2/clients/post-clients-cimd-preview

  """
  @spec preview_client_cimd_metadata(map(), config) :: {:ok, map()} | error
  def preview_client_cimd_metadata(%{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Clients.preview_cimd_metadata(params, config)
  end

  @doc """
  Register or update a CIMD client via metadata URI.

  Idempotent registration for Client ID Metadata Document (CIMD) clients. Uses external_client_id as the unique identifier for upsert operations.

  ## see
  https://auth0.com/docs/api/management/v2/clients/post-clients-cimd-register

  """
  @spec register_cimd_client(map(), config) :: {:ok, map()} | error
  def register_cimd_client(%{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Clients.register_cimd_client(params, config)
  end

  @doc """
  Get enabled connections for a client.

  Retrieve all connections that are enabled for the specified [Application](https://www.auth0.com/docs/get-started/applications), using checkpoint pagination. A list of fields to include or exclude for each connection may also be specified.

  ## query parameters
  - `strategy` (array: pass a list such as `["a", "b"]` to send multiple values; it is sent as repeated `strategy=` keys)
  - `from`
  - `take`
  - `fields`
  - `include_fields`

  Path parameters are percent-encoded before they are placed in the request path.

  ## see
  https://auth0.com/docs/api/management/v2/clients/get-client-connections

  """
  @spec get_client_connections(String.t(), map(), config) :: {:ok, map()} | error
  def get_client_connections(id, %{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Clients.list_connections(id, params, config)
  end

  @doc """
  Retrieve a list of connection profiles.

  ## query parameters
  - `from`
  - `take`

  ## see
  https://auth0.com/docs/api/management/v2/connection-profiles/get-connection-profiles
  """
  @spec get_connection_profiles(map(), config) :: {:ok, list(map())} | error
  def get_connection_profiles(%{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    ConnectionProfiles.list(params, config)
  end

  @doc """
  Retrieve a connection profile by its ID.

  ## see
  https://auth0.com/docs/api/management/v2/connection-profiles/get-connection-profiles-by-id
  """
  @spec get_connection_profile(id, config) :: {:ok, map()} | error
  def get_connection_profile(id, %Config{} = config \\ %Config{}) do
    ConnectionProfiles.get(id, config)
  end

  @doc """
  Update a connection profile.

  ## body properties to note
  The request body is sent as given. These properties have a non-GA lifecycle in the Auth0 specification:
  - `cross_app_access_resource_app` (Early Access)

  ## see
  https://auth0.com/docs/api/management/v2/connection-profiles/patch-connection-profiles-by-id
  """
  @spec update_connection_profile(id, map(), config) :: {:ok, map()} | error
  def update_connection_profile(id, %{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    ConnectionProfiles.update(id, params, config)
  end

  @doc """
  Create a connection profile.

  Create a Connection Profile.

  ## see
  https://auth0.com/docs/api/management/v2/connection-profiles/post-connection-profiles

  """
  @spec create_connection_profile(map(), config) :: {:ok, map()} | error
  def create_connection_profile(%{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    ConnectionProfiles.create(params, config)
  end

  @doc """
  Get Connection Profile Templates.

  Retrieve a list of Connection Profile Templates.

  ## see
  https://auth0.com/docs/api/management/v2/connection-profiles/get-connection-profile-templates

  """
  @spec get_connection_profile_templates(config) :: {:ok, map()} | error
  def get_connection_profile_templates(%Config{} = config \\ %Config{}) do
    ConnectionProfiles.list_templates(config)
  end

  @doc """
  Get Connection Profile Template.

  Retrieve a Connection Profile Template.

  Path parameters are percent-encoded before they are placed in the request path.

  ## see
  https://auth0.com/docs/api/management/v2/connection-profiles/get-connection-profile-template

  """
  @spec get_connection_profile_template(String.t(), config) :: {:ok, map()} | error
  def get_connection_profile_template(id, %Config{} = config \\ %Config{}) do
    ConnectionProfiles.get_template(id, config)
  end

  @doc """
  Delete Connection Profile.

  Delete a single Connection Profile specified by ID.

  Path parameters are percent-encoded before they are placed in the request path.

  ## see
  https://auth0.com/docs/api/management/v2/connection-profiles/delete-connection-profiles-by-id

  """
  @spec delete_connection_profile(String.t(), config) :: {:ok, String.t()} | error
  def delete_connection_profile(id, %Config{} = config \\ %Config{}) do
    ConnectionProfiles.delete(id, config)
  end

  @doc """
  Retrieves detailed list of all connections that match the specified strategy. If no strategy is provided, all connections within your tenant are retrieved. This action can accept a list of fields to include or exclude from the resulting list of connections.

  ## query parameters
  - `per_page`
  - `page`
  - `include_totals`
  - `from`
  - `take`
  - `strategy` (array: pass a list such as `["a", "b"]` to send multiple values; it is sent as repeated `strategy=` keys)
  - `name`
  - `fields`
  - `include_fields`

  ## see
  https://auth0.com/docs/api/management/v2/connections/get-connections

  """
  @spec get_connections(map(), config) ::
          {:ok, list(map()) | map()} | error
  def get_connections(%{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Connections.list(params, config)
  end

  @doc """
  Creates a new connection according to the JSON object received in body.

  ## body properties to note
  The request body is sent as given. These properties have a non-GA lifecycle in the Auth0 specification:
  - `cross_app_access_requesting_app` (Early Access)
  - `cross_app_access_resource_app` (Early Access)

  ## see
  https://auth0.com/docs/api/management/v2/connections/post-connections

  """
  @spec create_connection(map(), config) ::
          {:ok, map()} | error
  def create_connection(%{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Connections.create(params, config)
  end

  @doc """
  Retrieve details for a specified connection along with options that can be used for identity provider configuration.

  ## query parameters
  - `fields`
  - `include_fields`

  ## see
  https://auth0.com/docs/api/management/v2/connections/get-connections-by-id

  """
  @spec get_connection(id, map(), config) ::
          {:ok, map()} | error
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

  ## body properties to note
  The request body is sent as given. These properties have a non-GA lifecycle in the Auth0 specification:
  - `cross_app_access_requesting_app` (Early Access)
  - `cross_app_access_resource_app` (Early Access)
  - `enabled_clients` (deprecated)

  ## see
  https://auth0.com/docs/api/management/v2/connections/patch-connections-by-id

  """
  @spec update_connection(id, map(), config) ::
          {:ok, map()} | error
  def update_connection(id, %{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Connections.update(id, params, config)
  end

  @doc """
  Retrieves a scim configuration by its connectionId.

  ## see
  https://auth0.com/docs/api/management/v2/connections/get-scim-configuration

  """
  @spec get_connection_scim_configuration(id, config) :: {:ok, map()} | error
  def get_connection_scim_configuration(id, %Config{} = config) do
    Connections.get_scim_configuration(id, config)
  end

  @doc """
  Deletes a scim configuration by its connectionId.

  ## see
  https://auth0.com/docs/api/management/v2/connections/delete-scim-configuration

  """
  @spec delete_connection_scim_configuration(id, config) :: {:ok, String.t()} | error
  def delete_connection_scim_configuration(id, %Config{} = config) do
    Connections.delete_scim_configuration(id, config)
  end

  @doc """
  Update a scim configuration by its connectionId.

  ## see
  https://auth0.com/docs/api/management/v2/connections/patch-scim-configuration

  """
  @spec update_connection_scim_configuration(id, map(), config) :: {:ok, map()} | error
  def update_connection_scim_configuration(id, %{} = params, %Config{} = config) do
    Connections.update_scim_configuration(id, params, config)
  end

  @doc """
  Create a scim configuration for a connection.

  ## see
  https://auth0.com/docs/api/management/v2/connections/post-scim-configuration

  """
  @spec create_connection_scim_configuration(id, map(), config) :: {:ok, map()} | error
  def create_connection_scim_configuration(id, %{} = params, %Config{} = config) do
    Connections.create_scim_configuration(id, params, config)
  end

  @doc """
  Retrieves a scim configuration's default mapping by its connectionId.

  ## see
  https://auth0.com/docs/api/management/v2/connections/get-default-mapping

  """
  @spec get_connection_scim_configuration_default_mapping(id, config) ::
          {:ok, map()} | error
  def get_connection_scim_configuration_default_mapping(id, %Config{} = config) do
    Connections.get_scim_configuration_default_mapping(id, config)
  end

  @doc """
  Retrieves all scim tokens by its connection id.

  ## see
  https://auth0.com/docs/api/management/v2/connections/get-scim-tokens

  """
  @spec get_connection_scim_configuration_tokens(id, config) :: {:ok, list(map())} | error
  def get_connection_scim_configuration_tokens(id, %Config{} = config) do
    Connections.get_scim_configuration_tokens(id, config)
  end

  @doc """
  Create a scim token for a scim client.

  ## see
  https://auth0.com/docs/api/management/v2/connections/post-scim-token

  """
  @spec create_connection_scim_configuration_tokens(id, map(), config) ::
          {:ok, map()} | error
  def create_connection_scim_configuration_tokens(id, %{} = params, %Config{} = config) do
    Connections.create_scim_configuration_tokens(id, params, config)
  end

  @doc """
  Deletes a scim token by its connection id and tokenId.

  ## see
  https://auth0.com/docs/api/management/v2/connections/delete-tokens-by-token-id

  """
  @spec delete_connection_scim_configuration_tokens(id, token_id, config) ::
          {:ok, String.t()} | error
  def delete_connection_scim_configuration_tokens(id, token_id, %Config{} = config) do
    Connections.delete_scim_configuration_tokens(id, token_id, config)
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

  ## query parameters
  - `email` (required)

  ## see
  https://auth0.com/docs/api/management/v2/connections/delete-users-by-email

  """
  @spec delete_connection_users(id, map(), config) ::
          {:ok, String.t()} | error
  def delete_connection_users(id, %{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Connections.delete_users(id, params, config)
  end

  @doc """
  Get a list of directory provisioning configurations.

  Retrieve a list of directory provisioning configurations of a tenant.

  ## query parameters
  - `from`
  - `take`

  ## see
  https://auth0.com/docs/api/management/v2/connections-directory-provisionings/get-connections-directory-provisionings

  """
  @spec get_connections_directory_provisionings(map(), config) :: {:ok, map()} | error
  def get_connections_directory_provisionings(
        %{} = params \\ %{},
        %Config{} = config \\ %Config{}
      ) do
    Connections.list_directory_provisionings(params, config)
  end

  @doc """
  Get a list of SCIM configurations.

  Retrieve a list of SCIM configurations of a tenant.

  ## query parameters
  - `from`
  - `take`

  ## see
  https://auth0.com/docs/api/management/v2/connections-scim-configurations/get-connections-scim-configurations

  """
  @spec get_connections_scim_configurations(map(), config) :: {:ok, map()} | error
  def get_connections_scim_configurations(%{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Connections.list_scim_configurations(params, config)
  end

  @doc """
  Get enabled clients for a connection.

  Retrieve all clients that have the specified [connection](https://auth0.com/docs/authenticate/identity-providers) enabled.

  ## query parameters
  - `take`
  - `from`

  Path parameters are percent-encoded before they are placed in the request path.

  ## see
  https://auth0.com/docs/api/management/v2/connections/get-connection-clients

  """
  @spec get_connection_clients(String.t(), map(), config) :: {:ok, map()} | error
  def get_connection_clients(id, %{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Connections.get_clients(id, params, config)
  end

  @doc """
  Update enabled clients for a connection.

  Path parameters are percent-encoded before they are placed in the request path.

  ## see
  https://auth0.com/docs/api/management/v2/connections/patch-clients

  """
  @spec update_connection_clients(String.t(), list(map()), config) :: {:ok, String.t()} | error
  def update_connection_clients(id, params, %Config{} = config \\ %Config{})
      when is_list(params) do
    Connections.update_clients(id, params, config)
  end

  @doc """
  Get a directory provisioning configuration.

  Retrieve the directory provisioning configuration of a connection.

  Path parameters are percent-encoded before they are placed in the request path.

  ## see
  https://auth0.com/docs/api/management/v2/connections/get-directory-provisioning

  """
  @spec get_connection_directory_provisioning(String.t(), config) :: {:ok, map()} | error
  def get_connection_directory_provisioning(id, %Config{} = config \\ %Config{}) do
    Connections.get_directory_provisioning(id, config)
  end

  @doc """
  Create a directory provisioning configuration.

  Create a directory provisioning configuration for a connection.

  Path parameters are percent-encoded before they are placed in the request path.

  ## see
  https://auth0.com/docs/api/management/v2/connections/post-directory-provisioning

  """
  @spec create_connection_directory_provisioning(String.t(), map(), config) ::
          {:ok, map()} | error
  def create_connection_directory_provisioning(
        id,
        %{} = params \\ %{},
        %Config{} = config \\ %Config{}
      ) do
    Connections.create_directory_provisioning(id, params, config)
  end

  @doc """
  Patch a directory provisioning configuration.

  Update the directory provisioning configuration of a connection.

  Path parameters are percent-encoded before they are placed in the request path.

  ## see
  https://auth0.com/docs/api/management/v2/connections/patch-directory-provisioning

  """
  @spec update_connection_directory_provisioning(String.t(), map(), config) ::
          {:ok, map()} | error
  def update_connection_directory_provisioning(
        id,
        %{} = params \\ %{},
        %Config{} = config \\ %Config{}
      ) do
    Connections.update_directory_provisioning(id, params, config)
  end

  @doc """
  Delete a directory provisioning configuration.

  Delete the directory provisioning configuration of a connection.

  Path parameters are percent-encoded before they are placed in the request path.

  ## see
  https://auth0.com/docs/api/management/v2/connections/delete-directory-provisioning

  """
  @spec delete_connection_directory_provisioning(String.t(), config) :: {:ok, String.t()} | error
  def delete_connection_directory_provisioning(id, %Config{} = config \\ %Config{}) do
    Connections.delete_directory_provisioning(id, config)
  end

  @doc """
  Get a connection's default directory provisioning attribute mapping.

  Retrieve the directory provisioning default attribute mapping of a connection.

  Path parameters are percent-encoded before they are placed in the request path.

  ## see
  https://auth0.com/docs/api/management/v2/connections/get-directory-provisioning-default-mapping

  """
  @spec get_connection_directory_provisioning_default_mapping(String.t(), config) ::
          {:ok, map()} | error
  def get_connection_directory_provisioning_default_mapping(id, %Config{} = config \\ %Config{}) do
    Connections.get_directory_provisioning_default_mapping(id, config)
  end

  @doc """
  Request an on-demand synchronization of the directory.

  Path parameters are percent-encoded before they are placed in the request path.

  ## see
  https://auth0.com/docs/api/management/v2/connections/post-synchronizations

  """
  @spec create_connection_directory_provisioning_synchronization(String.t(), config) ::
          {:ok, map()} | error
  def create_connection_directory_provisioning_synchronization(
        id,
        %Config{} = config \\ %Config{}
      ) do
    Connections.create_directory_provisioning_synchronization(id, config)
  end

  @doc """
  Get synchronized groups for a directory provisioning configuration.

  Retrieve the configured synchronized groups for a connection directory provisioning configuration.

  ## query parameters
  - `from`
  - `take`
  - `q`

  Path parameters are percent-encoded before they are placed in the request path.

  ## see
  https://auth0.com/docs/api/management/v2/connections/get-synchronized-groups

  """
  @spec get_connection_directory_provisioning_synchronized_groups(String.t(), map(), config) ::
          {:ok, map()} | error
  def get_connection_directory_provisioning_synchronized_groups(
        id,
        %{} = params \\ %{},
        %Config{} = config \\ %Config{}
      ) do
    Connections.list_directory_provisioning_synchronized_groups(id, params, config)
  end

  @doc """
  Add synchronized group selections to a directory provisioning configuration.

  Path parameters are percent-encoded before they are placed in the request path.

  ## see
  https://auth0.com/docs/api/management/v2/connections/post-synchronized-groups

  """
  @spec add_connection_directory_provisioning_synchronized_groups(String.t(), map(), config) ::
          {:ok, String.t()} | error
  def add_connection_directory_provisioning_synchronized_groups(
        id,
        %{} = params \\ %{},
        %Config{} = config \\ %Config{}
      ) do
    Connections.add_directory_provisioning_synchronized_groups(id, params, config)
  end

  @doc """
  Create or replace synchronized group selections for a directory provisioning configuration.

  Create or replace the selected groups for a connection directory provisioning configuration.

  Path parameters are percent-encoded before they are placed in the request path.

  ## see
  https://auth0.com/docs/api/management/v2/connections/put-synchronized-groups

  """
  @spec set_connection_directory_provisioning_synchronized_groups(String.t(), map(), config) ::
          {:ok, String.t()} | error
  def set_connection_directory_provisioning_synchronized_groups(
        id,
        %{} = params \\ %{},
        %Config{} = config \\ %Config{}
      ) do
    Connections.set_directory_provisioning_synchronized_groups(id, params, config)
  end

  @doc """
  Delete synchronized group selections for a directory provisioning configuration.

  Path parameters are percent-encoded before they are placed in the request path.

  ## see
  https://auth0.com/docs/api/management/v2/connections/delete-synchronized-groups

  """
  @spec delete_connection_directory_provisioning_synchronized_groups(String.t(), map(), config) ::
          {:ok, String.t()} | error
  def delete_connection_directory_provisioning_synchronized_groups(
        id,
        %{} = params \\ %{},
        %Config{} = config \\ %Config{}
      ) do
    Connections.delete_directory_provisioning_synchronized_groups(id, params, config)
  end

  @doc """
  Get connection keys.

  Gets the connection keys for the Okta or OIDC connection strategy.

  Path parameters are percent-encoded before they are placed in the request path.

  ## see
  https://auth0.com/docs/api/management/v2/connections/get-keys

  """
  @spec get_connection_keys(String.t(), config) :: {:ok, list(map())} | error
  def get_connection_keys(id, %Config{} = config \\ %Config{}) do
    Connections.get_keys(id, config)
  end

  @doc """
  Create connection keys.

  Provision initial connection keys for Okta or OIDC connection strategies. This endpoint allows you to create keys before configuring the connection to use Private Key JWT authentication, enabling zero-downtime transitions.

  Path parameters are percent-encoded before they are placed in the request path.

  ## see
  https://auth0.com/docs/api/management/v2/connections/post-keys

  """
  @spec create_connection_keys(String.t(), map(), config) :: {:ok, list(map())} | error
  def create_connection_keys(id, %{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Connections.create_keys(id, params, config)
  end

  @doc """
  Rotate connection keys.

  Rotates the connection keys for the Okta or OIDC connection strategies.

  Path parameters are percent-encoded before they are placed in the request path.

  ## see
  https://auth0.com/docs/api/management/v2/connections/post-rotate

  """
  @spec rotate_connection_keys(String.t(), map(), config) :: {:ok, map()} | error
  def rotate_connection_keys(id, %{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Connections.rotate_keys(id, params, config)
  end

  @doc """
  Retrieve details on custom domains.

  ## query parameters
  - `take`
  - `from`
  - `q`
  - `fields`
  - `include_fields`
  - `sort`

  Query parameters can be passed as a map: `get_custom_domain_configurations(params)` or
  `get_custom_domain_configurations(params, config)`.

  ## see
  https://auth0.com/docs/api/management/v2/custom-domains/get-custom-domains

  """
  @spec get_custom_domain_configurations(config | map()) ::
          {:ok, list(map())} | error
  def get_custom_domain_configurations(config_or_params \\ %Config{})

  def get_custom_domain_configurations(%Config{} = config) do
    CustomDomains.list(%{}, config)
  end

  def get_custom_domain_configurations(%{} = params) do
    CustomDomains.list(params, %Config{})
  end

  @spec get_custom_domain_configurations(map(), config) ::
          {:ok, list(map())} | error
  def get_custom_domain_configurations(%{} = params, %Config{} = config) do
    CustomDomains.list(params, config)
  end

  @doc """
  Create a new custom domain.

  ## see
  https://auth0.com/docs/api/management/v2/custom-domains/post-custom-domains

  """
  @spec configure_custom_domain(map(), config) ::
          {:ok, map()} | error
  def configure_custom_domain(%{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    CustomDomains.configure(params, config)
  end

  @doc """
  Get custom domain configuration.

  ## see
  https://auth0.com/docs/api/management/v2/custom-domains/get-custom-domains-by-id

  """
  @spec get_custom_domain_configuration(id, config) ::
          {:ok, map()} | error
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
  @spec update_custom_domain_configuration(id, map(), config) ::
          {:ok, map()} | error
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
          {:ok, map()} | error
  def verify_custom_domain(id, %Config{} = config \\ %Config{}) do
    CustomDomains.verify(id, config)
  end

  @doc """
  Get the default domain.

  Retrieve the tenant's default domain.

  ## see
  https://auth0.com/docs/api/management/v2/custom-domains/get-default

  """
  @spec get_default_custom_domain(config) :: {:ok, map() | list(map())} | error
  def get_default_custom_domain(%Config{} = config \\ %Config{}) do
    CustomDomains.get_default(config)
  end

  @doc """
  Update the default custom domain for the tenant.

  Set the default custom domain for the tenant.

  ## see
  https://auth0.com/docs/api/management/v2/custom-domains/patch-default

  """
  @spec set_default_custom_domain(map(), config) :: {:ok, map() | list(map())} | error
  def set_default_custom_domain(%{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    CustomDomains.set_default(params, config)
  end

  @doc """
  Test a custom domain.

  Run the test process on a custom domain.

  Path parameters are percent-encoded before they are placed in the request path.

  ## see
  https://auth0.com/docs/api/management/v2/custom-domains/post-test-domain

  """
  @spec test_custom_domain(String.t(), config) :: {:ok, map()} | error
  def test_custom_domain(id, %Config{} = config \\ %Config{}) do
    CustomDomains.test(id, config)
  end

  @doc """
  Retrieve device credential information (public_key, refresh_token, or rotating_refresh_token) associated with a specific user.

  ## query parameters
  - `page`
  - `per_page`
  - `include_totals`
  - `fields`
  - `include_fields`
  - `user_id`
  - `client_id`
  - `type`

  ## see
  https://auth0.com/docs/api/management/v2/device-credentials/get-device-credentials

  """
  @spec get_device_credentials(map(), config) ::
          {:ok, list(map())} | error
  def get_device_credentials(%{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    DeviceCredentials.list(params, config)
  end

  @doc """
  Create a device credential public key to manage refresh token rotation for a given user_id. Device Credentials APIs are designed for ad-hoc administrative use only and paging is by default enabled for GET requests.

  ## see
  https://auth0.com/docs/api/management/v2/device-credentials/post-device-credentials

  """
  @spec create_device_credential(map(), config) ::
          {:ok, map()} | error
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
  Create an email template.

  ## see
  https://auth0.com/docs/api/management/v2/email-templates/post-email-templates

  """
  @spec create_email_template(map(), config) ::
          {:ok, map()} | error
  def create_email_template(%{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    EmailTemplates.create(params, config)
  end

  @doc """
  Retrieve an email template by pre-defined name. These names are verify_email, verify_email_by_code, reset_email, welcome_email, blocked_account, stolen_credentials, enrollment_email, mfa_oob_code, and user_invitation. The names change_password, and password_reset are also supported for legacy scenarios.

  ## see
  https://auth0.com/docs/api/management/v2/email-templates/get-email-templates-by-template-name

  """
  @spec get_email_template(template_name, config) ::
          {:ok, map()} | error
  def get_email_template(template_name, %Config{} = config \\ %Config{}) do
    EmailTemplates.get(template_name, config)
  end

  @doc """
  Modify an email template.

  ## see
  https://auth0.com/docs/api/management/v2/email-templates/patch-email-templates-by-template-name

  """
  @spec patch_email_template(template_name, map(), config) ::
          {:ok, map()} | error
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
  @spec update_email_template(template_name, map(), config) ::
          {:ok, map()} | error
  def update_email_template(
        template_name,
        %{} = params \\ %{},
        %Config{} = config \\ %Config{}
      ) do
    EmailTemplates.update(template_name, params, config)
  end

  @doc """
  Retrieve details of the email provider configuration in your tenant. A list of fields to include or exclude may also be specified.

  ## query parameters
  - `fields`
  - `include_fields`

  ## see
  https://auth0.com/docs/api/management/v2/emails/get-provider

  """
  @spec get_email_provider(map(), config) ::
          {:ok, map()} | error
  def get_email_provider(%{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Emails.get_provider(params, config)
  end

  @doc """
  Update an email provider. The credentials object requires different properties depending on the email provider (which is specified using the name property):

  ## see
  https://auth0.com/docs/api/management/v2/emails/patch-provider

  """
  @spec update_email_provider(map(), config) ::
          {:ok, map()} | error
  def update_email_provider(%{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Emails.update_provider(params, config)
  end

  @doc """
  Create an email provider. The credentials object requires different properties depending on the email provider (which is specified using the name property):

  ## see
  https://auth0.com/docs/api/management/v2/emails/post-provider

  """
  @spec configure_email_provider(map(), config) ::
          {:ok, map()} | error
  def configure_email_provider(%{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Emails.configure_provider(params, config)
  end

  @doc """
  Delete email provider.

  Delete the email provider.

  ## see
  https://auth0.com/docs/api/management/v2/emails/delete-provider

  """
  @spec delete_email_provider(config) :: {:ok, String.t()} | error
  def delete_email_provider(%Config{} = config \\ %Config{}) do
    Emails.delete_provider(config)
  end

  @doc """
  Retrieve all event streams.

  ## query parameters
  - `from`
  - `take`

  ## see
  https://auth0.com/docs/api/management/v2/event-streams/get-event-streams
  """
  @spec get_event_streams(map(), config) :: {:ok, list(map())} | error
  def get_event_streams(%{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    EventStreams.list(params, config)
  end

  @doc """
  Create an event stream.

  ## see
  https://auth0.com/docs/api/management/v2/event-streams/post-event-streams
  """
  @spec create_event_stream(map(), config) :: {:ok, map()} | error
  def create_event_stream(%{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    EventStreams.create(params, config)
  end

  @doc """
  Retrieve an event stream by its ID.

  ## see
  https://auth0.com/docs/api/management/v2/event-streams/get-event-streams-by-id
  """
  @spec get_event_stream(id, config) :: {:ok, map()} | error
  def get_event_stream(id, %Config{} = config \\ %Config{}) do
    EventStreams.get(id, config)
  end

  @doc """
  Delete an event stream.

  ## see
  https://auth0.com/docs/api/management/v2/event-streams/delete-event-streams-by-id
  """
  @spec delete_event_stream(id, config) :: {:ok, String.t()} | error
  def delete_event_stream(id, %Config{} = config \\ %Config{}) do
    EventStreams.delete(id, config)
  end

  @doc """
  Update an event stream.

  ## see
  https://auth0.com/docs/api/management/v2/event-streams/patch-event-streams-by-id
  """
  @spec update_event_stream(id, map(), config) :: {:ok, map()} | error
  def update_event_stream(id, %{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    EventStreams.update(id, params, config)
  end

  @doc """
  Get this event stream's delivery history.

  ## query parameters
  - `statuses`
  - `event_types`
  - `date_from`
  - `date_to`
  - `from`
  - `take`

  Path parameters are percent-encoded before they are placed in the request path.

  ## see
  https://auth0.com/docs/api/management/v2/event-streams/get-event-deliveries

  """
  @spec get_event_stream_deliveries(String.t(), map(), config) :: {:ok, map()} | error
  def get_event_stream_deliveries(id, %{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    EventStreams.list_deliveries(id, params, config)
  end

  @doc """
  Get a specific event's delivery history.

  Path parameters are percent-encoded before they are placed in the request path.

  ## see
  https://auth0.com/docs/api/management/v2/event-streams/get-deliveries-by-event-id

  """
  @spec get_event_stream_delivery(String.t(), String.t(), config) :: {:ok, map()} | error
  def get_event_stream_delivery(id, event_id, %Config{} = config \\ %Config{}) do
    EventStreams.get_delivery(id, event_id, config)
  end

  @doc """
  Redeliver failed events.

  Path parameters are percent-encoded before they are placed in the request path.

  ## see
  https://auth0.com/docs/api/management/v2/event-streams/post-redeliver

  """
  @spec redeliver_event_stream_events(String.t(), map(), config) :: {:ok, map()} | error
  def redeliver_event_stream_events(id, %{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    EventStreams.redeliver(id, params, config)
  end

  @doc """
  Redeliver a single failed event by ID.

  Path parameters are percent-encoded before they are placed in the request path.

  ## see
  https://auth0.com/docs/api/management/v2/event-streams/post-redeliver-by-event-id

  """
  @spec redeliver_event_stream_event(String.t(), String.t(), config) :: {:ok, String.t()} | error
  def redeliver_event_stream_event(id, event_id, %Config{} = config \\ %Config{}) do
    EventStreams.redeliver_by_id(id, event_id, config)
  end

  @doc """
  Send a test event to an event stream.

  Path parameters are percent-encoded before they are placed in the request path.

  ## see
  https://auth0.com/docs/api/management/v2/event-streams/post-test-event

  """
  @spec test_event_stream(String.t(), map(), config) :: {:ok, map()} | error
  def test_event_stream(id, %{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    EventStreams.test(id, params, config)
  end

  @doc """
  Get flows.

  ## query parameters
  - `page`
  - `per_page`
  - `include_totals`
  - `hydrate` (array: pass a list such as `["a", "b"]` to send multiple values; it is sent as repeated `hydrate=` keys)
  - `synchronous`

  ## see
  https://auth0.com/docs/api/management/v2/flows/get-flows

  """
  @spec get_flows(map(), config) ::
          {:ok, map()} | error
  def get_flows(%{} = params, %Config{} = config) do
    Flows.list(params, config)
  end

  @doc """
  Create a flow.

  ## see
  https://auth0.com/docs/api/management/v2/flows/post-flows

  """
  @spec create_flow(map(), config) ::
          {:ok, map()} | error
  def create_flow(%{} = params, %Config{} = config) do
    Flows.create(params, config)
  end

  @doc """
  Get a flow.

  ## query parameters
  - `hydrate` (array: pass a list such as `["a", "b"]` to send multiple values; it is sent as repeated `hydrate=` keys)

  ## see
  https://auth0.com/docs/api/management/v2/flows/get-flows-by-id

  """
  @spec get_flow(id, map(), config) ::
          {:ok, map()} | error
  def get_flow(id, %{} = params, %Config{} = config) do
    Flows.get(id, params, config)
  end

  @doc """
  Update a flow.

  ## see
  https://auth0.com/docs/api/management/v2/flows/patch-flows-by-id

  """
  @spec update_flow(id, map(), config) ::
          {:ok, map()} | error
  def update_flow(id, %{} = params, %Config{} = config) do
    Flows.update(id, params, config)
  end

  @doc """
  Get Flows Vault connection list.

  ## query parameters
  - `page`
  - `per_page`
  - `include_totals`

  ## see
  https://auth0.com/docs/api/management/v2/flows/get-flows-vault-connections

  """
  @spec get_flows_vault_connections(map(), config) :: {:ok, map() | list(map())} | error
  def get_flows_vault_connections(%{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Flows.list_vault_connections(params, config)
  end

  @doc """
  Create a Flows Vault connection.

  ## see
  https://auth0.com/docs/api/management/v2/flows/post-flows-vault-connections

  """
  @spec create_flows_vault_connection(map(), config) :: {:ok, map()} | error
  def create_flows_vault_connection(%{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Flows.create_vault_connection(params, config)
  end

  @doc """
  Get a Flows Vault connection.

  Path parameters are percent-encoded before they are placed in the request path.

  ## see
  https://auth0.com/docs/api/management/v2/flows/get-flows-vault-connections-by-id

  """
  @spec get_flows_vault_connection(String.t(), config) :: {:ok, map()} | error
  def get_flows_vault_connection(id, %Config{} = config \\ %Config{}) do
    Flows.get_vault_connection(id, config)
  end

  @doc """
  Update a Flows Vault connection.

  Path parameters are percent-encoded before they are placed in the request path.

  ## see
  https://auth0.com/docs/api/management/v2/flows/patch-flows-vault-connections-by-id

  """
  @spec update_flows_vault_connection(String.t(), map(), config) :: {:ok, map()} | error
  def update_flows_vault_connection(id, %{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Flows.update_vault_connection(id, params, config)
  end

  @doc """
  Delete a Flows Vault connection.

  Path parameters are percent-encoded before they are placed in the request path.

  ## see
  https://auth0.com/docs/api/management/v2/flows/delete-flows-vault-connections-by-id

  """
  @spec delete_flows_vault_connection(String.t(), config) :: {:ok, String.t()} | error
  def delete_flows_vault_connection(id, %Config{} = config \\ %Config{}) do
    Flows.delete_vault_connection(id, config)
  end

  @doc """
  Get flow executions.

  ## query parameters
  - `page`
  - `per_page`
  - `include_totals`
  - `from`
  - `take`

  Path parameters are percent-encoded before they are placed in the request path.

  ## see
  https://auth0.com/docs/api/management/v2/flows/get-flows-executions

  """
  @spec get_flow_executions(String.t(), map(), config) :: {:ok, map() | list(map())} | error
  def get_flow_executions(flow_id, %{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Flows.list_executions(flow_id, params, config)
  end

  @doc """
  Get a flow execution.

  ## query parameters
  - `hydrate` (array: pass a list such as `["a", "b"]` to send multiple values; it is sent as repeated `hydrate=` keys)

  Path parameters are percent-encoded before they are placed in the request path.

  ## see
  https://auth0.com/docs/api/management/v2/flows/get-flows-executions-by-execution-id

  """
  @spec get_flow_execution(String.t(), String.t(), map(), config) :: {:ok, map()} | error
  def get_flow_execution(
        flow_id,
        execution_id,
        %{} = params \\ %{},
        %Config{} = config \\ %Config{}
      ) do
    Flows.get_execution(flow_id, execution_id, params, config)
  end

  @doc """
  Delete a flow execution.

  Path parameters are percent-encoded before they are placed in the request path.

  ## see
  https://auth0.com/docs/api/management/v2/flows/delete-flows-executions-by-execution-id

  """
  @spec delete_flow_execution(String.t(), String.t(), config) :: {:ok, String.t()} | error
  def delete_flow_execution(flow_id, execution_id, %Config{} = config \\ %Config{}) do
    Flows.delete_execution(flow_id, execution_id, config)
  end

  @doc """
  Delete a flow.

  Path parameters are percent-encoded before they are placed in the request path.

  ## see
  https://auth0.com/docs/api/management/v2/flows/delete-flows-by-id

  """
  @spec delete_flow(String.t(), config) :: {:ok, String.t()} | error
  def delete_flow(id, %Config{} = config \\ %Config{}) do
    Flows.delete(id, config)
  end

  @doc """
  Get forms.

  ## query parameters
  - `page`
  - `per_page`
  - `include_totals`
  - `hydrate` (array: pass a list such as `["a", "b"]` to send multiple values; it is sent as repeated `hydrate=` keys)

  ## see
  https://auth0.com/docs/api/management/v2/forms/get-forms

  """
  @spec get_forms(map(), config) ::
          {:ok, map()} | error
  def get_forms(%{} = params, %Config{} = config) do
    Forms.list(params, config)
  end

  @doc """
  Create a form.

  ## see
  https://auth0.com/docs/api/management/v2/forms/post-forms

  """
  @spec create_form(map(), config) ::
          {:ok, map()} | error
  def create_form(%{} = params, %Config{} = config) do
    Forms.create(params, config)
  end

  @doc """
  Get a form.

  ## query parameters
  - `hydrate` (array: pass a list such as `["a", "b"]` to send multiple values; it is sent as repeated `hydrate=` keys)

  ## see
  https://auth0.com/docs/api/management/v2/forms/get-forms-by-id

  """
  @spec get_form(id, map(), config) ::
          {:ok, map()} | error
  def get_form(id, %{} = params, %Config{} = config) do
    Forms.get(id, params, config)
  end

  @doc """
  Update a form.

  ## see
  https://auth0.com/docs/api/management/v2/forms/patch-forms-by-id

  """
  @spec update_form(id, map(), config) ::
          {:ok, map()} | error
  def update_form(id, %{} = params, %Config{} = config) do
    Forms.update(id, params, config)
  end

  @doc """
  Delete a form.

  Path parameters are percent-encoded before they are placed in the request path.

  ## see
  https://auth0.com/docs/api/management/v2/forms/delete-form

  """
  @spec delete_form(String.t(), config) :: {:ok, String.t()} | error
  def delete_form(id, %Config{} = config \\ %Config{}) do
    Forms.delete(id, config)
  end

  @doc """
  Retrieve the grants associated with your account.

  ## query parameters
  - `per_page`
  - `page`
  - `include_totals`
  - `user_id`
  - `client_id`
  - `audience`

  ## see
  https://auth0.com/docs/api/management/v2/grants/get-grants

  """
  @spec get_grants(map(), config) ::
          {:ok, list(map()) | map()} | error
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

  ## query parameters
  - `user_id` (required)

  ## see
  https://auth0.com/docs/api/management/v2/grants/delete-grants-by-user-id

  """
  @spec delete_grant_by_user_id(map(), config) :: {:ok, String.t()} | error
  def delete_grant_by_user_id(%{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Grants.delete_by_user_id(params, config)
  end

  @doc """
  Get all Groups.

  List all groups in your tenant.

  ## query parameters
  - `connection_id`
  - `name`
  - `external_id`
  - `search`
  - `fields`
  - `include_fields`
  - `page`
  - `per_page`
  - `include_totals`
  - `from`
  - `take`

  ## see
  https://auth0.com/docs/api/management/v2/groups/get-groups

  """
  @spec get_groups(map(), config) :: {:ok, map() | list(map())} | error
  def get_groups(%{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Groups.list(params, config)
  end

  @doc """
  Get a Group.

  Retrieve a group by its ID.

  Path parameters are percent-encoded before they are placed in the request path.

  ## see
  https://auth0.com/docs/api/management/v2/groups/get-group

  """
  @spec get_group(String.t(), config) :: {:ok, map()} | error
  def get_group(id, %Config{} = config \\ %Config{}) do
    Groups.get(id, config)
  end

  @doc """
  Delete a Group.

  Delete a group by its ID.

  Path parameters are percent-encoded before they are placed in the request path.

  ## see
  https://auth0.com/docs/api/management/v2/groups/delete-group

  """
  @spec delete_group(String.t(), config) :: {:ok, String.t()} | error
  def delete_group(id, %Config{} = config \\ %Config{}) do
    Groups.delete(id, config)
  end

  @doc """
  Get Group Members.

  List all users that are a member of this group.

  ## query parameters
  - `fields`
  - `include_fields`
  - `from`
  - `take`

  Path parameters are percent-encoded before they are placed in the request path.

  ## see
  https://auth0.com/docs/api/management/v2/groups/get-group-members

  """
  @spec get_group_members(String.t(), map(), config) :: {:ok, map()} | error
  def get_group_members(id, %{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Groups.list_members(id, params, config)
  end

  @doc """
  Get a group's roles.

  Lists the [roles](https://auth0.com/docs/manage-users/access-control/rbac) assigned to a group.

  ## query parameters
  - `from`
  - `take`

  Path parameters are percent-encoded before they are placed in the request path.

  ## see
  https://auth0.com/docs/api/management/v2/groups/get-group-roles

  """
  @spec get_group_roles(String.t(), map(), config) :: {:ok, map()} | error
  def get_group_roles(id, %{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Groups.list_roles(id, params, config)
  end

  @doc """
  Assign roles to a group.

  Assign one or more [roles](https://auth0.com/docs/manage-users/access-control/rbac) to a specified group.

  Path parameters are percent-encoded before they are placed in the request path.

  ## see
  https://auth0.com/docs/api/management/v2/groups/post-group-roles

  """
  @spec assign_group_roles(String.t(), map(), config) :: {:ok, String.t()} | error
  def assign_group_roles(id, %{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Groups.assign_roles(id, params, config)
  end

  @doc """
  Remove roles from a group.

  Unassign one or more [roles](https://auth0.com/docs/manage-users/access-control/rbac) from a specified group.

  Path parameters are percent-encoded before they are placed in the request path.

  ## see
  https://auth0.com/docs/api/management/v2/groups/delete-group-roles

  """
  @spec remove_group_roles(String.t(), map(), config) :: {:ok, String.t()} | error
  def remove_group_roles(id, %{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Groups.remove_roles(id, params, config)
  end

  @doc """
  Create a multi-factor authentication (MFA) enrollment ticket, and optionally send an email with the created ticket, to a given user.

  ## options
  - `:custom_domain` - sent as the `auth0-custom-domain` header so that Auth0 uses
    this custom domain (host name, optionally with a port) for links it generates.
    An invalid value raises `ArgumentError`.

  ## see
  https://auth0.com/docs/api/management/v2/guardian/post-ticket

  """
  @spec create_guardian_enrollment_ticket(map(), config, request_opts) ::
          {:ok, map()} | error
  def create_guardian_enrollment_ticket(
        %{} = params \\ %{},
        %Config{} = config \\ %Config{},
        opts \\ []
      ) do
    Guardian.create_enrollment_ticket(params, config, opts)
  end

  @doc """
  Retrieve details, such as status and type, for a specific multi-factor authentication enrollment registered to a user account.

  ## see
  https://auth0.com/docs/api/management/v2/guardian/get-enrollments-by-id

  """
  @spec get_guardian_enrollment(id, config) ::
          {:ok, map()} | error
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
  Retrieve details of all multi-factor authentication factors associated with your tenant.

  ## see
  https://auth0.com/docs/api/management/v2/guardian/get-factors

  """
  @spec get_guardian_factors(config) ::
          {:ok, list(map())} | error
  def get_guardian_factors(%Config{} = config \\ %Config{}) do
    Guardian.list_factors(config)
  end

  @doc """
  Retrieve list of phone-type MFA factors (i.e., sms and voice) that are enabled for your tenant.

  ## see
  https://auth0.com/docs/api/management/v2/guardian/get-message-types

  """
  @spec get_guardian_phone_factor(config) ::
          {:ok, map()} | error
  def get_guardian_phone_factor(%Config{} = config \\ %Config{}) do
    Guardian.get_phone_factor(config)
  end

  @doc """
  Replace the list of phone-type MFA factors (i.e., sms and voice) that are enabled for your tenant.

  ## see
  https://auth0.com/docs/api/management/v2/guardian/put-message-types

  """
  @spec update_guardian_phone_factor(map(), config) ::
          {:ok, map()} | error
  def update_guardian_phone_factor(
        %{} = params \\ %{},
        %Config{} = config \\ %Config{}
      ) do
    Guardian.update_phone_factor(params, config)
  end

  @doc """
  Retrieve configuration details for a Twilio phone provider that has been set up in your tenant.

  ## see
  https://auth0.com/docs/api/management/v2/guardian/get-phone-twilio-factor-provider

  """
  @spec get_guardian_twilio_phone_configuration(config) ::
          {:ok, map()} | error
  def get_guardian_twilio_phone_configuration(%Config{} = config \\ %Config{}) do
    Guardian.get_twilio_phone_configuration(config)
  end

  @doc """
  Update the configuration of a Twilio phone provider that has been set up in your tenant.

  ## see
  https://auth0.com/docs/api/management/v2/guardian/put-twilio

  """
  @spec update_guardian_twilio_phone_configuration(
          map(),
          config
        ) ::
          {:ok, map()} | error
  def update_guardian_twilio_phone_configuration(
        %{} = params \\ %{},
        %Config{} = config \\ %Config{}
      ) do
    Guardian.update_twilio_phone_configuration(params, config)
  end

  @doc """
  Retrieve details of the multi-factor authentication phone provider configured for your tenant.

  ## see
  https://auth0.com/docs/api/management/v2/guardian/get-guardian-phone-providers

  """
  @spec get_guardian_phone_configuration(config) ::
          {:ok, map()} | error
  def get_guardian_phone_configuration(%Config{} = config \\ %Config{}) do
    Guardian.get_phone_configuration(config)
  end

  @doc """
  Update phone provider configuration

  ## see
  https://auth0.com/docs/api/management/v2/guardian/put-phone-providers

  """
  @spec update_guardian_phone_configuration(map(), config) ::
          {:ok, map()} | error
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
          {:ok, map()} | error
  def get_guardian_phone_template(%Config{} = config \\ %Config{}) do
    Guardian.get_phone_template(config)
  end

  @doc """
  Customize the messages sent to complete phone enrollment and verification (subscription required).

  ## see
  https://auth0.com/docs/api/management/v2/guardian/put-factor-phone-templates

  """
  @spec update_guardian_phone_template(map(), config) ::
          {:ok, map()} | error
  def update_guardian_phone_template(
        %{} = params \\ %{},
        %Config{} = config \\ %Config{}
      ) do
    Guardian.update_phone_template(params, config)
  end

  @doc """
  Retrieve configuration details for the multi-factor authentication APNS provider associated with your tenant.

  ## see
  https://auth0.com/docs/api/management/v2/guardian/get-apns

  """
  @spec get_guardian_apns_configuration(config) ::
          {:ok, map()} | error
  def get_guardian_apns_configuration(%Config{} = config) do
    Guardian.get_apns_configuration(config)
  end

  @doc """
  Modify configuration details of the multi-factor authentication APNS provider associated with your tenant.

  ## see
  https://auth0.com/docs/api/management/v2/guardian/patch-apns

  """
  @spec patch_guardian_apns_configuration(map(), config) ::
          {:ok, map()} | error
  def patch_guardian_apns_configuration(
        %{} = params,
        %Config{} = config
      ) do
    Guardian.patch_apns_configuration(params, config)
  end

  @doc """
  Overwrite all configuration details of the multi-factor authentication APNS provider associated with your tenant.

  ## see
  https://auth0.com/docs/api/management/v2/guardian/put-apns

  """
  @spec update_guardian_apns_configuration(map(), config) ::
          {:ok, map()} | error
  def update_guardian_apns_configuration(
        %{} = params,
        %Config{} = config
      ) do
    Guardian.update_apns_configuration(params, config)
  end

  @doc """
  Modify configuration details of the multi-factor authentication FCM provider associated with your tenant.

  ## see
  https://auth0.com/docs/api/management/v2/guardian/patch-fcm

  """
  @spec patch_guardian_fcm_configuration(map(), config) ::
          {:ok, map()} | error
  def patch_guardian_fcm_configuration(
        %{} = params,
        %Config{} = config
      ) do
    Guardian.patch_fcm_configuration(params, config)
  end

  @doc """
  Overwrite all configuration details of the multi-factor authentication FCM provider associated with your tenant.

  ## see
  https://auth0.com/docs/api/management/v2/guardian/put-fcm

  """
  @spec update_guardian_fcm_configuration(map(), config) ::
          {:ok, map()} | error
  def update_guardian_fcm_configuration(
        %{} = params,
        %Config{} = config
      ) do
    Guardian.update_fcm_configuration(params, config)
  end

  @doc """
  Modify configuration details of the multi-factor authentication FCMV1 provider associated with your tenant.

  ## see
  https://auth0.com/docs/api/management/v2/guardian/patch-fcmv-1

  """
  @spec patch_guardian_fcmv1_configuration(map(), config) ::
          {:ok, map()} | error
  def patch_guardian_fcmv1_configuration(
        %{} = params,
        %Config{} = config
      ) do
    Guardian.patch_fcmv1_configuration(params, config)
  end

  @doc """
  Overwrite all configuration details of the multi-factor authentication FCMV1 provider associated with your tenant.

  ## see
  https://auth0.com/docs/api/management/v2/guardian/put-fcmv-1

  """
  @spec update_guardian_fcmv1_configuration(map(), config) ::
          {:ok, map()} | error
  def update_guardian_fcmv1_configuration(
        %{} = params,
        %Config{} = config
      ) do
    Guardian.update_fcmv1_configuration(params, config)
  end

  @doc """
  Retrieve configuration details for an AWS SNS push notification provider that has been enabled for MFA.

  ## see
  https://auth0.com/docs/api/management/v2/guardian/get-sns

  """
  @spec get_guardian_aws_sns_configuration(config) ::
          {:ok, map()} | error
  def get_guardian_aws_sns_configuration(%Config{} = config \\ %Config{}) do
    Guardian.get_aws_sns_configuration(config)
  end

  @doc """
  Configure the AWS SNS push notification provider configuration (subscription required).

  ## see
  https://auth0.com/docs/api/management/v2/guardian/patch-sns

  """
  @spec patch_guardian_aws_sns_configuration(
          map(),
          config
        ) ::
          {:ok, map()} | error
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
          map(),
          config
        ) ::
          {:ok, map()} | error
  def update_guardian_aws_sns_configuration(
        %{} = params \\ %{},
        %Config{} = config \\ %Config{}
      ) do
    Guardian.update_aws_sns_configuration(params, config)
  end

  @doc """
  Retrieve the push notification provider configured for your tenant.

  ## see
  https://auth0.com/docs/api/management/v2/guardian/get-pn-providers

  """
  @spec get_guardian_notification_provider(config) ::
          {:ok, map()} | error
  def get_guardian_notification_provider(%Config{} = config) do
    Guardian.get_notification_provider(config)
  end

  @doc """
  Modify the push notification provider configured for your tenant.

  ## see
  https://auth0.com/docs/api/management/v2/guardian/put-pn-providers

  """
  @spec update_guardian_notification_provider(map(), config) ::
          {:ok, map()} | error
  def update_guardian_notification_provider(
        %{} = params,
        %Config{} = config
      ) do
    Guardian.update_notification_provider(params, config)
  end

  @doc """
  Update the status (i.e., enabled or disabled) of a specific multi-factor authentication factor.

  ## see
  https://auth0.com/docs/api/management/v2/guardian/put-factors-by-name

  """
  @spec update_guardian_factor(name, map(), config) ::
          {:ok, map()} | error
  def update_guardian_factor(name, %{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Guardian.update_factor(name, params, config)
  end

  @doc """
  Retrieve the multi-factor authentication (MFA) policies configured for your tenant.

  ## see
  https://auth0.com/docs/api/management/v2/guardian/get-policies

  """
  @spec list_guardian_policies(config) :: {:ok, list()} | error
  def list_guardian_policies(%Config{} = config \\ %Config{}) do
    Guardian.list_policies(config)
  end

  @doc """
  Set multi-factor authentication (MFA) policies for your tenant.

  ## see
  https://auth0.com/docs/api/management/v2/guardian/put-policies

  """
  @spec set_guardian_policies(map(), config) :: {:ok, list()} | error
  def set_guardian_policies(%{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Guardian.set_policies(params, config)
  end

  @doc """
  Get DUO Configuration.

  Retrieves the DUO account and factor configuration.

  ## see
  https://auth0.com/docs/api/management/v2/guardian/get-factor-duo-settings

  """
  @spec get_guardian_duo_settings(config) :: {:ok, map()} | error
  def get_guardian_duo_settings(%Config{} = config \\ %Config{}) do
    Guardian.get_duo_settings(config)
  end

  @doc """
  Set the DUO Configuration.

  Set the DUO account configuration and other properties specific to this factor.

  ## see
  https://auth0.com/docs/api/management/v2/guardian/put-factor-duo-settings

  """
  @spec update_guardian_duo_settings(map(), config) :: {:ok, map()} | error
  def update_guardian_duo_settings(%{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Guardian.update_duo_settings(params, config)
  end

  @doc """
  Update the DUO Configuration.

  ## see
  https://auth0.com/docs/api/management/v2/guardian/patch-factor-duo-settings

  """
  @spec patch_guardian_duo_settings(map(), config) :: {:ok, map()} | error
  def patch_guardian_duo_settings(%{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Guardian.patch_duo_settings(params, config)
  end

  @doc """
  Get Email Factor Settings.

  TODO: Link this endpoint to relevant documentation when available.

  ## see
  https://auth0.com/docs/api/management/v2/guardian/get-email-factor-settings

  """
  @spec get_guardian_email_settings(config) :: {:ok, map()} | error
  def get_guardian_email_settings(%Config{} = config \\ %Config{}) do
    Guardian.get_email_settings(config)
  end

  @doc """
  Set the Email Factor Settings.

  TODO: Link this endpoint to relevant documentation when available.

  ## see
  https://auth0.com/docs/api/management/v2/guardian/set-email-factor-settings

  """
  @spec update_guardian_email_settings(map(), config) :: {:ok, map()} | error
  def update_guardian_email_settings(%{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Guardian.update_email_settings(params, config)
  end

  @doc """
  Get Phone Factor Settings.

  TODO: Link this endpoint to relevant documentation when available.

  ## see
  https://auth0.com/docs/api/management/v2/guardian/get-phone-factor-settings

  """
  @spec get_guardian_phone_settings(config) :: {:ok, map()} | error
  def get_guardian_phone_settings(%Config{} = config \\ %Config{}) do
    Guardian.get_phone_settings(config)
  end

  @doc """
  Set the Phone Factor Settings.

  TODO: Link this endpoint to relevant documentation when available.

  ## see
  https://auth0.com/docs/api/management/v2/guardian/set-phone-factor-settings

  """
  @spec update_guardian_phone_settings(map(), config) :: {:ok, map()} | error
  def update_guardian_phone_settings(%{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Guardian.update_phone_settings(params, config)
  end

  @doc """
  Get Guardian Settings.

  TODO: Link this endpoint to relevant documentation when available.

  ## see
  https://auth0.com/docs/api/management/v2/guardian/get-guardian-settings

  """
  @spec get_guardian_settings(config) :: {:ok, map()} | error
  def get_guardian_settings(%Config{} = config \\ %Config{}) do
    Guardian.get_settings(config)
  end

  @doc """
  Set the Guardian Settings.

  Update a tenant's guardian settings such as Remember Me

  ## see
  https://auth0.com/docs/api/management/v2/guardian/set-guardian-settings

  """
  @spec update_guardian_settings(map(), config) :: {:ok, map()} | error
  def update_guardian_settings(%{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Guardian.update_settings(params, config)
  end

  @doc """
  Retrieve all hooks. Accepts a list of fields to include or exclude in the result.

  ## query parameters
  - `page`
  - `per_page`
  - `include_totals`
  - `enabled`
  - `fields`
  - `triggerId`

  ## see
  https://auth0.com/docs/api/management/v2/hooks/get-hooks

  """
  @spec get_hooks(map(), config) ::
          {:ok, list(map()) | map()} | error
  def get_hooks(%{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Hooks.list(params, config)
  end

  @doc """
  Create a new hook.

  ## see
  https://auth0.com/docs/api/management/v2/hooks/post-hooks

  """
  @spec create_hook(map(), config) ::
          {:ok, map()} | error
  def create_hook(%{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Hooks.create(params, config)
  end

  @doc """
  Retrieve a hook by its ID. Accepts a list of fields to include in the result.

  ## query parameters
  - `fields`

  ## see
  https://auth0.com/docs/api/management/v2/hooks/get-hooks-by-id

  """
  @spec get_hook(id, map(), config) ::
          {:ok, map()} | error
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
  @spec update_hook(id, map(), config) ::
          {:ok, map()} | error
  def update_hook(id, %{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Hooks.update(id, params, config)
  end

  @doc """
  Retrieve a hook's secrets by the ID of the hook.

  ## see
  https://auth0.com/docs/api/management/v2/hooks/get-secrets

  """
  @spec get_hook_secrets(id, config) ::
          {:ok, map()} | error
  def get_hook_secrets(id, %Config{} = config \\ %Config{}) do
    Hooks.get_secrets(id, config)
  end

  @doc """
  Delete one or more existing secrets for a given hook. Accepts an array of secret names to delete.

  ## see
  https://auth0.com/docs/api/management/v2/hooks/delete-secrets

  """
  # The default `params` (`%{}`) has no required key, so the delete_hook_secrets/1 clause
  # generated by the default argument can never succeed. It is kept only for
  # backward compatibility (no public arity is removed), hence the warning is
  # suppressed for that arity only.
  @dialyzer {:nowarn_function, [{:delete_hook_secrets, 1}]}
  @spec delete_hook_secrets(id, value_params, config) ::
          {:ok, String.t()} | error
  def delete_hook_secrets(id, %{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Hooks.delete_secrets(id, params, config)
  end

  @doc """
  Update an existing hook.

  ## see
  https://auth0.com/docs/api/management/v2/hooks/patch-hooks-by-id

  """
  # The default `params` (`%{}`) has no required key, so the update_hook_secrets/1 clause
  # generated by the default argument can never succeed. It is kept only for
  # backward compatibility (no public arity is removed), hence the warning is
  # suppressed for that arity only.
  @dialyzer {:nowarn_function, [{:update_hook_secrets, 1}]}
  @spec update_hook_secrets(id, value_params, config) ::
          {:ok, map()} | error
  def update_hook_secrets(id, %{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Hooks.update_secrets(id, params, config)
  end

  @doc """
  Add one or more secrets to an existing hook. Accepts an object of key-value pairs, where the key is the name of the secret. A hook can have a maximum of 20 secrets.

  ## see
  https://auth0.com/docs/api/management/v2/hooks/post-secrets

  """
  # The default `params` (`%{}`) has no required key, so the add_hook_secrets/1 clause
  # generated by the default argument can never succeed. It is kept only for
  # backward compatibility (no public arity is removed), hence the warning is
  # suppressed for that arity only.
  @dialyzer {:nowarn_function, [{:add_hook_secrets, 1}]}
  @spec add_hook_secrets(id, value_params, config) ::
          {:ok, map()} | error
  def add_hook_secrets(id, %{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Hooks.add_secrets(id, params, config)
  end

  @doc """
  Export all users to a file via a long-running job.

  ## see
  https://auth0.com/docs/api/management/v2/jobs/post-users-exports

  """
  @spec create_job_users_exports(map(), config) ::
          {:ok, map()} | error
  def create_job_users_exports(%{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Jobs.create_users_exports(params, config)
  end

  @doc """
  Import users from a formatted file into a connection via a long-running job.

  ## see
  https://auth0.com/docs/api/management/v2/jobs/post-users-imports

  """
  @spec create_job_users_imports(map(), config) ::
          {:ok, map()} | error
  def create_job_users_imports(%{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Jobs.create_users_imports(params, config)
  end

  @doc """
  Send an email to the specified user that asks them to click a link to verify their email address.

  ## options
  - `:custom_domain` - sent as the `auth0-custom-domain` header so that Auth0 uses
    this custom domain (host name, optionally with a port) for links it generates.
    An invalid value raises `ArgumentError`.

  ## see
  https://auth0.com/docs/api/management/v2/jobs/post-verification-email

  """
  @spec send_job_verification_email(map(), config, request_opts) ::
          {:ok, map()} | error
  def send_job_verification_email(
        %{} = params \\ %{},
        %Config{} = config \\ %Config{},
        opts \\ []
      ) do
    Jobs.send_verification_email(params, config, opts)
  end

  @doc """
  Retrieves a job. Useful to check its status.

  ## see
  https://auth0.com/docs/api/management/v2/jobs/get-jobs-by-id

  """
  @spec get_job(id, config) :: {:ok, list(map()) | map()} | error
  def get_job(id, %Config{} = config \\ %Config{}) do
    Jobs.get(id, config)
  end

  @doc """
  Retrieve error details of a failed job.

  ## see
  https://auth0.com/docs/api/management/v2/jobs/get-errors

  """
  @spec get_job_error(id, config) ::
          {:ok, list(map()) | map()} | error
  def get_job_error(id, %Config{} = config \\ %Config{}) do
    Jobs.get_error(id, config)
  end

  @doc """
  Retrieve details of all the application signing keys associated with your tenant.

  ## see
  https://auth0.com/docs/api/management/v2/keys/get-signing-keys

  """
  @spec get_signing_keys(config) ::
          {:ok, list(map())} | error
  def get_signing_keys(%Config{} = config \\ %Config{}) do
    Keys.list_signing(config)
  end

  @doc """
  Retrieve details of the application signing key with the given ID.

  ## see
  https://auth0.com/docs/api/management/v2/keys/get-signing-key

  """
  @spec get_signing_key(kid, config) ::
          {:ok, map()} | error
  def get_signing_key(kid, %Config{} = config \\ %Config{}) do
    Keys.get_signing(kid, config)
  end

  @doc """
  Rotate the application signing key of your tenant.

  ## see
  https://auth0.com/docs/api/management/v2/keys/post-signing-keys

  """
  @spec rotate_signing_key(config) ::
          {:ok, map()} | error
  def rotate_signing_key(%Config{} = config \\ %Config{}) do
    Keys.rotate_signing(config)
  end

  @doc """
  Revoke the application signing key with the given ID.

  ## see
  https://auth0.com/docs/api/management/v2/keys/put-signing-keys

  """
  @spec revoke_signing_key(kid, config) ::
          {:ok, map()} | error
  def revoke_signing_key(kid, %Config{} = config \\ %Config{}) do
    Keys.revoke_signing(kid, config)
  end

  @doc """
  Retrieve details of all the encryption keys associated with your tenant.

  ## query parameters
  - `page`
  - `per_page`
  - `include_totals`

  ## see
  https://auth0.com/docs/api/management/v2/keys/get-encryption-keys

  """
  @spec get_encryption_keys(map(), config) ::
          {:ok, list(map()) | map()} | error
  def get_encryption_keys(%{} = params, %Config{} = config) do
    Keys.get_encryption_keys(params, config)
  end

  @doc """
  Create the new, pre-activated encryption key, without the key material.

  ## see
  https://auth0.com/docs/api/management/v2/keys/post-encryption

  """
  @spec create_encryption_key(map(), config) ::
          {:ok, map()} | error
  def create_encryption_key(%{} = params, %Config{} = config) do
    Keys.create_encryption_key(params, config)
  end

  @doc """
  Perform rekeying operation on the key hierarchy.

  ## see
  https://auth0.com/docs/api/management/v2/keys/post-encryption-rekey

  """
  @spec rekey_encryption_key(config) ::
          {:ok, String.t()} | error
  def rekey_encryption_key(%Config{} = config) do
    Keys.rekey_encryption_key(config)
  end

  @doc """
  Retrieve details of the encryption key with the given ID.

  ## see
  https://auth0.com/docs/api/management/v2/keys/get-encryption-key

  """
  @spec get_encryption_key(kid, config) ::
          {:ok, map()} | error
  def get_encryption_key(kid, %Config{} = config) do
    Keys.get_encryption_key(kid, config)
  end

  @doc """
  Delete the custom provided encryption key with the given ID and move back to using native encryption key.

  ## see
  https://auth0.com/docs/api/management/v2/keys/delete-encryption-key

  """
  @spec delete_encryption_key(kid, config) ::
          {:ok, String.t()} | error
  def delete_encryption_key(kid, %Config{} = config) do
    Keys.delete_encryption_key(kid, config)
  end

  @doc """
  Import wrapped key material and activate encryption key.

  ## see
  https://auth0.com/docs/api/management/v2/keys/post-encryption-key

  """
  @spec import_encryption_key(kid, map(), config) ::
          {:ok, map()} | error
  def import_encryption_key(kid, %{} = params, %Config{} = config) do
    Keys.import_encryption_key(kid, params, config)
  end

  @doc """
  Create the public wrapping key to wrap your own encryption key material.

  ## see
  https://auth0.com/docs/api/management/v2/keys/post-encryption-wrapping-key

  """
  @spec create_encryption_wrapping_key(kid, config) ::
          {:ok, map()} | error
  def create_encryption_wrapping_key(kid, %Config{} = config) do
    Keys.create_encryption_wrapping_key(kid, config)
  end

  @doc """
  Get custom signing keys.

  Get entire jwks representation of custom signing keys.

  ## see
  https://auth0.com/docs/api/management/v2/keys/get-custom-signing-keys

  """
  @spec get_custom_signing_keys(config) :: {:ok, map()} | error
  def get_custom_signing_keys(%Config{} = config \\ %Config{}) do
    Keys.get_custom_signing(config)
  end

  @doc """
  Create or replace custom signing keys.

  Create or replace entire jwks representation of custom signing keys.

  ## see
  https://auth0.com/docs/api/management/v2/keys/put-custom-signing-keys

  """
  @spec set_custom_signing_keys(map(), config) :: {:ok, map()} | error
  def set_custom_signing_keys(%{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Keys.set_custom_signing(params, config)
  end

  @doc """
  Delete custom signing keys.

  Delete entire jwks representation of custom signing keys.

  ## see
  https://auth0.com/docs/api/management/v2/keys/delete-custom-signing-keys

  """
  @spec delete_custom_signing_keys(config) :: {:ok, String.t()} | error
  def delete_custom_signing_keys(%Config{} = config \\ %Config{}) do
    Keys.delete_custom_signing(config)
  end

  @doc """
  Get all Network ACL keys.

  Retrieve all keys used to verify HTTP Message Signatures on Network ACL rules, ordered by creation time descending.

  **Early Access**: this endpoint is marked as Early Access (`x-release-lifecycle: EA`) in the Auth0 Management API specification and may not be available on every tenant.

  ## see
  https://auth0.com/docs/api/management/v2/keys/get-all-keys-network-acls

  """
  @spec get_network_acl_keys(config) :: {:ok, map()} | error
  def get_network_acl_keys(%Config{} = config \\ %Config{}) do
    Keys.list_network_acl_keys(config)
  end

  @doc """
  Create a Network ACL key.

  Create a new key used to verify HTTP Message Signatures on Network ACL rules.

  **Early Access**: this endpoint is marked as Early Access (`x-release-lifecycle: EA`) in the Auth0 Management API specification and may not be available on every tenant.

  ## see
  https://auth0.com/docs/api/management/v2/keys/create-keys-network-acls

  """
  @spec create_network_acl_key(map(), config) :: {:ok, map()} | error
  def create_network_acl_key(%{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Keys.create_network_acl_key(params, config)
  end

  @doc """
  Get a Network ACL Key.

  Retrieve a specific key used to verify HTTP Message Signatures on Network ACL rules.

  **Early Access**: this endpoint is marked as Early Access (`x-release-lifecycle: EA`) in the Auth0 Management API specification and may not be available on every tenant.

  Path parameters are percent-encoded before they are placed in the request path.

  ## see
  https://auth0.com/docs/api/management/v2/keys/get-keys-network-acls

  """
  @spec get_network_acl_key(String.t(), config) :: {:ok, map()} | error
  def get_network_acl_key(id, %Config{} = config \\ %Config{}) do
    Keys.get_network_acl_key(id, config)
  end

  @doc """
  Delete a Network ACL key.

  Delete a key used to verify HTTP Message Signatures on Network ACL rules

  **Early Access**: this endpoint is marked as Early Access (`x-release-lifecycle: EA`) in the Auth0 Management API specification and may not be available on every tenant.

  Path parameters are percent-encoded before they are placed in the request path.

  ## see
  https://auth0.com/docs/api/management/v2/keys/delete-keys-network-acls

  """
  @spec delete_network_acl_key(String.t(), config) :: {:ok, String.t()} | error
  def delete_network_acl_key(id, %Config{} = config \\ %Config{}) do
    Keys.delete_network_acl_key(id, config)
  end

  @doc """
  Retrieve details on log streams.

  ## see
  https://auth0.com/docs/api/management/v2/log-streams/get-log-streams

  """
  @spec get_log_streams(config) :: {:ok, map()} | error
  def get_log_streams(%Config{} = config \\ %Config{}) do
    LogStreams.list(config)
  end

  @doc """
  Create a log stream.

  ## see
  https://auth0.com/docs/api/management/v2/log-streams/post-log-streams

  """
  @spec create_log_stream(map(), config) ::
          {:ok, map()} | error
  def create_log_stream(%{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    LogStreams.create(params, config)
  end

  @doc """
  Retrieve a log stream configuration and status.

  ## see
  https://auth0.com/docs/api/management/v2#!/Log_Streams/get_log_streams_by_id

  """
  @spec get_log_stream(id, config) ::
          {:ok, map()} | error
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
  @spec update_log_stream(id, map(), config) ::
          {:ok, map()} | error
  def update_log_stream(id, %{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    LogStreams.update(id, params, config)
  end

  @doc """
  Retrieve log entries that match the specified search criteria (or all log entries if no criteria specified).

  ## query parameters
  - `page`
  - `per_page`
  - `sort`
  - `fields`
  - `include_fields`
  - `include_totals` (deprecated: Auth0 has deprecated this field for `GET /api/v2/logs` (Log Search Engine v3); do not rely on it)
  - `from`
  - `take`
  - `search`

  ## see
  https://auth0.com/docs/api/management/v2/logs/get-logs

  """
  @spec get_log_events(map(), config) ::
          {:ok, list(map()) | map()} | error
  def get_log_events(%{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Logs.list(params, config)
  end

  @doc """
  Retrieve an individual log event.

  ## see
  https://auth0.com/docs/api/management/v2/logs/get-logs-by-id

  """
  @spec get_log_event(id, config) :: {:ok, map()} | error
  def get_log_event(id, %Config{} = config \\ %Config{}) do
    Logs.get(id, config)
  end

  @doc """
  Retrieve a list of network ACLs.

  ## query parameters
  - `page`
  - `per_page`
  - `include_totals`

  ## see
  https://auth0.com/docs/api/management/v2/network-acls/get-network-acls
  """
  @spec get_network_acls(map(), config) :: {:ok, list(map())} | error
  def get_network_acls(%{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    NetworkAcls.list(params, config)
  end

  @doc """
  Create a network ACL.

  ## see
  https://auth0.com/docs/api/management/v2/network-acls/post-network-acls
  """
  @spec create_network_acl(map(), config) :: {:ok, map()} | error
  def create_network_acl(%{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    NetworkAcls.create(params, config)
  end

  @doc """
  Retrieve a network ACL by its ID.

  ## see
  https://auth0.com/docs/api/management/v2/network-acls/get-network-acls-by-id
  """
  @spec get_network_acl(id, config) :: {:ok, map()} | error
  def get_network_acl(id, %Config{} = config \\ %Config{}) do
    NetworkAcls.get(id, config)
  end

  @doc """
  Delete a network ACL.

  ## see
  https://auth0.com/docs/api/management/v2/network-acls/delete-network-acls-by-id
  """
  @spec delete_network_acl(id, config) :: {:ok, String.t()} | error
  def delete_network_acl(id, %Config{} = config \\ %Config{}) do
    NetworkAcls.delete(id, config)
  end

  @doc """
  Update a network ACL.

  ## see
  https://auth0.com/docs/api/management/v2/network-acls/patch-network-acls-by-id
  """
  @spec update_network_acl(id, map(), config) :: {:ok, map()} | error
  def update_network_acl(id, %{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    NetworkAcls.update(id, params, config)
  end

  @doc """
  Update Access Control List.

  Update existing access control list for your client.

  Path parameters are percent-encoded before they are placed in the request path.

  ## see
  https://auth0.com/docs/api/management/v2/network-acls/put-network-acls-by-id

  """
  @spec set_network_acl(String.t(), map(), config) :: {:ok, map()} | error
  def set_network_acl(id, %{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    NetworkAcls.set(id, params, config)
  end

  @doc """
  Retrive detailed list of all Organizations available in your tenant.

  ## query parameters
  - `page`
  - `per_page`
  - `include_totals`
  - `from`
  - `take`
  - `sort`
  - `include_client_association_for` (Early Access)

  ## see
  https://auth0.com/docs/api/management/v2/organizations/get-organizations

  """
  @spec get_organizations(map(), config) ::
          {:ok, list(map()) | map()} | error
  def get_organizations(%{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Organizations.list(params, config)
  end

  @doc """
  Create a new Organization within your tenant.

  ## body properties to note
  The request body is sent as given. These properties have a non-GA lifecycle in the Auth0 specification:
  - `is_app_entitlement_active` (Early Access)
  - `token_quota` (Early Access)

  ## see
  https://auth0.com/docs/api/management/v2/organizations/post-organizations

  """
  @spec create_organization(map(), config) ::
          {:ok, map()} | error
  def create_organization(%{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Organizations.create(params, config)
  end

  @doc """
  Retrieve details about a single Organization specified by name.

  ## see
  https://auth0.com/docs/api/management/v2/organizations/get-name-by-name

  """
  @spec get_organization_by_name(name, config) ::
          {:ok, map()} | error
  def get_organization_by_name(name, %Config{} = config \\ %Config{}) do
    Organizations.get_by_name(name, config)
  end

  @doc """
  Retrieve details about a single Organization specified by ID.

  ## see
  https://auth0.com/docs/api/management/v2/organizations/get-organizations-by-id

  """
  @spec get_organization(id, config) ::
          {:ok, map()} | error
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

  ## body properties to note
  The request body is sent as given. These properties have a non-GA lifecycle in the Auth0 specification:
  - `is_app_entitlement_active` (Early Access)
  - `token_quota` (Early Access)

  ## see
  https://auth0.com/docs/api/management/v2/organizations/patch-organizations-by-id

  """
  @spec modify_organization(id, map(), config) ::
          {:ok, map()} | error
  def modify_organization(id, %{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Organizations.modify(id, params, config)
  end

  @doc """
  Retrieve details about a specific connection currently enabled for an Organization. Information returned includes details such as connection ID, name, strategy, and whether the connection automatically grants membership upon login.

  ## query parameters
  - `page`
  - `per_page`
  - `include_totals`

  ## see
  https://auth0.com/docs/api/management/v2/organizations/get-enabled-connections

  """
  @spec get_organization_connections(id, map(), config) ::
          {:ok, list(map()) | map()} | error
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
          map(),
          config
        ) ::
          {:ok, map()} | error
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
          {:ok, map()} | error
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
          map(),
          config
        ) ::
          {:ok, map()} | error
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

  ## query parameters
  - `page`
  - `per_page`
  - `include_totals`
  - `fields`
  - `include_fields`
  - `sort`

  ## see
  https://auth0.com/docs/api/management/v2/organizations/get-invitations

  """
  @spec get_organization_invitations(id, map(), config) ::
          {:ok, list(map()) | map()} | error
  def get_organization_invitations(
        id,
        %{} = params \\ %{},
        %Config{} = config \\ %Config{}
      ) do
    Organizations.list_invitations(id, params, config)
  end

  @doc """
  Create a user invitation for a specific Organization. Upon creation, the listed user receives an email inviting them to join the Organization.

  ## options
  - `:custom_domain` - sent as the `auth0-custom-domain` header so that Auth0 uses
    this custom domain (host name, optionally with a port) for links it generates.
    An invalid value raises `ArgumentError`.

  ## see
  https://auth0.com/docs/api/management/v2/organizations/post-invitations

  """
  @spec create_organization_invitation(id, map(), config, request_opts) ::
          {:ok, map()} | error
  def create_organization_invitation(
        id,
        %{} = params \\ %{},
        %Config{} = config \\ %Config{},
        opts \\ []
      ) do
    Organizations.create_invitation(id, params, config, opts)
  end

  @doc """
  Get a specific invitation to an Organization

  ## query parameters
  - `fields`
  - `include_fields`

  ## see
  https://auth0.com/docs/api/management/v2/organizations/get-invitations-by-invitation-id

  """
  @spec get_organization_invitation(
          id,
          invitation_id,
          map(),
          config
        ) ::
          {:ok, map()} | error
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

  ## query parameters
  - `page`
  - `per_page`
  - `include_totals`
  - `from`
  - `take`
  - `fields`
  - `include_fields`

  ## see
  https://auth0.com/docs/api/management/v2/organizations/get-members

  """
  @spec get_organization_members(id, map(), config) ::
          {:ok, list(map()) | map()} | error
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
  @spec delete_organization_members(id, map(), config) ::
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
  @spec add_organization_members(id, map(), config) ::
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

  ## query parameters
  - `page`
  - `per_page`
  - `include_totals`

  ## see
  https://auth0.com/docs/api/management/v2/organizations/get-organization-member-roles

  """
  @spec get_organization_roles(id, user_id, map(), config) ::
          {:ok, list(map()) | map()} | error
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
          map(),
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
  @spec assign_organization_roles(id, user_id, map(), config) ::
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
  Search organizations.

  Retrieve details of organizations matching a search criteria. It is possible to:

  **Early Access**: this endpoint is marked as Early Access (`x-release-lifecycle: EA`) in the Auth0 Management API specification and may not be available on every tenant.

  ## query parameters
  - `q`
  - `parser`
  - `take`
  - `from`
  - `sort`

  ## see
  https://auth0.com/docs/api/management/v2/organizations/get-search

  """
  @spec search_organizations(map(), config) :: {:ok, map() | list(map())} | error
  def search_organizations(%{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Organizations.search(params, config)
  end

  @doc """
  Get client grants associated to an organization.

  ## query parameters
  - `audience`
  - `client_id`
  - `grant_ids` (array: pass a list such as `["a", "b"]` to send multiple values; it is sent as repeated `grant_ids=` keys)
  - `page`
  - `per_page`
  - `include_totals`

  Path parameters are percent-encoded before they are placed in the request path.

  ## see
  https://auth0.com/docs/api/management/v2/organizations/get-organization-client-grants

  """
  @spec get_organization_client_grants(String.t(), map(), config) ::
          {:ok, map() | list(map())} | error
  def get_organization_client_grants(id, %{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Organizations.list_client_grants(id, params, config)
  end

  @doc """
  Associate a client grant with an organization.

  Path parameters are percent-encoded before they are placed in the request path.

  ## see
  https://auth0.com/docs/api/management/v2/organizations/create-organization-client-grants

  """
  @spec associate_organization_client_grant(String.t(), map(), config) :: {:ok, map()} | error
  def associate_organization_client_grant(
        id,
        %{} = params \\ %{},
        %Config{} = config \\ %Config{}
      ) do
    Organizations.create_client_grant(id, params, config)
  end

  @doc """
  Remove a client grant from an organization.

  Path parameters are percent-encoded before they are placed in the request path.

  ## see
  https://auth0.com/docs/api/management/v2/organizations/delete-client-grants-by-grant-id

  """
  @spec delete_organization_client_grant(String.t(), String.t(), config) ::
          {:ok, String.t()} | error
  def delete_organization_client_grant(id, grant_id, %Config{} = config \\ %Config{}) do
    Organizations.delete_client_grant(id, grant_id, config)
  end

  @doc """
  List organization client associations.

  List all clients associated with an organization, using checkpoint pagination. Note: The first time you call this endpoint, omit the from parameter. If there are more results, a next value is included in the response. You can use this for subsequent API calls. When next is no longer included in the response, no further results are remaining. 

  **Early Access**: this endpoint is marked as Early Access (`x-release-lifecycle: EA`) in the Auth0 Management API specification and may not be available on every tenant.

  ## query parameters
  - `from`
  - `take`

  Path parameters are percent-encoded before they are placed in the request path.

  ## see
  https://auth0.com/docs/api/management/v2/organizations/get-organization-clients

  """
  @spec get_organization_clients(String.t(), map(), config) :: {:ok, map()} | error
  def get_organization_clients(id, %{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Organizations.list_clients(id, params, config)
  end

  @doc """
  Associate clients with an organization.

  Associate one or more clients with an organization.

  **Early Access**: this endpoint is marked as Early Access (`x-release-lifecycle: EA`) in the Auth0 Management API specification and may not be available on every tenant.

  Path parameters are percent-encoded before they are placed in the request path.

  ## see
  https://auth0.com/docs/api/management/v2/organizations/post-organization-clients

  """
  @spec add_organization_clients(String.t(), map(), config) :: {:ok, list(map())} | error
  def add_organization_clients(id, %{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Organizations.create_clients(id, params, config)
  end

  @doc """
  Remove client associations from an organization.

  Remove one or more client associations from an organization.

  **Early Access**: this endpoint is marked as Early Access (`x-release-lifecycle: EA`) in the Auth0 Management API specification and may not be available on every tenant.

  Path parameters are percent-encoded before they are placed in the request path.

  ## see
  https://auth0.com/docs/api/management/v2/organizations/delete-organization-clients

  """
  @spec delete_organization_clients(String.t(), map(), config) :: {:ok, String.t()} | error
  def delete_organization_clients(id, %{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Organizations.delete_clients(id, params, config)
  end

  @doc """
  Get an organization client association.

  Get a specific client association for an organization.

  **Early Access**: this endpoint is marked as Early Access (`x-release-lifecycle: EA`) in the Auth0 Management API specification and may not be available on every tenant.

  Path parameters are percent-encoded before they are placed in the request path.

  ## see
  https://auth0.com/docs/api/management/v2/organizations/get-organization-client

  """
  @spec get_organization_client(String.t(), String.t(), config) :: {:ok, map()} | error
  def get_organization_client(id, client_id, %Config{} = config \\ %Config{}) do
    Organizations.get_client(id, client_id, config)
  end

  @doc """
  Update an organization client association.

  **Early Access**: this endpoint is marked as Early Access (`x-release-lifecycle: EA`) in the Auth0 Management API specification and may not be available on every tenant.

  Path parameters are percent-encoded before they are placed in the request path.

  ## see
  https://auth0.com/docs/api/management/v2/organizations/patch-organization-client

  """
  @spec update_organization_client(String.t(), String.t(), map(), config) :: {:ok, map()} | error
  def update_organization_client(
        id,
        client_id,
        %{} = params \\ %{},
        %Config{} = config \\ %Config{}
      ) do
    Organizations.update_client(id, client_id, params, config)
  end

  @doc """
  Get connections associated with an organization.

  **Early Access**: this endpoint is marked as Early Access (`x-release-lifecycle: EA`) in the Auth0 Management API specification and may not be available on every tenant.

  ## query parameters
  - `page`
  - `per_page`
  - `include_totals`
  - `is_enabled`

  Path parameters are percent-encoded before they are placed in the request path.

  ## see
  https://auth0.com/docs/api/management/v2/organizations/get-organization-connections

  """
  @spec get_organization_associated_connections(String.t(), map(), config) ::
          {:ok, map() | list(map())} | error
  def get_organization_associated_connections(
        id,
        %{} = params \\ %{},
        %Config{} = config \\ %Config{}
      ) do
    Organizations.list_associated_connections(id, params, config)
  end

  @doc """
  Add a connection to an organization.

  **Early Access**: this endpoint is marked as Early Access (`x-release-lifecycle: EA`) in the Auth0 Management API specification and may not be available on every tenant.

  Path parameters are percent-encoded before they are placed in the request path.

  ## see
  https://auth0.com/docs/api/management/v2/organizations/post-organization-connection

  """
  @spec add_organization_associated_connection(String.t(), map(), config) :: {:ok, map()} | error
  def add_organization_associated_connection(
        id,
        %{} = params \\ %{},
        %Config{} = config \\ %Config{}
      ) do
    Organizations.create_associated_connection(id, params, config)
  end

  @doc """
  Get a specific connection associated with an organization.

  **Early Access**: this endpoint is marked as Early Access (`x-release-lifecycle: EA`) in the Auth0 Management API specification and may not be available on every tenant.

  Path parameters are percent-encoded before they are placed in the request path.

  ## see
  https://auth0.com/docs/api/management/v2/organizations/get-organization-connection

  """
  @spec get_organization_associated_connection(String.t(), String.t(), config) ::
          {:ok, map()} | error
  def get_organization_associated_connection(id, connection_id, %Config{} = config \\ %Config{}) do
    Organizations.get_associated_connection(id, connection_id, config)
  end

  @doc """
  Update a connection for an organization.

  **Early Access**: this endpoint is marked as Early Access (`x-release-lifecycle: EA`) in the Auth0 Management API specification and may not be available on every tenant.

  Path parameters are percent-encoded before they are placed in the request path.

  ## see
  https://auth0.com/docs/api/management/v2/organizations/patch-organization-connection

  """
  @spec update_organization_associated_connection(String.t(), String.t(), map(), config) ::
          {:ok, map()} | error
  def update_organization_associated_connection(
        id,
        connection_id,
        %{} = params \\ %{},
        %Config{} = config \\ %Config{}
      ) do
    Organizations.update_associated_connection(id, connection_id, params, config)
  end

  @doc """
  Delete a connection from an organization.

  **Early Access**: this endpoint is marked as Early Access (`x-release-lifecycle: EA`) in the Auth0 Management API specification and may not be available on every tenant.

  Path parameters are percent-encoded before they are placed in the request path.

  ## see
  https://auth0.com/docs/api/management/v2/organizations/delete-organization-connection

  """
  @spec delete_organization_associated_connection(String.t(), String.t(), config) ::
          {:ok, String.t()} | error
  def delete_organization_associated_connection(
        id,
        connection_id,
        %Config{} = config \\ %Config{}
      ) do
    Organizations.delete_associated_connection(id, connection_id, config)
  end

  @doc """
  Retrieve all organization discovery domains.

  Retrieve list of all organization discovery domains associated with the specified organization. This endpoint is subject to eventual consistency; newly created, updated, or deleted discovery domains may not immediately appear in the response.

  ## query parameters
  - `from`
  - `take`

  Path parameters are percent-encoded before they are placed in the request path.

  ## see
  https://auth0.com/docs/api/management/v2/organizations/get-discovery-domains

  """
  @spec get_organization_discovery_domains(String.t(), map(), config) :: {:ok, map()} | error
  def get_organization_discovery_domains(id, %{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Organizations.list_discovery_domains(id, params, config)
  end

  @doc """
  Create an organization discovery domain.

  Create a new discovery domain for an organization.

  Path parameters are percent-encoded before they are placed in the request path.

  ## see
  https://auth0.com/docs/api/management/v2/organizations/post-discovery-domains

  """
  @spec create_organization_discovery_domain(String.t(), map(), config) :: {:ok, map()} | error
  def create_organization_discovery_domain(
        id,
        %{} = params \\ %{},
        %Config{} = config \\ %Config{}
      ) do
    Organizations.create_discovery_domain(id, params, config)
  end

  @doc """
  Retrieve an organization discovery domain by domain name.

  Retrieve details about a single organization discovery domain specified by domain name. This endpoint is subject to eventual consistency; newly created, updated, or deleted discovery domains may not immediately appear in the response.

  Path parameters are percent-encoded before they are placed in the request path.

  ## see
  https://auth0.com/docs/api/management/v2/organizations/get-name-by-discovery-domain

  """
  @spec get_organization_discovery_domain_by_name(String.t(), String.t(), config) ::
          {:ok, map()} | error
  def get_organization_discovery_domain_by_name(
        id,
        discovery_domain,
        %Config{} = config \\ %Config{}
      ) do
    Organizations.get_discovery_domain_by_name(id, discovery_domain, config)
  end

  @doc """
  Retrieve an organization discovery domain by ID.

  Retrieve details about a single organization discovery domain specified by ID. This endpoint is subject to eventual consistency; newly created, updated, or deleted discovery domains may not immediately appear in the response.

  Path parameters are percent-encoded before they are placed in the request path.

  ## see
  https://auth0.com/docs/api/management/v2/organizations/get-discovery-domains-by-discovery-domain-id

  """
  @spec get_organization_discovery_domain(String.t(), String.t(), config) :: {:ok, map()} | error
  def get_organization_discovery_domain(id, discovery_domain_id, %Config{} = config \\ %Config{}) do
    Organizations.get_discovery_domain(id, discovery_domain_id, config)
  end

  @doc """
  Update an organization discovery domain.

  Update the verification status and/or use_for_organization_discovery for an organization discovery domain. The `status` field must be either `pending` or `verified`. The `use_for_organization_discovery` field can be `true` or `false` (default: `true`).

  Path parameters are percent-encoded before they are placed in the request path.

  ## see
  https://auth0.com/docs/api/management/v2/organizations/patch-discovery-domains-by-discovery-domain-id

  """
  @spec update_organization_discovery_domain(String.t(), String.t(), map(), config) ::
          {:ok, map()} | error
  def update_organization_discovery_domain(
        id,
        discovery_domain_id,
        %{} = params \\ %{},
        %Config{} = config \\ %Config{}
      ) do
    Organizations.update_discovery_domain(id, discovery_domain_id, params, config)
  end

  @doc """
  Delete an organization discovery domain.

  Remove a discovery domain from an organization. This action cannot be undone.

  Path parameters are percent-encoded before they are placed in the request path.

  ## see
  https://auth0.com/docs/api/management/v2/organizations/delete-discovery-domains-by-discovery-domain-id

  """
  @spec delete_organization_discovery_domain(String.t(), String.t(), config) ::
          {:ok, String.t()} | error
  def delete_organization_discovery_domain(
        id,
        discovery_domain_id,
        %Config{} = config \\ %Config{}
      ) do
    Organizations.delete_discovery_domain(id, discovery_domain_id, config)
  end

  @doc """
  List organization member effective roles.

  Lists the roles assigned to an organization member directly or through group membership.

  ## query parameters
  - `from`
  - `take`

  Path parameters are percent-encoded before they are placed in the request path.

  ## see
  https://auth0.com/docs/api/management/v2/organizations/get-organization-member-effective-roles

  """
  @spec get_organization_member_effective_roles(String.t(), String.t(), map(), config) ::
          {:ok, map()} | error
  def get_organization_member_effective_roles(
        id,
        user_id,
        %{} = params \\ %{},
        %Config{} = config \\ %Config{}
      ) do
    Organizations.list_member_effective_roles(id, user_id, params, config)
  end

  @doc """
  List organization member role group sources.

  Lists the groups which grant the org member a given role.

  ## query parameters
  - `from`
  - `take`
  - `role_id`

  Path parameters are percent-encoded before they are placed in the request path.

  ## see
  https://auth0.com/docs/api/management/v2/organizations/get-organization-member-role-source-groups

  """
  @spec get_organization_member_effective_role_group_sources(
          String.t(),
          String.t(),
          map(),
          config
        ) :: {:ok, map()} | error
  def get_organization_member_effective_role_group_sources(
        id,
        user_id,
        %{} = params \\ %{},
        %Config{} = config \\ %Config{}
      ) do
    Organizations.list_member_effective_role_group_sources(id, user_id, params, config)
  end

  @doc """
  List the members assigned to a role in the context of an organization.

  List the organization members assigned a specific role within the context of an organization. Note: Returns only members with direct role assignments. For groups assigned to this role within the organization, use GET /api/v2/organizations/{organization_id}/roles/{role_id}/groups. 

  **Early Access**: this endpoint is marked as Early Access (`x-release-lifecycle: EA`) in the Auth0 Management API specification and may not be available on every tenant.

  ## query parameters
  - `from`
  - `take`
  - `fields`
  - `include_fields`

  Path parameters are percent-encoded before they are placed in the request path.

  ## see
  https://auth0.com/docs/api/management/v2/organizations/get-organization-role-members

  """
  @spec get_organization_role_members(String.t(), String.t(), map(), config) ::
          {:ok, map()} | error
  def get_organization_role_members(
        id,
        role_id,
        %{} = params \\ %{},
        %Config{} = config \\ %Config{}
      ) do
    Organizations.list_role_members(id, role_id, params, config)
  end

  @doc """
  List the groups that are assigned to the organization.

  Lists the groups that are assigned to the specified organization.

  ## query parameters
  - `from`
  - `take`

  Path parameters are percent-encoded before they are placed in the request path.

  ## see
  https://auth0.com/docs/api/management/v2/organizations/get-organization-groups

  """
  @spec get_organization_groups(String.t(), map(), config) :: {:ok, map()} | error
  def get_organization_groups(
        organization_id,
        %{} = params \\ %{},
        %Config{} = config \\ %Config{}
      ) do
    Organizations.list_groups(organization_id, params, config)
  end

  @doc """
  List the roles assigned to a group in the context of an organization.

  Lists the roles assigned to the specified group in the context of an organization.

  ## query parameters
  - `from`
  - `take`

  Path parameters are percent-encoded before they are placed in the request path.

  ## see
  https://auth0.com/docs/api/management/v2/organizations/get-organization-group-roles

  """
  @spec get_organization_group_roles(String.t(), String.t(), map(), config) ::
          {:ok, map()} | error
  def get_organization_group_roles(
        organization_id,
        group_id,
        %{} = params \\ %{},
        %Config{} = config \\ %Config{}
      ) do
    Organizations.list_group_roles(organization_id, group_id, params, config)
  end

  @doc """
  Assign roles to a group in an organization context.

  Assign one or more roles to a specified group in the context of an organization.

  Path parameters are percent-encoded before they are placed in the request path.

  ## see
  https://auth0.com/docs/api/management/v2/organizations/post-organization-group-roles

  """
  @spec assign_organization_group_roles(String.t(), String.t(), map(), config) ::
          {:ok, String.t()} | error
  def assign_organization_group_roles(
        organization_id,
        group_id,
        %{} = params \\ %{},
        %Config{} = config \\ %Config{}
      ) do
    Organizations.assign_group_roles(organization_id, group_id, params, config)
  end

  @doc """
  Remove roles assigned to a group in an organization context.

  Unassign one or more roles from a specified group in the context of an organization.

  Path parameters are percent-encoded before they are placed in the request path.

  ## see
  https://auth0.com/docs/api/management/v2/organizations/delete-organization-group-roles

  """
  @spec remove_organization_group_roles(String.t(), String.t(), map(), config) ::
          {:ok, String.t()} | error
  def remove_organization_group_roles(
        organization_id,
        group_id,
        %{} = params \\ %{},
        %Config{} = config \\ %Config{}
      ) do
    Organizations.remove_group_roles(organization_id, group_id, params, config)
  end

  @doc """
  List the groups assigned to a role in the context of an organization.

  Retrieve the list of groups assigned to a role in the context of an organization.

  **Early Access**: this endpoint is marked as Early Access (`x-release-lifecycle: EA`) in the Auth0 Management API specification and may not be available on every tenant.

  ## query parameters
  - `from`
  - `take`

  Path parameters are percent-encoded before they are placed in the request path.

  ## see
  https://auth0.com/docs/api/management/v2/organizations/get-organization-role-groups

  """
  @spec get_organization_role_groups(String.t(), String.t(), map(), config) ::
          {:ok, map()} | error
  def get_organization_role_groups(
        organization_id,
        role_id,
        %{} = params \\ %{},
        %Config{} = config \\ %Config{}
      ) do
    Organizations.list_role_groups(organization_id, role_id, params, config)
  end

  @doc """
  Retrieve details of the Universal Login configuration of your tenant. This includes the Identifier First Authentication and WebAuthn with Device Biometrics for MFA features.

  ## see
  https://auth0.com/docs/api/management/v2/prompts/get-prompts

  """
  @spec get_prompt_setting(config) :: {:ok, map()} | error
  def get_prompt_setting(%Config{} = config \\ %Config{}) do
    Prompts.get(config)
  end

  @doc """
  Update the Universal Login configuration of your tenant. This includes the Identifier First Authentication and WebAuthn with Device Biometrics for MFA features.

  ## see
  https://auth0.com/docs/api/management/v2/prompts/patch-prompts

  """
  @spec update_prompt_setting(map(), config) ::
          {:ok, map()} | error
  def update_prompt_setting(%{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Prompts.update(params, config)
  end

  @doc """
  Retrieve custom text for a specific prompt and language.

  ## see
  https://auth0.com/docs/api/management/v2/prompts/get-custom-text-by-language

  """
  @spec get_prompt_custom_text(prompt, language, config) ::
          {:ok, map()} | error
  def get_prompt_custom_text(prompt, language, %Config{} = config \\ %Config{}) do
    Prompts.get_custom_text(prompt, language, config)
  end

  @doc """
  Set custom text for a specific prompt. Existing texts will be overwritten.

  ## see
  https://auth0.com/docs/api/management/v2/prompts/put-custom-text-by-language

  """
  # The default `params` (`%{}`) has no required key, so the set_prompt_custom_text/2 clause
  # generated by the default argument can never succeed. It is kept only for
  # backward compatibility (no public arity is removed), hence the warning is
  # suppressed for that arity only.
  @dialyzer {:nowarn_function, [{:set_prompt_custom_text, 2}]}
  @spec set_prompt_custom_text(prompt, language, value_params, config) ::
          {:ok, String.t()} | error
  def set_prompt_custom_text(
        prompt,
        language,
        %{} = params \\ %{},
        %Config{} = config \\ %Config{}
      ) do
    Prompts.set_custom_text(prompt, language, params, config)
  end

  @doc """
  Get template partials for a prompt

  ## see
  https://auth0.com/docs/api/management/v2/prompts/get-partials

  """
  @spec get_prompt_partials(prompt, config) ::
          {:ok, map()} | error
  def get_prompt_partials(prompt, %Config{} = config \\ %Config{}) do
    Prompts.get_partials(prompt, config)
  end

  @doc """
  Set template partials for a prompt

  ## see
  https://auth0.com/docs/api/management/v2/prompts/put-partials

  """
  # The default `params` (`%{}`) has no required key, so the set_prompt_partials/1 clause
  # generated by the default argument can never succeed. It is kept only for
  # backward compatibility (no public arity is removed), hence the warning is
  # suppressed for that arity only.
  @dialyzer {:nowarn_function, [{:set_prompt_partials, 1}]}
  @spec set_prompt_partials(prompt, value_params, config) ::
          {:ok, String.t()} | error
  def set_prompt_partials(
        prompt,
        %{} = params \\ %{},
        %Config{} = config \\ %Config{}
      ) do
    Prompts.set_partials(prompt, params, config)
  end

  @doc """
  Get rate limit policies.

  **Early Access**: this endpoint is marked as Early Access (`x-release-lifecycle: EA`) in the Auth0 Management API specification and may not be available on every tenant.

  ## query parameters
  - `resource`
  - `consumer`
  - `consumer_selector`
  - `take`
  - `from`

  ## see
  https://auth0.com/docs/api/management/v2/rate-limit-policies/get-rate-limit-policies

  """
  @spec get_rate_limit_policies(map(), config) :: {:ok, map()} | error
  def get_rate_limit_policies(%{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    RateLimitPolicies.list(params, config)
  end

  @doc """
  Create a rate limit policy.

  **Early Access**: this endpoint is marked as Early Access (`x-release-lifecycle: EA`) in the Auth0 Management API specification and may not be available on every tenant.

  ## see
  https://auth0.com/docs/api/management/v2/rate-limit-policies/post-rate-limit-policies

  """
  @spec create_rate_limit_policy(map(), config) :: {:ok, map()} | error
  def create_rate_limit_policy(%{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    RateLimitPolicies.create(params, config)
  end

  @doc """
  Get a rate limit policy.

  **Early Access**: this endpoint is marked as Early Access (`x-release-lifecycle: EA`) in the Auth0 Management API specification and may not be available on every tenant.

  Path parameters are percent-encoded before they are placed in the request path.

  ## see
  https://auth0.com/docs/api/management/v2/rate-limit-policies/get-rate-limit-policies-by-id

  """
  @spec get_rate_limit_policy(String.t(), config) :: {:ok, map()} | error
  def get_rate_limit_policy(id, %Config{} = config \\ %Config{}) do
    RateLimitPolicies.get(id, config)
  end

  @doc """
  Update a rate limit policy.

  **Early Access**: this endpoint is marked as Early Access (`x-release-lifecycle: EA`) in the Auth0 Management API specification and may not be available on every tenant.

  Path parameters are percent-encoded before they are placed in the request path.

  ## see
  https://auth0.com/docs/api/management/v2/rate-limit-policies/patch-rate-limit-policies-by-id

  """
  @spec update_rate_limit_policy(String.t(), map(), config) :: {:ok, map()} | error
  def update_rate_limit_policy(id, %{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    RateLimitPolicies.update(id, params, config)
  end

  @doc """
  Delete a rate limit policy.

  **Early Access**: this endpoint is marked as Early Access (`x-release-lifecycle: EA`) in the Auth0 Management API specification and may not be available on every tenant.

  Path parameters are percent-encoded before they are placed in the request path.

  ## see
  https://auth0.com/docs/api/management/v2/rate-limit-policies/delete-rate-limit-policies-by-id

  """
  @spec delete_rate_limit_policy(String.t(), config) :: {:ok, String.t()} | error
  def delete_rate_limit_policy(id, %Config{} = config \\ %Config{}) do
    RateLimitPolicies.delete(id, config)
  end

  @doc """
  Get render setting configurations for all screens.

  ## query parameters
  - `fields`
  - `include_fields`
  - `page`
  - `per_page`
  - `include_totals`
  - `prompt`
  - `screen`
  - `rendering_mode`

  ## see
  https://auth0.com/docs/api/management/v2/prompts/get-all-rendering

  """
  @spec get_prompt_renderings(map(), config) :: {:ok, map() | list(map())} | error
  def get_prompt_renderings(%{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Prompts.list_renderings(params, config)
  end

  @doc """
  Update render settings for multiple screens.

  Learn more about [configuring render settings](https://auth0.com/docs/customize/login-pages/advanced-customizations/getting-started/configure-acul-screens) for advanced customization.

  ## see
  https://auth0.com/docs/api/management/v2/prompts/patch-bulk-rendering

  """
  @spec bulk_update_prompt_renderings(map(), config) :: {:ok, map()} | error
  def bulk_update_prompt_renderings(%{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Prompts.bulk_update_renderings(params, config)
  end

  @doc """
  Get the render settings (rendering configuration) of a single screen.

  ## see
  https://auth0.com/docs/api/management/v2/prompts/get-rendering

  """
  @spec get_prompt_rendering(prompt, String.t(), config) :: {:ok, map()} | error
  def get_prompt_rendering(prompt, screen, %Config{} = config \\ %Config{}) do
    Prompts.get_rendering_configuration(prompt, screen, config)
  end

  @doc """
  Update the render settings (rendering configuration) of a single screen.

  ## see
  https://auth0.com/docs/api/management/v2/prompts/patch-rendering

  """
  @spec update_prompt_rendering(prompt, String.t(), map(), config) :: {:ok, map()} | error
  def update_prompt_rendering(
        prompt,
        screen,
        %{} = params \\ %{},
        %Config{} = config \\ %Config{}
      ) do
    Prompts.set_rendering_configuration(prompt, screen, params, config)
  end

  @doc """
  Retrieve refresh token information.

  ## see
  https://auth0.com/docs/api/management/v2/refresh-tokens/get-refresh-token

  """
  @spec get_refresh_token(id, config) ::
          {:ok, map()} | error
  def get_refresh_token(id, %Config{} = config \\ %Config{}) do
    RefreshTokens.get(id, config)
  end

  @doc """
  Delete a refresh token by its ID.

  ## see
  https://auth0.com/docs/api/management/v2/refresh-tokens/delete-refresh-token

  """
  @spec delete_refresh_token(id, config) ::
          {:ok, String.t()} | error
  def delete_refresh_token(id, %Config{} = config \\ %Config{}) do
    RefreshTokens.delete(id, config)
  end

  @doc """
  Get refresh tokens.

  Retrieve a paginated list of refresh tokens for a specific user, with optional filtering by client ID. Results are sorted by credential_id ascending.

  **Early Access**: this endpoint is marked as Early Access (`x-release-lifecycle: EA`) in the Auth0 Management API specification and may not be available on every tenant.

  ## query parameters
  - `user_id`
  - `client_id`
  - `from`
  - `take`
  - `fields`
  - `include_fields`

  ## see
  https://auth0.com/docs/api/management/v2/refresh-tokens/get-refresh-tokens

  """
  @spec get_refresh_tokens(map(), config) :: {:ok, map()} | error
  def get_refresh_tokens(%{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    RefreshTokens.list(params, config)
  end

  @doc """
  Revoke refresh tokens.

  Revoke refresh tokens in bulk by ID list, user, user+client, or user+client+audience.

  **Early Access**: this endpoint is marked as Early Access (`x-release-lifecycle: EA`) in the Auth0 Management API specification and may not be available on every tenant.

  ## see
  https://auth0.com/docs/api/management/v2/refresh-tokens/revoke-refresh-tokens

  """
  @spec revoke_refresh_tokens(map(), config) :: {:ok, String.t()} | error
  def revoke_refresh_tokens(%{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    RefreshTokens.revoke(params, config)
  end

  @doc """
  Update a refresh token.

  Update a refresh token by its ID.

  Path parameters are percent-encoded before they are placed in the request path.

  ## see
  https://auth0.com/docs/api/management/v2/refresh-tokens/patch-refresh-tokens-by-id

  """
  @spec update_refresh_token(String.t(), map(), config) :: {:ok, map()} | error
  def update_refresh_token(id, %{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    RefreshTokens.update(id, params, config)
  end

  @doc """
  Retrieve details of all APIs associated with your tenant.

  ## query parameters
  - `identifiers` (array: pass a list such as `["a", "b"]` to send multiple values; it is sent as repeated `identifiers=` keys)
  - `page`
  - `per_page`
  - `include_totals`
  - `include_fields`

  ## see
  https://auth0.com/docs/api/management/v2/resource-servers/get-resource-servers

  """
  @spec get_resource_servers(map(), config) ::
          {:ok, list(map()) | map()} | error
  def get_resource_servers(%{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    ResourceServers.list(params, config)
  end

  @doc """
  Create a new API associated with your tenant. Note that all new APIs must be registered with Auth0.

  ## body properties to note
  The request body is sent as given. These properties have a non-GA lifecycle in the Auth0 specification:
  - `access_token` (Early Access)
  - `authorization_policy` (Early Access)
  - `require_consent_non_repudiation` (Early Access)
  - `token_lifetime_for_anonymous_access_tokens` (Early Access)

  ## see
  https://auth0.com/docs/api/management/v2/resource-servers/post-resource-servers

  """
  @spec create_resource_server(map(), config) ::
          {:ok, map()} | error
  def create_resource_server(%{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    ResourceServers.create(params, config)
  end

  @doc """
  Retrieve API details with the given ID.

  ## query parameters
  - `include_fields`

  ## see
  https://auth0.com/docs/api/management/v2/resource-servers/get-resource-servers-by-id

  """
  @spec get_resource_server(id, map(), config) ::
          {:ok, map()} | error
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

  ## body properties to note
  The request body is sent as given. These properties have a non-GA lifecycle in the Auth0 specification:
  - `access_token` (Early Access)
  - `authorization_policy` (Early Access)
  - `require_consent_non_repudiation` (Early Access)
  - `token_lifetime_for_anonymous_access_tokens` (Early Access)

  ## see
  https://auth0.com/docs/api/management/v2/resource-servers/patch-resource-servers-by-id

  """
  @spec update_resource_server(id, map(), config) ::
          {:ok, map()} | error
  def update_resource_server(id, %{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    ResourceServers.update(id, params, config)
  end

  @doc """
  Search resource servers.

  Search resource servers using SCIM or Lucene filter syntax with low-latency, eventually consistent results. Use the parser parameter to specify "scim" or "lucene" syntax (default: "lucene"). This endpoint provides an alternative to the standard GET /resource-servers endpoint with better performance for complex queries. Results may not reflect recent updates immediately.

  **Early Access**: this endpoint is marked as Early Access (`x-release-lifecycle: EA`) in the Auth0 Management API specification and may not be available on every tenant.

  ## query parameters
  - `q`
  - `parser`
  - `fields`
  - `include_fields`
  - `take`
  - `from`
  - `sort`

  ## see
  https://auth0.com/docs/api/management/v2/resource-servers/get-resource-servers-search

  """
  @spec search_resource_servers(map(), config) :: {:ok, map()} | error
  def search_resource_servers(%{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    ResourceServers.search(params, config)
  end

  @doc """
  Create a risk assessment.

  ## see
  https://auth0.com/docs/api/management/v2/risk-assessments/post-risk-assessments
  """
  @spec create_risk_assessment(map(), config) :: {:ok, map()} | error
  def create_risk_assessment(%{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    RiskAssessments.create(params, config)
  end

  @doc """
  Retrieve a risk assessment by its ID.

  ## see
  https://auth0.com/docs/api/management/v2/risk-assessments/get-risk-assessments-by-id
  """
  @spec get_risk_assessment(id, config) :: {:ok, map()} | error
  def get_risk_assessment(id, %Config{} = config \\ %Config{}) do
    RiskAssessments.get(id, config)
  end

  @doc """
  Get risk assessment settings.

  Gets the tenant settings for risk assessments

  ## see
  https://auth0.com/docs/api/management/v2/risk-assessments/get-risk-assessments-settings

  """
  @spec get_risk_assessments_settings(config) :: {:ok, map()} | error
  def get_risk_assessments_settings(%Config{} = config \\ %Config{}) do
    RiskAssessments.get_settings(config)
  end

  @doc """
  Update risk assessment settings.

  Updates the tenant settings for risk assessments

  ## see
  https://auth0.com/docs/api/management/v2/risk-assessments/patch-risk-assessments-settings

  """
  @spec update_risk_assessments_settings(map(), config) :: {:ok, map()} | error
  def update_risk_assessments_settings(%{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    RiskAssessments.update_settings(params, config)
  end

  @doc """
  Get new device assessor.

  Gets the risk assessment settings for the new device assessor

  ## see
  https://auth0.com/docs/api/management/v2/risk-assessments/get-new-device

  """
  @spec get_risk_assessments_new_device_settings(config) :: {:ok, map()} | error
  def get_risk_assessments_new_device_settings(%Config{} = config \\ %Config{}) do
    RiskAssessments.get_new_device_settings(config)
  end

  @doc """
  Update new device assessor.

  Updates the risk assessment settings for the new device assessor

  ## see
  https://auth0.com/docs/api/management/v2/risk-assessments/patch-new-device

  """
  @spec update_risk_assessments_new_device_settings(map(), config) :: {:ok, map()} | error
  def update_risk_assessments_new_device_settings(
        %{} = params \\ %{},
        %Config{} = config \\ %Config{}
      ) do
    RiskAssessments.update_new_device_settings(params, config)
  end

  @doc """
  Retrieve detailed list of user roles created in your tenant.

  ## query parameters
  - `per_page`
  - `page`
  - `include_totals`
  - `name_filter`
  - `type` (Early Access)
  - `owner_id` (Early Access)
  - `from` (Early Access)
  - `take` (Early Access)

  ## see
  https://auth0.com/docs/api/management/v2/roles/get-roles

  """
  @spec get_roles(map(), config) ::
          {:ok, list(map()) | map()} | error
  def get_roles(%{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Roles.list(params, config)
  end

  @doc """
  Create a user role for Role-Based Access Control.

  ## body properties to note
  The request body is sent as given. These properties have a non-GA lifecycle in the Auth0 specification:
  - `owner_id` (Early Access)
  - `type` (Early Access)

  ## see
  https://auth0.com/docs/api/management/v2/roles/post-roles

  """
  @spec create_role(map(), config) ::
          {:ok, map()} | error
  def create_role(%{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Roles.create(params, config)
  end

  @doc """
  Retrieve details about a specific user role specified by ID.

  ## see
  https://auth0.com/docs/api/management/v2/roles/get-roles-by-id

  """
  @spec get_role(id, config) :: {:ok, map()} | error
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
  @spec update_role(id, map(), config) ::
          {:ok, map()} | error
  def update_role(id, %{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Roles.update(id, params, config)
  end

  @doc """
  Retrieve detailed list (name, description, resource server) of permissions granted by a specified user role.

  ## query parameters
  - `per_page`
  - `page`
  - `include_totals`

  ## see
  https://auth0.com/docs/api/management/v2/roles/get-role-permission

  """
  @spec get_role_permissions(id, map(), config) ::
          {:ok, list(map()) | map()} | error
  def get_role_permissions(id, %{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Roles.list_permissions(id, params, config)
  end

  @doc """
  Remove one or more permissions from a specified user role.

  ## see
  https://auth0.com/docs/api/management/v2/roles/delete-role-permission-assignment

  """
  @spec remove_role_permissions(id, map(), config) ::
          {:ok, String.t()} | error
  def remove_role_permissions(id, %{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Roles.remove_permissions(id, params, config)
  end

  @doc """
  Add one or more permissions to a specified user role.

  ## see
  https://auth0.com/docs/api/management/v2/roles/post-role-permission-assignment

  """
  @spec associate_role_permissions(id, map(), config) ::
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

  ## query parameters
  - `per_page`
  - `page`
  - `include_totals`
  - `from`
  - `take`

  ## see
  https://auth0.com/docs/api/management/v2/roles/get-role-user

  """
  @spec get_role_users(id, map(), config) ::
          {:ok, list(map()) | map()} | error
  def get_role_users(id, %{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Roles.list_users(id, params, config)
  end

  @doc """
  Assign one or more users to an existing user role.

  ## see
  https://auth0.com/docs/api/management/v2/roles/post-role-users

  """
  @spec assign_role_users(id, map(), config) ::
          {:ok, String.t()} | error
  def assign_role_users(id, %{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Roles.assign_users(id, params, config)
  end

  @doc """
  Get a role's groups.

  Lists the groups to which the specified role is assigned.

  ## query parameters
  - `from`
  - `take`

  Path parameters are percent-encoded before they are placed in the request path.

  ## see
  https://auth0.com/docs/api/management/v2/roles/get-role-groups

  """
  @spec get_role_groups(String.t(), map(), config) :: {:ok, map()} | error
  def get_role_groups(id, %{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Roles.list_groups(id, params, config)
  end

  @doc """
  Assign groups to a role.

  Assign one or more groups to a specified role.

  Path parameters are percent-encoded before they are placed in the request path.

  ## see
  https://auth0.com/docs/api/management/v2/roles/post-role-groups

  """
  @spec assign_role_groups(String.t(), map(), config) :: {:ok, String.t()} | error
  def assign_role_groups(id, %{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Roles.assign_groups(id, params, config)
  end

  @doc """
  Remove groups from a role.

  Unassign one or more groups from a specified role.

  Path parameters are percent-encoded before they are placed in the request path.

  ## see
  https://auth0.com/docs/api/management/v2/roles/delete-role-groups

  """
  @spec remove_role_groups(String.t(), map(), config) :: {:ok, String.t()} | error
  def remove_role_groups(id, %{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Roles.remove_groups(id, params, config)
  end

  @doc """
  Create a supplemental signal.

  ## see
  https://auth0.com/docs/api/management/v2/supplemental-signals/post-supplemental-signals
  """
  @spec create_supplemental_signal(map(), config) :: {:ok, map()} | error
  def create_supplemental_signal(%{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    SupplementalSignals.create(params, config)
  end

  @doc """
  Retrieve a supplemental signal by its ID.

  ## see
  https://auth0.com/docs/api/management/v2/supplemental-signals/get-supplemental-signals-by-id
  """
  @spec get_supplemental_signal(id, config) :: {:ok, map()} | error
  def get_supplemental_signal(id, %Config{} = config \\ %Config{}) do
    SupplementalSignals.get(id, config)
  end

  @doc """
  Get the supplemental signals configuration for a tenant.

  **Early Access**: this endpoint is marked as Early Access (`x-release-lifecycle: EA`) in the Auth0 Management API specification and may not be available on every tenant.

  ## see
  https://auth0.com/docs/api/management/v2/supplemental-signals/get-supplemental-signals

  """
  @spec get_supplemental_signals(config) :: {:ok, map()} | error
  def get_supplemental_signals(%Config{} = config \\ %Config{}) do
    SupplementalSignals.get_settings(config)
  end

  @doc """
  Update the supplemental signals configuration for a tenant.

  **Early Access**: this endpoint is marked as Early Access (`x-release-lifecycle: EA`) in the Auth0 Management API specification and may not be available on every tenant.

  ## see
  https://auth0.com/docs/api/management/v2/supplemental-signals/patch-supplemental-signals

  """
  @spec update_supplemental_signals(map(), config) :: {:ok, map()} | error
  def update_supplemental_signals(%{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    SupplementalSignals.update_settings(params, config)
  end

  @doc """
  Retrieve a filtered list of rules. Accepts a list of fields to include or exclude.

  ## query parameters
  - `page`
  - `per_page`
  - `include_totals`
  - `enabled`
  - `fields`
  - `include_fields`

  ## see
  https://auth0.com/docs/api/management/v2/rules/get-rules

  """
  @spec get_rules(map(), config) ::
          {:ok, list(map()) | map()} | error
  def get_rules(%{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Rules.list(params, config)
  end

  @doc """
  Create a new rule.

  ## see
  https://auth0.com/docs/api/management/v2/rules/post-rules

  """
  @spec create_rule(map(), config) ::
          {:ok, map()} | error
  def create_rule(%{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Rules.create(params, config)
  end

  @doc """
  Retrieve rule details. Accepts a list of fields to include or exclude in the result.

  ## query parameters
  - `fields`
  - `include_fields`

  ## see
  https://auth0.com/docs/api/management/v2/rules/get-rules-by-id

  """
  @spec get_rule(id, map(), config) ::
          {:ok, map()} | error
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
  @spec update_rule(id, map(), config) ::
          {:ok, map()} | error
  def update_rule(id, %{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Rules.update(id, params, config)
  end

  @doc """
  Retrieve rules config variable keys.

  ## see
  https://auth0.com/docs/api/management/v2/rules-configs/get-rules-configs

  """
  @spec get_rules_configs(config) ::
          {:ok, list(map())} | error
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
  @spec set_rules_config(key, map(), config) ::
          {:ok, map()} | error
  def set_rules_config(key, %{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    RulesConfigs.set(key, params, config)
  end

  @doc """
  Retrieves self-service profiles. Currently only one profile can be created per tenant.

  ## query parameters
  - `page`
  - `per_page`
  - `include_totals`

  ## see
  https://auth0.com/docs/api/management/v2/self-service-profiles/get-self-service-profiles

  """
  @spec get_self_service_profiles(map(), config) ::
          {:ok, map()} | error
  def get_self_service_profiles(%{} = params, %Config{} = config) do
    SelfServiceProfiles.list(params, config)
  end

  @doc """
  Creates a self-service profile. Currently only one profile can be created per tenant.

  ## body properties to note
  The request body is sent as given. These properties have a non-GA lifecycle in the Auth0 specification:
  - `user_attribute_profile_id` (Early Access)

  ## see
  https://auth0.com/docs/api/management/v2/self-service-profiles/post-self-service-profiles

  """
  @spec create_self_service_profile(map(), config) ::
          {:ok, map()} | error
  def create_self_service_profile(%{} = params, %Config{} = config) do
    SelfServiceProfiles.create(params, config)
  end

  @doc """
  Retrieves a self-service profile by Id.

  ## see
  https://auth0.com/docs/api/management/v2/self-service-profiles/get-self-service-profiles-by-id

  """
  @spec get_self_service_profile(id, config) ::
          {:ok, map()} | error
  def get_self_service_profile(id, %Config{} = config) do
    SelfServiceProfiles.get(id, config)
  end

  @doc """
  Deletes a self-service profile by Id.

  ## see
  https://auth0.com/docs/api/management/v2/self-service-profiles/delete-self-service-profiles-by-id

  """
  @spec delete_self_service_profile(id, config) ::
          {:ok, map()} | error
  def delete_self_service_profile(id, %Config{} = config) do
    SelfServiceProfiles.delete(id, config)
  end

  @doc """
  Updates a self-service profile.

  ## body properties to note
  The request body is sent as given. These properties have a non-GA lifecycle in the Auth0 specification:
  - `user_attribute_profile_id` (Early Access)

  ## see
  https://auth0.com/docs/api/management/v2/self-service-profiles/patch-self-service-profiles-by-id

  """
  @spec update_self_service_profile(id, map(), config) ::
          {:ok, map()} | error
  def update_self_service_profile(id, %{} = params, %Config{} = config) do
    SelfServiceProfiles.update(id, params, config)
  end

  @doc """
  Creates an sso-access ticket to initiate the Self Service SSO Flow using a self-service profile.

  ## options
  - `:custom_domain` - sent as the `auth0-custom-domain` header so that Auth0 uses
    this custom domain (host name, optionally with a port) for links it generates.
    An invalid value raises `ArgumentError`.

  ## see
  https://auth0.com/docs/api/management/v2/self-service-profiles/post-sso-ticket

  """
  @spec create_self_service_profile_sso_ticket(id, map(), config, request_opts) ::
          {:ok, map()} | error
  def create_self_service_profile_sso_ticket(id, %{} = params, %Config{} = config, opts \\ []) do
    SelfServiceProfiles.create_sso_ticket(id, params, config, opts)
  end

  @doc """
  Get custom text for a self-service profile.

  Retrieves text customizations for a given self-service profile, language and Self-Service Enterprise Configuration flow page.

  Path parameters are percent-encoded before they are placed in the request path.

  ## see
  https://auth0.com/docs/api/management/v2/self-service-profiles/get-self-service-profile-custom-text

  """
  @spec get_self_service_profile_custom_text(String.t(), String.t(), String.t(), config) ::
          {:ok, map()} | error
  def get_self_service_profile_custom_text(id, language, page, %Config{} = config \\ %Config{}) do
    SelfServiceProfiles.get_custom_text(id, language, page, config)
  end

  @doc """
  Set custom text for a self-service profile.

  Updates text customizations for a given self-service profile, language and Self-Service Enterprise Configuration flow page.

  Path parameters are percent-encoded before they are placed in the request path.

  ## see
  https://auth0.com/docs/api/management/v2/self-service-profiles/put-self-service-profile-custom-text

  """
  @spec set_self_service_profile_custom_text(String.t(), String.t(), String.t(), map(), config) ::
          {:ok, map()} | error
  def set_self_service_profile_custom_text(
        id,
        language,
        page,
        %{} = params \\ %{},
        %Config{} = config \\ %Config{}
      ) do
    SelfServiceProfiles.set_custom_text(id, language, page, params, config)
  end

  @doc """
  Revoke a Self-Service Enterprise Configuration access ticket.

  Revokes a Self-Service Enterprise Configuration access ticket and invalidates associated sessions. The ticket will no longer be accepted to initiate a Self-Service Enterprise Configuration session. If any users have already started a session through this ticket, their session will be terminated. Clients should expect a `202 Accepted` response upon successful processing, indicating that the request has been acknowledged and that the revocation is underway but may not be fully completed at the ...

  Path parameters are percent-encoded before they are placed in the request path.

  ## see
  https://auth0.com/docs/api/management/v2/self-service-profiles/post-revoke

  """
  @spec revoke_self_service_profile_sso_ticket(String.t(), String.t(), config) ::
          {:ok, String.t()} | error
  def revoke_self_service_profile_sso_ticket(profile_id, id, %Config{} = config \\ %Config{}) do
    SelfServiceProfiles.revoke_sso_ticket(profile_id, id, config)
  end

  @doc """
  Retrieve session information.

  ## see
  https://auth0.com/docs/api/management/v2/sessions/get-session

  """
  @spec get_session(id, config) ::
          {:ok, map()} | error
  def get_session(id, %Config{} = config \\ %Config{}) do
    Sessions.get(id, config)
  end

  @doc """
  Delete a session by ID.

  ## see
  https://auth0.com/docs/api/management/v2/sessions/delete-session

  """
  @spec delete_session(id, config) ::
          {:ok, String.t()} | error
  def delete_session(id, %Config{} = config \\ %Config{}) do
    Sessions.delete(id, config)
  end

  @doc """
  Revokes a session by ID and all associated refresh tokens.

  ## see
  https://auth0.com/docs/api/management/v2/sessions/revoke-session

  """
  @spec revoke_session(id, config) ::
          {:ok, String.t()} | error
  def revoke_session(id, %Config{} = config \\ %Config{}) do
    Sessions.revoke(id, config)
  end

  @doc """
  Update session information.

  ## see
  https://auth0.com/docs/api/management/v2/sessions/patch-sessions-by-id

  """
  @spec update_session(id, map(), config) :: {:ok, map()} | error
  def update_session(id, %{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Sessions.update(id, params, config)
  end

  @doc """
  Retrieve the number of active users that logged in during the last 30 days.

  The response body is returned as the raw string (for example `{:ok, "123"}`),
  it is not decoded to an integer.

  ## see
  https://auth0.com/docs/api/management/v2/stats/get-active-users

  """
  @spec get_active_users_count(config) :: {:ok, String.t()} | error
  def get_active_users_count(%Config{} = config \\ %Config{}) do
    Stats.count_active_users(config)
  end

  @doc """
  Retrieve the number of logins, signups and breached-password detections (subscription required) that occurred each day within a specified date range.

  ## query parameters
  - `from`
  - `to`

  Query parameters can be passed as a map: `get_daily_stats(params)` or
  `get_daily_stats(params, config)`.

  ## see
  https://auth0.com/docs/api/management/v2/stats/get-daily

  """
  @spec get_daily_stats(config | map()) :: {:ok, list(map())} | error
  def get_daily_stats(config_or_params \\ %Config{})

  def get_daily_stats(%Config{} = config) do
    Stats.list_daily(%{}, config)
  end

  def get_daily_stats(%{} = params) do
    Stats.list_daily(params, %Config{})
  end

  @spec get_daily_stats(map(), config) :: {:ok, list(map())} | error
  def get_daily_stats(%{} = params, %Config{} = config) do
    Stats.list_daily(params, config)
  end

  @doc """
  Retrieve tenant settings. A list of fields to include or exclude may also be specified.

  ## query parameters
  - `fields`
  - `include_fields`

  ## see
  https://auth0.com/docs/api/management/v2/tenants/tenant-settings-route

  """
  @spec get_tenant_setting(map(), config) ::
          {:ok, map()} | error
  def get_tenant_setting(%{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Tenants.get_setting(params, config)
  end

  @doc """
  Update settings for a tenant.

  ## body properties to note
  The request body is sent as given. These properties have a non-GA lifecycle in the Auth0 specification:
  - `access_token` (Early Access)
  - `client_id_metadata_document_supported` (Early Access)
  - `default_token_quota` (Early Access)
  - `include_session_metadata_in_tenant_logs` (Early Access)

  ## see
  https://auth0.com/docs/api/management/v2/tenants/patch-settings

  """
  @spec update_tenant_setting(map(), config) ::
          {:ok, map()} | error
  def update_tenant_setting(%{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Tenants.update_setting(params, config)
  end

  @doc """
  Create an email verification ticket for a given user. An email verification ticket is a generated URL that the user can consume to verify their email address.

  ## options
  - `:custom_domain` - sent as the `auth0-custom-domain` header so that Auth0 uses
    this custom domain (host name, optionally with a port) for links it generates.
    An invalid value raises `ArgumentError`.

  ## see
  https://auth0.com/docs/api/management/v2/tickets/post-email-verification

  """
  @spec create_email_verification_ticket(map(), config, request_opts) ::
          {:ok, map()} | error
  def create_email_verification_ticket(
        %{} = params \\ %{},
        %Config{} = config \\ %Config{},
        opts \\ []
      ) do
    Tickets.create_email_verification(params, config, opts)
  end

  @doc """
  Create a password change ticket for a given user. A password change ticket is a generated URL that the user can consume to start a reset password flow.

  ## body properties to note
  The request body is sent as given. These properties have a non-GA lifecycle in the Auth0 specification:
  - `identity` (Early Access)

  ## options
  - `:custom_domain` - sent as the `auth0-custom-domain` header so that Auth0 uses
    this custom domain (host name, optionally with a port) for links it generates.
    An invalid value raises `ArgumentError`.

  ## see
  https://auth0.com/docs/api/management/v2/tickets/post-password-change

  """
  @spec create_password_change_ticket(map(), config, request_opts) ::
          {:ok, map()} | error
  def create_password_change_ticket(
        %{} = params \\ %{},
        %Config{} = config \\ %Config{},
        opts \\ []
      ) do
    Tickets.create_password_change(params, config, opts)
  end

  @doc """
  Retrieve details of all Brute-force Protection blocks for a user with the given identifier (username, phone number, or email).

  ## query parameters
  - `identifier` (required)
  - `consider_brute_force_enablement`

  ## see
  https://auth0.com/docs/api/management/v2/user-blocks/get-user-blocks

  """
  @spec get_user_block(map(), config) ::
          {:ok, map()} | error
  def get_user_block(%{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    UserBlocks.get(params, config)
  end

  @doc """
  Remove all Brute-force Protection blocks for the user with the given identifier (username, phone number, or email).

  ## query parameters
  - `identifier` (required)

  ## see
  https://auth0.com/docs/api/management/v2/user-blocks/delete-user-blocks

  """
  @spec unblock_user_block(map(), config) ::
          {:ok, String.t()} | error
  def unblock_user_block(%{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    UserBlocks.unblock(params, config)
  end

  @doc """
  Retrieve details of all Brute-force Protection blocks for the user with the given ID.

  ## query parameters
  - `consider_brute_force_enablement`

  ## see
  https://auth0.com/docs/api/management/v2/user-blocks/get-user-blocks-by-id

  """
  @spec get_user_block_by_user_id(id, map(), config) ::
          {:ok, map()} | error
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

  ## query parameters
  - `page`
  - `per_page`
  - `include_totals`
  - `sort`
  - `connection`
  - `fields`
  - `include_fields`
  - `q`
  - `search_engine`
  - `primary_order`

  ## see
  https://auth0.com/docs/api/management/v2/users/get-users

  """
  @spec get_users(map(), config) ::
          {:ok, list(map()) | map()} | error
  def get_users(%{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Users.list(params, config)
  end

  @doc """
  Create a new user for a given database or passwordless connection.

  ## options
  - `:custom_domain` - sent as the `auth0-custom-domain` header so that Auth0 uses
    this custom domain (host name, optionally with a port) for links it generates.
    An invalid value raises `ArgumentError`.

  ## see
  https://auth0.com/docs/api/management/v2/users/post-users

  """
  @spec create_user(map(), config, request_opts) ::
          {:ok, map()} | error
  def create_user(%{} = params \\ %{}, %Config{} = config \\ %Config{}, opts \\ []) do
    Users.create(params, config, opts)
  end

  @doc """
  Retrieve a list of token exchange profiles.

  ## query parameters
  - `from`
  - `take`

  ## see
  https://auth0.com/docs/api/management/v2/token-exchange-profiles/get-token-exchange-profiles
  """
  @spec get_token_exchange_profiles(map(), config) :: {:ok, list(map())} | error
  def get_token_exchange_profiles(%{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    TokenExchangeProfiles.list(params, config)
  end

  @doc """
  Create a token exchange profile.

  ## see
  https://auth0.com/docs/api/management/v2/token-exchange-profiles/post-token-exchange-profiles
  """
  @spec create_token_exchange_profile(map(), config) :: {:ok, map()} | error
  def create_token_exchange_profile(%{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    TokenExchangeProfiles.create(params, config)
  end

  @doc """
  Retrieve a token exchange profile by its ID.

  ## see
  https://auth0.com/docs/api/management/v2/token-exchange-profiles/get-token-exchange-profiles-by-id
  """
  @spec get_token_exchange_profile(id, config) :: {:ok, map()} | error
  def get_token_exchange_profile(id, %Config{} = config \\ %Config{}) do
    TokenExchangeProfiles.get(id, config)
  end

  @doc """
  Delete a token exchange profile.

  ## see
  https://auth0.com/docs/api/management/v2/token-exchange-profiles/delete-token-exchange-profiles-by-id
  """
  @spec delete_token_exchange_profile(id, config) :: {:ok, String.t()} | error
  def delete_token_exchange_profile(id, %Config{} = config \\ %Config{}) do
    TokenExchangeProfiles.delete(id, config)
  end

  @doc """
  Update a token exchange profile.

  ## see
  https://auth0.com/docs/api/management/v2/token-exchange-profiles/patch-token-exchange-profiles-by-id
  """
  @spec update_token_exchange_profile(id, map(), config) :: {:ok, map()} | error
  def update_token_exchange_profile(id, %{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    TokenExchangeProfiles.update(id, params, config)
  end

  @doc """
  Retrieve a list of verifiable credentials.

  ## see
  https://auth0.com/docs/api/management/v2/verifiable-credentials/get-verifiable-credentials
  """
  @spec get_verifiable_credentials(map(), config) :: {:ok, list(map())} | error
  def get_verifiable_credentials(%{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    VerifiableCredentials.list(params, config)
  end

  @doc """
  Create a verifiable credential.

  ## see
  https://auth0.com/docs/api/management/v2/verifiable-credentials/post-verifiable-credentials
  """
  @spec create_verifiable_credential(map(), config) :: {:ok, map()} | error
  def create_verifiable_credential(%{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    VerifiableCredentials.create(params, config)
  end

  @doc """
  Retrieve a verifiable credential by its ID.

  ## see
  https://auth0.com/docs/api/management/v2/verifiable-credentials/get-verifiable-credentials-by-id
  """
  @spec get_verifiable_credential(id, config) :: {:ok, map()} | error
  def get_verifiable_credential(id, %Config{} = config \\ %Config{}) do
    VerifiableCredentials.get(id, config)
  end

  @doc """
  Delete a verifiable credential.

  ## see
  https://auth0.com/docs/api/management/v2/verifiable-credentials/delete-verifiable-credentials-by-id
  """
  @spec delete_verifiable_credential(id, config) :: {:ok, String.t()} | error
  def delete_verifiable_credential(id, %Config{} = config \\ %Config{}) do
    VerifiableCredentials.delete(id, config)
  end

  @doc """
  Update a verifiable credential.

  ## see
  https://auth0.com/docs/api/management/v2/verifiable-credentials/patch-verifiable-credentials-by-id
  """
  @spec update_verifiable_credential(id, map(), config) :: {:ok, map()} | error
  def update_verifiable_credential(id, %{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    VerifiableCredentials.update(id, params, config)
  end

  @doc """
  Retrieve a list of user attribute profiles.

  ## query parameters
  - `from`
  - `take`

  ## see
  https://auth0.com/docs/api/management/v2/user-attribute-profiles/get-user-attribute-profiles
  """
  @spec get_user_attribute_profiles(map(), config) :: {:ok, list(map())} | error
  def get_user_attribute_profiles(%{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    UserAttributeProfiles.list(params, config)
  end

  @doc """
  Create a user attribute profile.

  ## see
  https://auth0.com/docs/api/management/v2/user-attribute-profiles/post-user-attribute-profiles
  """
  @spec create_user_attribute_profile(map(), config) :: {:ok, map()} | error
  def create_user_attribute_profile(%{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    UserAttributeProfiles.create(params, config)
  end

  @doc """
  Retrieve a user attribute profile by its ID.

  ## see
  https://auth0.com/docs/api/management/v2/user-attribute-profiles/get-user-attribute-profiles-by-id
  """
  @spec get_user_attribute_profile(id, config) :: {:ok, map()} | error
  def get_user_attribute_profile(id, %Config{} = config \\ %Config{}) do
    UserAttributeProfiles.get(id, config)
  end

  @doc """
  Delete a user attribute profile.

  ## see
  https://auth0.com/docs/api/management/v2/user-attribute-profiles/delete-user-attribute-profiles-by-id
  """
  @spec delete_user_attribute_profile(id, config) :: {:ok, String.t()} | error
  def delete_user_attribute_profile(id, %Config{} = config \\ %Config{}) do
    UserAttributeProfiles.delete(id, config)
  end

  @doc """
  Update a user attribute profile.

  ## see
  https://auth0.com/docs/api/management/v2/user-attribute-profiles/patch-user-attribute-profiles-by-id
  """
  @spec update_user_attribute_profile(id, map(), config) :: {:ok, map()} | error
  def update_user_attribute_profile(id, %{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    UserAttributeProfiles.update(id, params, config)
  end

  @doc """
  Get User Attribute Profile Templates.

  Retrieve a list of User Attribute Profile Templates.

  **Early Access**: this endpoint is marked as Early Access (`x-release-lifecycle: EA`) in the Auth0 Management API specification and may not be available on every tenant.

  ## see
  https://auth0.com/docs/api/management/v2/user-attribute-profiles/get-user-attribute-profile-templates

  """
  @spec get_user_attribute_profile_templates(config) :: {:ok, map()} | error
  def get_user_attribute_profile_templates(%Config{} = config \\ %Config{}) do
    UserAttributeProfiles.list_templates(config)
  end

  @doc """
  Get User Attribute Profile Template.

  Retrieve a User Attribute Profile Template.

  **Early Access**: this endpoint is marked as Early Access (`x-release-lifecycle: EA`) in the Auth0 Management API specification and may not be available on every tenant.

  Path parameters are percent-encoded before they are placed in the request path.

  ## see
  https://auth0.com/docs/api/management/v2/user-attribute-profiles/get-user-attribute-profile-template

  """
  @spec get_user_attribute_profile_template(String.t(), config) :: {:ok, map()} | error
  def get_user_attribute_profile_template(id, %Config{} = config \\ %Config{}) do
    UserAttributeProfiles.get_template(id, config)
  end

  @doc """
  Retrieve user details. A list of fields to include or exclude may also be specified.

  ## query parameters
  - `fields`
  - `include_fields`

  ## see
  https://auth0.com/docs/api/management/v2/users/get-users-by-id

  """
  @spec get_user(id, map(), config) ::
          {:ok, map()} | error
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

  ## options
  - `:custom_domain` - sent as the `auth0-custom-domain` header so that Auth0 uses
    this custom domain (host name, optionally with a port) for links it generates.
    An invalid value raises `ArgumentError`.

  ## see
  https://auth0.com/docs/api/management/v2/users/patch-users-by-id

  """
  @spec update_user(id, map(), config, request_opts) ::
          {:ok, map()} | error
  def update_user(id, %{} = params \\ %{}, %Config{} = config \\ %Config{}, opts \\ []) do
    Users.update(id, params, config, opts)
  end

  @doc """
  Retrieve detailed list of authentication methods associated with a specified user.

  ## query parameters
  - `page`
  - `per_page`
  - `include_totals`

  ## see
  https://auth0.com/docs/api/management/v2/users/get-authentication-methods

  """
  @spec list_user_authentication_methods(id, map(), config) ::
          {:ok, list(map()) | map()} | error
  def list_user_authentication_methods(id, %{} = params, %Config{} = config) do
    Users.list_authentication_methods(id, params, config)
  end

  @doc """
  Remove all authentication methods (i.e., enrolled MFA factors) from the specified user account. This action cannot be undone.

  ## see
  https://auth0.com/docs/api/management/v2/users/delete-authentication-methods

  """
  @spec delete_user_authentication_methods(id, config) ::
          {:ok, String.t()} | error
  def delete_user_authentication_methods(id, %Config{} = config) do
    Users.delete_authentication_methods(id, config)
  end

  @doc """
  Create an authentication method. Authentication methods created via this endpoint will be auto confirmed and should already have verification completed.

  ## see
  https://auth0.com/docs/api/management/v2/users/post-authentication-methods

  """
  @spec create_user_authentication_methods(id, map(), config) ::
          {:ok, map()} | error
  def create_user_authentication_methods(id, %{} = params, %Config{} = config) do
    Users.create_authentication_methods(id, params, config)
  end

  @doc """
  Replace the specified user authentication methods with supplied values.

  ## see
  https://auth0.com/docs/api/management/v2/users/put-authentication-methods

  """
  @spec update_user_authentication_methods(id, map(), config) ::
          {:ok, list(map())} | error
  def update_user_authentication_methods(id, %{} = params, %Config{} = config) do
    Users.update_authentication_methods(id, params, config)
  end

  @doc """
  Get an authentication method by ID

  ## see
  https://auth0.com/docs/api/management/v2/users/get-authentication-methods-by-authentication-method-id

  """
  @spec get_user_authentication_method(id, authentication_method_id, config) ::
          {:ok, map()} | error
  def get_user_authentication_method(id, authentication_method_id, %Config{} = config) do
    Users.get_authentication_method(id, authentication_method_id, config)
  end

  @doc """
  Remove the authentication method with the given ID from the specified user.

  ## see
  https://auth0.com/docs/api/management/v2/users/delete-authentication-methods-by-authentication-method-id

  """
  @spec delete_user_authentication_method(id, authentication_method_id, config) ::
          {:ok, String.t()} | error
  def delete_user_authentication_method(id, authentication_method_id, %Config{} = config) do
    Users.delete_authentication_method(id, authentication_method_id, config)
  end

  @doc """
  Modify the authentication method with the given ID from the specified user.

  ## see
  https://auth0.com/docs/api/management/v2/users/patch-authentication-methods-by-authentication-method-id

  """
  @spec update_user_authentication_method(id, authentication_method_id, map(), config) ::
          {:ok, map()} | error
  def update_user_authentication_method(
        id,
        authentication_method_id,
        %{} = params,
        %Config{} = config
      ) do
    Users.update_authentication_method(id, authentication_method_id, params, config)
  end

  @doc """
  Remove all authenticators registered to a given user ID, such as OTP, email, phone, and push-notification. This action cannot be undone.

  ## see
  https://auth0.com/docs/api/management/v2/users/delete-authenticators

  """
  @spec delete_user_authenticators(id, config) ::
          {:ok, String.t()} | error
  def delete_user_authenticators(id, %Config{} = config) do
    Users.delete_authenticators(id, config)
  end

  @doc """
  Retrieve the first multi-factor authentication enrollment that a specific user has confirmed.

  ## see
  https://auth0.com/docs/api/management/v2/users/get-enrollments

  """
  @spec get_user_enrollments(id, config) ::
          {:ok, list(map())} | error
  def get_user_enrollments(id, %Config{} = config \\ %Config{}) do
    Users.get_enrollments(id, config)
  end

  @doc """
  Link two user accounts together forming a primary and secondary relationship. On successful linking, the endpoint returns the new array of the primary account identities.

  ## see
  https://auth0.com/docs/api/management/v2/users/post-identities

  """
  @spec link_user_identities(id, map(), config) ::
          {:ok, list(map())} | error
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
          {:ok, list(map())} | error
  def unlink_user_identities(
        id,
        provider,
        user_id,
        %Config{} = config \\ %Config{}
      ) do
    Users.unlink_identities(id, provider, user_id, config)
  end

  @doc """
  Retrieve log events for a specific user.

  ## query parameters
  - `page`
  - `per_page`
  - `sort`
  - `include_totals`

  ## see
  https://auth0.com/docs/api/management/v2/users/get-logs-by-user

  """
  @spec get_user_logs(id, map(), config) ::
          {:ok, list(map()) | map()} | error
  def get_user_logs(id, %{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Users.get_logs(id, params, config)
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
  Remove a multifactor authentication configuration from a user's account. This forces the user to manually reconfigure the multi-factor provider.

  ## see
  https://auth0.com/docs/api/management/v2/users/delete-multifactor-by-provider

  """
  # The default `params` (`%{}`) has no required key, so the delete_user_multifactor/1 clause
  # generated by the default argument can never succeed. It is kept only for
  # backward compatibility (no public arity is removed), hence the warning is
  # suppressed for that arity only.
  @dialyzer {:nowarn_function, [{:delete_user_multifactor, 1}]}
  @spec delete_user_multifactor(id, provider_params, config) ::
          {:ok, String.t()} | error
  def delete_user_multifactor(
        id,
        %{} = params \\ %{},
        %Config{} = config \\ %Config{}
      ) do
    Users.delete_multifactor(id, params, config)
  end

  @doc """
  Retrieve list of the specified user's current Organization memberships. User must be specified by user ID.

  ## query parameters
  - `page`
  - `per_page`
  - `include_totals`
  - `from`
  - `take`

  ## see
  https://auth0.com/docs/api/management/v2/users/get-user-organizations

  """
  @spec get_user_organizations(id, map(), config) ::
          {:ok, list(map()) | map()} | error
  def get_user_organizations(id, %{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Users.get_organizations(id, params, config)
  end

  @doc """
  Retrieve all permissions associated with the user.

  ## query parameters
  - `per_page`
  - `page`
  - `include_totals`

  ## see
  https://auth0.com/docs/api/management/v2/users/get-permissions

  """
  @spec get_user_permissions(id, map(), config) ::
          {:ok, list(map()) | map()} | error
  def get_user_permissions(id, %{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Users.get_permissions(id, params, config)
  end

  @doc """
  Remove permissions from a user.

  ## see
  https://auth0.com/docs/api/management/v2/users/delete-permissions

  """
  @spec remove_user_permissions(id, map(), config) ::
          {:ok, String.t()} | error
  def remove_user_permissions(id, %{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Users.remove_permissions(id, params, config)
  end

  @doc """
  Assign permissions to a user.

  ## see
  https://auth0.com/docs/api/management/v2/users/post-permissions

  """
  @spec assign_user_permissions(id, map(), config) ::
          {:ok, String.t()} | error
  def assign_user_permissions(id, %{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Users.assign_permissions(id, params, config)
  end

  @doc """
  Remove an existing multi-factor authentication (MFA) recovery code and generate a new one. If a user cannot access the original device or account used for MFA enrollment, they can use a recovery code to authenticate.

  ## see
  https://auth0.com/docs/api/management/v2/users/post-recovery-code-regeneration

  """
  @spec regenerate_user_recovery_code(id, config) ::
          {:ok, map()} | error
  def regenerate_user_recovery_code(
        id,
        %Config{} = config \\ %Config{}
      ) do
    Users.regenerate_recovery_code(id, config)
  end

  @doc """
  Revokes selected resources related to a user (sessions, refresh tokens, ...).

  ## see
  https://auth0.com/docs/api/management/v2/users/user-revoke-access

  """
  @spec revoke_user_selected_resources(id, map(), config) ::
          {:ok, String.t()} | error
  def revoke_user_selected_resources(id, %{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Users.revoke_selected_resources(id, params, config)
  end

  @doc """
  Retrieve detailed list of all user roles currently assigned to a user.

  ## query parameters
  - `per_page`
  - `page`
  - `include_totals`

  ## see
  https://auth0.com/docs/api/management/v2/users/get-user-roles

  """
  @spec get_user_roles(id, map(), config) ::
          {:ok, list(map()) | map()} | error
  def get_user_roles(id, %{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Users.get_roles(id, params, config)
  end

  @doc """
  Remove one or more specified user roles assigned to a user.

  ## see
  https://auth0.com/docs/api/management/v2/users/delete-user-roles

  """
  @spec remove_user_roles(id, map(), config) ::
          {:ok, String.t()} | error
  def remove_user_roles(id, %{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Users.remove_roles(id, params, config)
  end

  @doc """
  Assign one or more existing user roles to a user.

  ## see
  https://auth0.com/docs/api/management/v2/users/post-user-roles

  """
  @spec assign_user_roles(id, map(), config) ::
          {:ok, String.t()} | error
  def assign_user_roles(id, %{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Users.assign_roles(id, params, config)
  end

  @doc """
  Retrieve details for a user's refresh tokens.

  ## query parameters
  - `include_totals`
  - `from`
  - `take`

  ## see
  https://auth0.com/docs/api/management/v2/users/get-refresh-tokens-for-user

  """
  @spec get_user_refresh_tokens(id, map(), config) ::
          {:ok, map()} | error
  def get_user_refresh_tokens(id, %{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Users.get_refresh_tokens(id, params, config)
  end

  @doc """
  Delete all refresh tokens for a user.

  ## see
  https://auth0.com/docs/api/management/v2/users/delete-refresh-tokens-for-user

  """
  @spec delete_user_refresh_tokens(id, config) ::
          {:ok, String.t()} | error
  def delete_user_refresh_tokens(id, %Config{} = config \\ %Config{}) do
    Users.delete_refresh_tokens(id, config)
  end

  @doc """
  Retrieve details for a user's sessions.

  ## query parameters
  - `include_totals`
  - `from`
  - `take`

  ## see
  https://auth0.com/docs/api/management/v2/users/get-sessions-for-user

  """
  @spec get_user_sessions(id, map(), config) ::
          {:ok, map()} | error
  def get_user_sessions(id, %{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Users.get_sessions(id, params, config)
  end

  @doc """
  Delete all sessions for a user.

  ## see
  https://auth0.com/docs/api/management/v2/users/delete-sessions-for-user

  """
  @spec delete_user_sessions(id, config) ::
          {:ok, String.t()} | error
  def delete_user_sessions(id, %Config{} = config \\ %Config{}) do
    Users.delete_sessions(id, config)
  end

  @doc """
  Get a User's Connected Accounts.

  Retrieve all connected accounts associated with the user.

  ## query parameters
  - `from`
  - `take`

  Path parameters are percent-encoded before they are placed in the request path.

  ## see
  https://auth0.com/docs/api/management/v2/users/get-connected-accounts

  """
  @spec get_user_connected_accounts(String.t(), map(), config) :: {:ok, map()} | error
  def get_user_connected_accounts(id, %{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Users.list_connected_accounts(id, params, config)
  end

  @doc """
  List the permissions assigned to a user directly or through roles or groups.

  Returns the list of effective permissions for a user, taking into account permissions granted directly to the user, as well as those inherited through roles and group memberships.

  ## query parameters
  - `from`
  - `take`
  - `resource_server_identifier`

  Path parameters are percent-encoded before they are placed in the request path.

  ## see
  https://auth0.com/docs/api/management/v2/users/get-user-effective-permissions

  """
  @spec get_user_effective_permissions(String.t(), map(), config) :: {:ok, map()} | error
  def get_user_effective_permissions(id, %{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Users.list_effective_permissions(id, params, config)
  end

  @doc """
  List the roles which grant the user a given permission (whether directly or through groups).

  Lists the roles which grant the user a given permission, including roles assigned directly to the user and those inherited through group memberships.

  ## query parameters
  - `from`
  - `take`
  - `resource_server_identifier`
  - `permission_name`

  Path parameters are percent-encoded before they are placed in the request path.

  ## see
  https://auth0.com/docs/api/management/v2/users/get-user-effective-permission-role-sources

  """
  @spec get_user_effective_permission_role_sources(String.t(), map(), config) ::
          {:ok, map()} | error
  def get_user_effective_permission_role_sources(
        id,
        %{} = params \\ %{},
        %Config{} = config \\ %Config{}
      ) do
    Users.list_effective_permission_role_sources(id, params, config)
  end

  @doc """
  List the roles for a user with sources: directly assigned or through group membership.

  Retrieve detailed list of effective roles for a user, including roles assigned directly and through group memberships.

  ## query parameters
  - `from`
  - `take`

  Path parameters are percent-encoded before they are placed in the request path.

  ## see
  https://auth0.com/docs/api/management/v2/users/get-user-effective-roles

  """
  @spec get_user_effective_roles(String.t(), map(), config) :: {:ok, map()} | error
  def get_user_effective_roles(id, %{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Users.list_effective_roles(id, params, config)
  end

  @doc """
  Get a user's role source groups.

  Lists the groups that grant a user a specific role.

  ## query parameters
  - `role_id`
  - `from`
  - `take`

  Path parameters are percent-encoded before they are placed in the request path.

  ## see
  https://auth0.com/docs/api/management/v2/users/get-user-role-source-groups

  """
  @spec get_user_effective_role_group_sources(String.t(), map(), config) :: {:ok, map()} | error
  def get_user_effective_role_group_sources(
        id,
        %{} = params \\ %{},
        %Config{} = config \\ %Config{}
      ) do
    Users.list_effective_role_group_sources(id, params, config)
  end

  @doc """
  Get user's groups.

  List all groups to which this user belongs.

  ## query parameters
  - `fields`
  - `include_fields`
  - `page`
  - `per_page`
  - `include_totals`
  - `from`
  - `take`

  Path parameters are percent-encoded before they are placed in the request path.

  ## see
  https://auth0.com/docs/api/management/v2/users/get-user-groups

  """
  @spec get_user_groups(String.t(), map(), config) :: {:ok, map() | list(map())} | error
  def get_user_groups(id, %{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Users.list_groups(id, params, config)
  end

  @doc """
  Clear risk assessment assessors for a specific user.

  Path parameters are percent-encoded before they are placed in the request path.

  ## see
  https://auth0.com/docs/api/management/v2/users/post-clear-assessors

  """
  @spec clear_user_risk_assessments(String.t(), map(), config) :: {:ok, String.t()} | error
  def clear_user_risk_assessments(id, %{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    Users.clear_risk_assessments(id, params, config)
  end

  @doc """
  Find users by email. If Auth0 is the identity provider (idP), the email address associated with a user is saved in lower case, regardless of how you initially provided it.

  ## query parameters
  - `fields`
  - `include_fields`
  - `email` (required)

  ## see
  https://auth0.com/docs/api/management/v2/users-by-email/get-users-by-email

  """
  @spec get_users_by_email(map(), config) ::
          {:ok, list(map())} | error
  def get_users_by_email(%{} = params \\ %{}, %Config{} = config \\ %Config{}) do
    UsersByEmail.list(params, config)
  end
end
