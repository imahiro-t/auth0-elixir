defmodule Auth0.Management.Actions do
  @moduledoc """
  Documentation for Auth0 Management API of Actions.

  ## endpoint
  - /api/v2/actions/actions
  - /api/v2/actions/status
  - /api/v2/actions/triggers
  - /api/v2/actions/actions/{id}
  - /api/v2/actions/executions/{id}
  - /api/v2/actions/actions/{actionId}/versions
  - /api/v2/actions/triggers/{triggerId}/bindings
  - /api/v2/actions/actions/{actionId}/versions/{id}
  - /api/v2/actions/actions/{id}/test
  - /api/v2/actions/actions/{id}/deploy
  - /api/v2/actions/actions/{actionId}/versions/{id}/deploy
  """

  alias Auth0.Config
  alias Auth0.Entity
  alias Auth0.Management.Actions.List
  alias Auth0.Management.Actions.Create
  alias Auth0.Management.Actions.Get
  alias Auth0.Management.Actions.Delete
  alias Auth0.Management.Actions.Patch
  alias Auth0.Management.Actions.Test
  alias Auth0.Management.Actions.Deploy
  alias Auth0.Management.Actions.Versions
  alias Auth0.Management.Actions.Triggers
  alias Auth0.Management.Actions.Status
  alias Auth0.Management.Actions.Execution

  @type config :: Config.t()
  @type id :: String.t()
  @type action_id :: String.t()
  @type trigger_id :: String.t()
  @type response_body :: String.t()
  @type error :: {:error, integer, term} | {:error, term}

  @endpoint "/api/v2/actions/actions"
  @endpoint_by_id "/api/v2/actions/actions/{id}"
  @endpoint_versions "/api/v2/actions/actions/{actionId}/versions"
  @endpoint_versions_by_id "/api/v2/actions/actions/{actionId}/versions/{id}"
  @endpoint_versions_deploy "/api/v2/actions/actions/{actionId}/versions/{id}/deploy"
  @endpoint_test "/api/v2/actions/actions/{id}/test"
  @endpoint_deploy "/api/v2/actions/actions/{id}/deploy"
  @endpoint_triggers "/api/v2/actions/triggers"
  @endpoint_triggers_bindings "/api/v2/actions/triggers/{triggerId}/bindings"
  @endpoint_status "/api/v2/actions/status"
  @endpoint_executions_by_id "/api/v2/actions/executions/{id}"

  @doc """
  Get actions.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Actions/get_actions

  """
  @spec list(List.Params.t(), config) ::
          {:ok, Entity.Actions.t(), response_body} | error
  def list(%List.Params{} = params, %Config{} = config) do
    List.execute(@endpoint, params, config)
  end

  @doc """
  Create an action.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Actions/post_action

  """
  @spec create(Create.Params.t(), config) ::
          {:ok, Entity.Action.t(), response_body} | error
  def create(%Create.Params{} = params, %Config{} = config) do
    Create.execute(@endpoint, params, config)
  end

  @doc """
  Get an action.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Actions/get_action

  """
  @spec get(id, config) :: {:ok, Entity.Action.t(), response_body} | error
  def get(id, %Config{} = config) do
    Get.execute(@endpoint_by_id, id, config)
  end

  @doc """
  Delete an action.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Actions/delete_action

  """
  @spec delete(id, Delete.Params.t(), config) :: {:ok, String.t(), response_body} | error
  def delete(id, %Delete.Params{} = params, %Config{} = config) do
    Delete.execute(@endpoint_by_id, id, params, config)
  end

  @doc """
  Update an action.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Actions/patch_action

  """
  @spec update(id, Patch.Params.t(), config) ::
          {:ok, Entity.Action.t(), response_body} | error
  def update(id, %Patch.Params{} = params, %Config{} = config) do
    Patch.execute(@endpoint_by_id, id, params, config)
  end

  @doc """
  Get an action's versions.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Actions/get_action_versions

  """
  @spec list_versions(action_id, Versions.List.Params.t(), config) ::
          {:ok, Entity.ActionVersions.t(), response_body} | error
  def list_versions(action_id, %Versions.List.Params{} = params, %Config{} = config) do
    Versions.List.execute(@endpoint_versions, action_id, params, config)
  end

  @doc """
  Get a specific version of an action.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Actions/get_action_version

  """
  @spec get_version(action_id, id, config) ::
          {:ok, Entity.ActionVersion.t(), response_body} | error
  def get_version(action_id, id, %Config{} = config) do
    Versions.Get.execute(@endpoint_versions_by_id, action_id, id, config)
  end

  @doc """
  Roll back to a previous action version.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Actions/post_deploy_draft_version

  """
  @spec rollback_version(action_id, id, Versions.Rollback.Params.t(), config) ::
          {:ok, Entity.ActionVersion.t(), response_body} | error
  def rollback_version(action_id, id, %Versions.Rollback.Params{} = params, %Config{} = config) do
    Versions.Rollback.execute(@endpoint_versions_deploy, action_id, id, params, config)
  end

  @doc """
  Test an Action.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Actions/post_test_action

  """
  @spec test(id, Test.Params.t(), config) ::
          {:ok, Entity.ActionTest.t(), response_body} | error
  def test(id, %Test.Params{} = params, %Config{} = config) do
    Test.execute(@endpoint_test, id, params, config)
  end

  @doc """
  Deploy an action.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Actions/post_deploy_action

  """
  @spec deploy(id, config) :: {:ok, Entity.ActionVersion.t(), response_body} | error
  def deploy(id, %Config{} = config) do
    Deploy.execute(@endpoint_deploy, id, config)
  end

  @doc """
  Get triggers.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Actions/get_triggers

  """
  @spec get_triggers(config) ::
          {:ok, Entity.ActionTriggers.t(), response_body} | error
  def get_triggers(%Config{} = config) do
    Triggers.List.execute(@endpoint_triggers, config)
  end

  @doc """
  Get trigger bindings.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Actions/get_bindings

  """
  @spec get_bindings(trigger_id, Triggers.Bindings.List.Params.t(), config) ::
          {:ok, Entity.ActionTriggerBindings.t(), response_body} | error
  def get_bindings(trigger_id, %Triggers.Bindings.List.Params{} = params, %Config{} = config) do
    Triggers.Bindings.List.execute(@endpoint_triggers_bindings, trigger_id, params, config)
  end

  @doc """
  Update trigger bindings.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Actions/patch_bindings

  """
  @spec update_bindings(trigger_id, Triggers.Bindings.Patch.Params.t(), config) ::
          {:ok, Entity.ActionTriggerBindings.t(), response_body} | error
  def update_bindings(trigger_id, %Triggers.Bindings.Patch.Params{} = params, %Config{} = config) do
    Triggers.Bindings.Patch.execute(@endpoint_triggers_bindings, trigger_id, params, config)
  end

  @doc """
  Get actions service status.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Actions/get_service_status

  """
  @spec get_status(config) :: {:ok, Entity.ActionStatus.t(), response_body} | error
  def get_status(%Config{} = config) do
    Status.execute(@endpoint_status, config)
  end

  @doc """
  Get an execution.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Actions/get_execution

  """
  @spec get_execution(id, config) ::
          {:ok, Entity.ActionExecution.t(), response_body} | error
  def get_execution(id, %Config{} = config) do
    Execution.execute(@endpoint_executions_by_id, id, config)
  end
end
