defmodule Auth0.Management.Actions do
  @moduledoc """
  Facade for the Auth0 Management API Actions endpoints.

  Most applications should call `Auth0.Api.Management` instead of this module.
  """

  alias Auth0.Config
  alias Auth0.Management.Actions.List
  alias Auth0.Management.Actions.Create
  alias Auth0.Management.Actions.Get
  alias Auth0.Management.Actions.Delete
  alias Auth0.Management.Actions.Patch
  alias Auth0.Management.Actions.Test
  alias Auth0.Management.Actions.Deploy
  alias Auth0.Management.Actions.Versions
  alias Auth0.Management.Actions.Triggers
  alias Auth0.Management.Actions.Execution
  alias Auth0.Management.Actions.Modules.List, as: ActionsModulesList
  alias Auth0.Management.Actions.Modules.Create, as: ActionsModulesCreate
  alias Auth0.Management.Actions.Modules.Get, as: ActionsModulesGet
  alias Auth0.Management.Actions.Modules.Patch, as: ActionsModulesPatch
  alias Auth0.Management.Actions.Modules.Delete, as: ActionsModulesDelete
  alias Auth0.Management.Actions.Modules.Actions.List, as: ActionsModulesActionsList
  alias Auth0.Management.Actions.Modules.Rollback, as: ActionsModulesRollback
  alias Auth0.Management.Actions.Modules.Versions.List, as: ActionsModulesVersionsList
  alias Auth0.Management.Actions.Modules.Versions.Create, as: ActionsModulesVersionsCreate
  alias Auth0.Management.Actions.Modules.Versions.Get, as: ActionsModulesVersionsGet

  @type config :: Config.t()
  @type id :: String.t()
  @type action_id :: String.t()
  @type trigger_id :: String.t()
  @type error :: {:error, integer, term} | {:error, term}

  @doc """
  Retrieve all actions.

  ## see
  https://auth0.com/docs/api/management/v2/actions/get-actions

  """
  @spec list(map(), config) ::
          {:ok, map()} | error
  def list(%{} = params, %Config{} = config) do
    List.execute(params, config)
  end

  @doc """
  Create an action. Once an action is created, it must be deployed, and then bound to a trigger before it will be executed as part of a flow.

  ## see
  https://auth0.com/docs/api/management/v2/actions/post-action

  """
  @spec create(map(), config) ::
          {:ok, map()} | error
  def create(%{} = params, %Config{} = config) do
    Create.execute(params, config)
  end

  @doc """
  Retrieve all of an action's versions. An action version is created whenever an action is deployed. An action version is immutable, once created.

  ## see
  https://auth0.com/docs/api/management/v2/actions/get-action-versions

  """
  @spec list_versions(action_id, map(), config) ::
          {:ok, map()} | error
  def list_versions(action_id, %{} = params, %Config{} = config) do
    Versions.List.execute(action_id, params, config)
  end

  @doc """
  Retrieve a specific version of an action. An action version is created whenever an action is deployed. An action version is immutable, once created.

  ## see
  https://auth0.com/docs/api/management/v2/actions/get-action-version

  """
  @spec get_version(action_id, id, config) ::
          {:ok, map()} | error
  def get_version(action_id, id, %Config{} = config) do
    Versions.Get.execute(action_id, id, config)
  end

  @doc """
  Performs the equivalent of a roll-back of an action to an earlier, specified version. Creates a new, deployed action version that is identical to the specified version. If this action is currently bound to a trigger, the system will begin executing the newly-created version immediately.

  ## see
  https://auth0.com/docs/api/management/v2/actions/post-deploy-draft-version

  """
  @spec rollback_version(action_id, id, map(), config) ::
          {:ok, map()} | error
  def rollback_version(action_id, id, %{} = params, %Config{} = config) do
    Versions.Rollback.execute(action_id, id, params, config)
  end

  @doc """
  Retrieve an action by its ID.

  ## see
  https://auth0.com/docs/api/management/v2/actions/get-action

  """
  @spec get(id, config) ::
          {:ok, map()} | error
  def get(id, %Config{} = config) do
    Get.execute(id, config)
  end

  @doc """
  Deletes an action and all of its associated versions. An action must be unbound from all triggers before it can be deleted.

  ## see
  https://auth0.com/docs/api/management/v2/actions/delete-action

  """
  @spec delete(id, map(), config) :: {:ok, String.t()} | error
  def delete(id, %{} = params, %Config{} = config) do
    Delete.execute(id, params, config)
  end

  @doc """
  Update an existing action. If this action is currently bound to a trigger, updating it will not affect any user flows until the action is deployed.

  ## see
  https://auth0.com/docs/api/management/v2/actions/patch-action

  """
  @spec update(id, map(), config) ::
          {:ok, map()} | error
  def update(id, %{} = params, %Config{} = config) do
    Patch.execute(id, params, config)
  end

  @doc """
  Deploy an action. Deploying an action will create a new immutable version of the action. If the action is currently bound to a trigger, then the system will begin executing the newly deployed version of the action immediately. Otherwise, the action will only be executed as a part of a flow once it is bound to that flow.

  ## see
  https://auth0.com/docs/api/management/v2/actions/post-deploy-action

  """
  @spec deploy(id, config) ::
          {:ok, map()} | error
  def deploy(id, %Config{} = config) do
    Deploy.execute(id, config)
  end

  @doc """
  Test an action. After updating an action, it can be tested prior to being deployed to ensure it behaves as expected.

  ## see
  https://auth0.com/docs/api/management/v2/actions/post-test-action

  """
  @spec test(id, map(), config) ::
          {:ok, map()} | error
  def test(id, %{} = params, %Config{} = config) do
    Test.execute(id, params, config)
  end

  @doc """
  Retrieve information about a specific execution of a trigger. Relevant execution IDs will be included in tenant logs generated as part of that authentication flow. Executions will only be stored for 10 days after their creation.

  ## see
  https://auth0.com/docs/api/management/v2/actions/get-execution

  """
  @spec get_execution(id, config) ::
          {:ok, map()} | error
  def get_execution(id, %Config{} = config) do
    Execution.execute(id, config)
  end

  @doc """
  Retrieve the set of triggers currently available within actions. A trigger is an extensibility point to which actions can be bound.

  ## see
  https://auth0.com/docs/api/management/v2/actions/get-triggers

  """
  @spec get_triggers(config) ::
          {:ok, map()} | error
  def get_triggers(%Config{} = config) do
    Triggers.List.execute(config)
  end

  @doc """
  Retrieve the actions that are bound to a trigger. Once an action is created and deployed, it must be attached (i.e. bound) to a trigger so that it will be executed as part of a flow. The list of actions returned reflects the order in which they will be executed during the appropriate flow.

  ## see
  https://auth0.com/docs/api/management/v2/actions/get-bindings

  """
  @spec get_bindings(trigger_id, map(), config) ::
          {:ok, map()} | error
  def get_bindings(trigger_id, %{} = params, %Config{} = config) do
    Triggers.Bindings.List.execute(trigger_id, params, config)
  end

  @doc """
  Update the actions that are bound (i.e. attached) to a trigger. Once an action is created and deployed, it must be attached (i.e. bound) to a trigger so that it will be executed as part of a flow. The order in which the actions are provided will determine the order in which they are executed.

  ## see
  https://auth0.com/docs/api/management/v2/actions/patch-bindings

  """
  @spec update_bindings(trigger_id, map(), config) ::
          {:ok, map()} | error
  def update_bindings(trigger_id, %{} = params, %Config{} = config) do
    Triggers.Bindings.Patch.execute(trigger_id, params, config)
  end

  @doc """
  List Actions Modules.

  Retrieve a paginated list of all Actions Modules with optional filtering and totals.

  **Early Access**: this endpoint is marked as Early Access (`x-release-lifecycle: EA`) in the Auth0 Management API specification and may not be available on every tenant.

  ## see
  https://auth0.com/docs/api/management/v2/actions/get-action-modules

  """
  @spec list_modules(map(), config) :: {:ok, map()} | error
  def list_modules(%{} = params, %Config{} = config) do
    ActionsModulesList.execute(params, config)
  end

  @doc """
  Create a new Actions Module.

  Create a new Actions Module for reusable code across actions.

  **Early Access**: this endpoint is marked as Early Access (`x-release-lifecycle: EA`) in the Auth0 Management API specification and may not be available on every tenant.

  ## see
  https://auth0.com/docs/api/management/v2/actions/post-action-module

  """
  @spec create_module(map(), config) :: {:ok, map()} | error
  def create_module(%{} = params, %Config{} = config) do
    ActionsModulesCreate.execute(params, config)
  end

  @doc """
  Get a specific Actions Module by ID.

  Retrieve details of a specific Actions Module by its unique identifier.

  **Early Access**: this endpoint is marked as Early Access (`x-release-lifecycle: EA`) in the Auth0 Management API specification and may not be available on every tenant.

  ## see
  https://auth0.com/docs/api/management/v2/actions/get-action-module

  """
  @spec get_module(String.t(), config) :: {:ok, map()} | error
  def get_module(id, %Config{} = config) do
    ActionsModulesGet.execute(id, config)
  end

  @doc """
  Update a specific Actions Module.

  Update properties of an existing Actions Module, such as code, dependencies, or secrets.

  **Early Access**: this endpoint is marked as Early Access (`x-release-lifecycle: EA`) in the Auth0 Management API specification and may not be available on every tenant.

  ## see
  https://auth0.com/docs/api/management/v2/actions/patch-action-module

  """
  @spec update_module(String.t(), map(), config) :: {:ok, map()} | error
  def update_module(id, %{} = params, %Config{} = config) do
    ActionsModulesPatch.execute(id, params, config)
  end

  @doc """
  Delete a specific Actions Module by ID.

  Permanently delete an Actions Module. This will fail if the module is still in use by any actions.

  **Early Access**: this endpoint is marked as Early Access (`x-release-lifecycle: EA`) in the Auth0 Management API specification and may not be available on every tenant.

  ## see
  https://auth0.com/docs/api/management/v2/actions/delete-action-module

  """
  @spec delete_module(String.t(), config) :: {:ok, String.t()} | error
  def delete_module(id, %Config{} = config) do
    ActionsModulesDelete.execute(id, config)
  end

  @doc """
  List all actions using an Actions Module.

  Lists all actions that are using a specific Actions Module, showing which deployed action versions reference this Actions Module.

  **Early Access**: this endpoint is marked as Early Access (`x-release-lifecycle: EA`) in the Auth0 Management API specification and may not be available on every tenant.

  ## see
  https://auth0.com/docs/api/management/v2/actions/get-action-module-actions

  """
  @spec list_module_actions(String.t(), map(), config) :: {:ok, map()} | error
  def list_module_actions(id, %{} = params, %Config{} = config) do
    ActionsModulesActionsList.execute(id, params, config)
  end

  @doc """
  Rollback an Actions Module to a previous version.

  Rolls back an Actions Module's draft to a previously created version. This action copies the code, dependencies, and secrets from the specified version into the current draft.

  **Early Access**: this endpoint is marked as Early Access (`x-release-lifecycle: EA`) in the Auth0 Management API specification and may not be available on every tenant.

  ## see
  https://auth0.com/docs/api/management/v2/actions/post-action-module-rollback

  """
  @spec rollback_module(String.t(), map(), config) :: {:ok, map()} | error
  def rollback_module(id, %{} = params, %Config{} = config) do
    ActionsModulesRollback.execute(id, params, config)
  end

  @doc """
  List all versions of an Actions Module.

  List all published versions of a specific Actions Module.

  **Early Access**: this endpoint is marked as Early Access (`x-release-lifecycle: EA`) in the Auth0 Management API specification and may not be available on every tenant.

  ## see
  https://auth0.com/docs/api/management/v2/actions/get-action-module-versions

  """
  @spec list_module_versions(String.t(), map(), config) :: {:ok, map()} | error
  def list_module_versions(id, %{} = params, %Config{} = config) do
    ActionsModulesVersionsList.execute(id, params, config)
  end

  @doc """
  Create a new version of an Actions Module.

  Creates a new immutable version of an Actions Module from the current draft version. This publishes the draft as a new version that can be referenced by actions, while maintaining the existing draft for continued development.

  **Early Access**: this endpoint is marked as Early Access (`x-release-lifecycle: EA`) in the Auth0 Management API specification and may not be available on every tenant.

  ## see
  https://auth0.com/docs/api/management/v2/actions/post-action-module-version

  """
  @spec create_module_version(String.t(), config) :: {:ok, map()} | error
  def create_module_version(id, %Config{} = config) do
    ActionsModulesVersionsCreate.execute(id, config)
  end

  @doc """
  Get a specific version of an Actions Module.

  Retrieve the details of a specific, immutable version of an Actions Module.

  **Early Access**: this endpoint is marked as Early Access (`x-release-lifecycle: EA`) in the Auth0 Management API specification and may not be available on every tenant.

  ## see
  https://auth0.com/docs/api/management/v2/actions/get-action-module-version

  """
  @spec get_module_version(String.t(), String.t(), config) :: {:ok, map()} | error
  def get_module_version(id, version_id, %Config{} = config) do
    ActionsModulesVersionsGet.execute(id, version_id, config)
  end
end
