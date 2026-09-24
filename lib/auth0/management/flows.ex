defmodule Auth0.Management.Flows do
  @moduledoc """
  Facade for the Auth0 Management API Flows endpoints.

  Most applications should call `Auth0.Api.Management` instead of this module.
  """

  alias Auth0.Config
  alias Auth0.Management.Flows.List
  alias Auth0.Management.Flows.Create
  alias Auth0.Management.Flows.Get
  alias Auth0.Management.Flows.Patch
  alias Auth0.Management.Flows.Vault.Connections.List, as: FlowsVaultConnectionsList
  alias Auth0.Management.Flows.Vault.Connections.Create, as: FlowsVaultConnectionsCreate
  alias Auth0.Management.Flows.Vault.Connections.Get, as: FlowsVaultConnectionsGet
  alias Auth0.Management.Flows.Vault.Connections.Patch, as: FlowsVaultConnectionsPatch
  alias Auth0.Management.Flows.Vault.Connections.Delete, as: FlowsVaultConnectionsDelete
  alias Auth0.Management.Flows.Executions.List, as: FlowsExecutionsList
  alias Auth0.Management.Flows.Executions.Get, as: FlowsExecutionsGet
  alias Auth0.Management.Flows.Executions.Delete, as: FlowsExecutionsDelete
  alias Auth0.Management.Flows.Delete, as: FlowsDelete

  @type id :: String.t()
  @type config :: Config.t()
  @type error :: {:error, integer, term} | {:error, term}

  @doc """
  Get flows.

  ## see
  https://auth0.com/docs/api/management/v2/flows/get-flows

  """
  @spec list(map(), config) ::
          {:ok, map()} | error
  def list(%{} = params, %Config{} = config) do
    List.execute(params, config)
  end

  @doc """
  Create a flow.

  ## see
  https://auth0.com/docs/api/management/v2/flows/post-flows

  """
  @spec create(map(), config) ::
          {:ok, map()} | error
  def create(%{} = params, %Config{} = config) do
    Create.execute(params, config)
  end

  @doc """
  Get a flow.

  ## see
  https://auth0.com/docs/api/management/v2/flows/get-flows-by-id

  """
  @spec get(id, map(), config) ::
          {:ok, map()} | error
  def get(id, %{} = params, %Config{} = config) do
    Get.execute(id, params, config)
  end

  @doc """
  Update a flow.

  ## see
  https://auth0.com/docs/api/management/v2/flows/patch-flows-by-id

  """
  @spec update(id, map(), config) ::
          {:ok, map()} | error
  def update(id, %{} = params, %Config{} = config) do
    Patch.execute(id, params, config)
  end

  @doc """
  Get Flows Vault connection list.

  ## see
  https://auth0.com/docs/api/management/v2/flows/get-flows-vault-connections

  """
  @spec list_vault_connections(map(), config) :: {:ok, map() | list(map())} | error
  def list_vault_connections(%{} = params, %Config{} = config) do
    FlowsVaultConnectionsList.execute(params, config)
  end

  @doc """
  Create a Flows Vault connection.

  ## see
  https://auth0.com/docs/api/management/v2/flows/post-flows-vault-connections

  """
  @spec create_vault_connection(map(), config) :: {:ok, map()} | error
  def create_vault_connection(%{} = params, %Config{} = config) do
    FlowsVaultConnectionsCreate.execute(params, config)
  end

  @doc """
  Get a Flows Vault connection.

  ## see
  https://auth0.com/docs/api/management/v2/flows/get-flows-vault-connections-by-id

  """
  @spec get_vault_connection(String.t(), config) :: {:ok, map()} | error
  def get_vault_connection(id, %Config{} = config) do
    FlowsVaultConnectionsGet.execute(id, config)
  end

  @doc """
  Update a Flows Vault connection.

  ## see
  https://auth0.com/docs/api/management/v2/flows/patch-flows-vault-connections-by-id

  """
  @spec update_vault_connection(String.t(), map(), config) :: {:ok, map()} | error
  def update_vault_connection(id, %{} = params, %Config{} = config) do
    FlowsVaultConnectionsPatch.execute(id, params, config)
  end

  @doc """
  Delete a Flows Vault connection.

  ## see
  https://auth0.com/docs/api/management/v2/flows/delete-flows-vault-connections-by-id

  """
  @spec delete_vault_connection(String.t(), config) :: {:ok, String.t()} | error
  def delete_vault_connection(id, %Config{} = config) do
    FlowsVaultConnectionsDelete.execute(id, config)
  end

  @doc """
  Get flow executions.

  ## see
  https://auth0.com/docs/api/management/v2/flows/get-flows-executions

  """
  @spec list_executions(String.t(), map(), config) :: {:ok, map() | list(map())} | error
  def list_executions(flow_id, %{} = params, %Config{} = config) do
    FlowsExecutionsList.execute(flow_id, params, config)
  end

  @doc """
  Get a flow execution.

  ## see
  https://auth0.com/docs/api/management/v2/flows/get-flows-executions-by-execution-id

  """
  @spec get_execution(String.t(), String.t(), map(), config) :: {:ok, map()} | error
  def get_execution(flow_id, execution_id, %{} = params, %Config{} = config) do
    FlowsExecutionsGet.execute(flow_id, execution_id, params, config)
  end

  @doc """
  Delete a flow execution.

  ## see
  https://auth0.com/docs/api/management/v2/flows/delete-flows-executions-by-execution-id

  """
  @spec delete_execution(String.t(), String.t(), config) :: {:ok, String.t()} | error
  def delete_execution(flow_id, execution_id, %Config{} = config) do
    FlowsExecutionsDelete.execute(flow_id, execution_id, config)
  end

  @doc """
  Delete a flow.

  ## see
  https://auth0.com/docs/api/management/v2/flows/delete-flows-by-id

  """
  @spec delete(String.t(), config) :: {:ok, String.t()} | error
  def delete(id, %Config{} = config) do
    FlowsDelete.execute(id, config)
  end
end
