defmodule Auth0.Management.Agents do
  @moduledoc """
  Facade for the Auth0 Management API Agents (Early Access).
  """

  alias Auth0.Config
  alias Auth0.Management.Agents.List, as: AgentsList
  alias Auth0.Management.Agents.Create, as: AgentsCreate
  alias Auth0.Management.Agents.Get, as: AgentsGet
  alias Auth0.Management.Agents.Patch, as: AgentsPatch
  alias Auth0.Management.Agents.Delete, as: AgentsDelete

  @type config :: Config.t()
  @type error :: {:error, integer, term} | {:error, term}

  @doc """
  Get agents.

  **Early Access**: this endpoint is marked as Early Access (`x-release-lifecycle: EA`) in the Auth0 Management API specification and may not be available on every tenant.

  ## see
  https://auth0.com/docs/api/management/v2/agents/get-agents

  """
  @spec list(map(), config) :: {:ok, map()} | error
  def list(%{} = params, %Config{} = config) do
    AgentsList.execute(params, config)
  end

  @doc """
  Create an agent.

  **Early Access**: this endpoint is marked as Early Access (`x-release-lifecycle: EA`) in the Auth0 Management API specification and may not be available on every tenant.

  ## see
  https://auth0.com/docs/api/management/v2/agents/post-agent

  """
  @spec create(map(), config) :: {:ok, map()} | error
  def create(%{} = params, %Config{} = config) do
    AgentsCreate.execute(params, config)
  end

  @doc """
  Get an agent.

  **Early Access**: this endpoint is marked as Early Access (`x-release-lifecycle: EA`) in the Auth0 Management API specification and may not be available on every tenant.

  ## see
  https://auth0.com/docs/api/management/v2/agents/get-agent

  """
  @spec get(String.t(), config) :: {:ok, map()} | error
  def get(id, %Config{} = config) do
    AgentsGet.execute(id, config)
  end

  @doc """
  Update an agent.

  **Early Access**: this endpoint is marked as Early Access (`x-release-lifecycle: EA`) in the Auth0 Management API specification and may not be available on every tenant.

  ## see
  https://auth0.com/docs/api/management/v2/agents/patch-agent

  """
  @spec update(String.t(), map(), config) :: {:ok, map()} | error
  def update(id, %{} = params, %Config{} = config) do
    AgentsPatch.execute(id, params, config)
  end

  @doc """
  Delete an agent.

  **Early Access**: this endpoint is marked as Early Access (`x-release-lifecycle: EA`) in the Auth0 Management API specification and may not be available on every tenant.

  ## see
  https://auth0.com/docs/api/management/v2/agents/delete-agent

  """
  @spec delete(String.t(), config) :: {:ok, String.t()} | error
  def delete(id, %Config{} = config) do
    AgentsDelete.execute(id, config)
  end
end
