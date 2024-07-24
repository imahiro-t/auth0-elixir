defmodule Auth0.Management.Rules do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Management.Rules.List
  alias Auth0.Management.Rules.Create
  alias Auth0.Management.Rules.Get
  alias Auth0.Management.Rules.Delete
  alias Auth0.Management.Rules.Patch

  @type id :: String.t()
  @type config :: Config.t()
  @type error :: {:error, integer, term} | {:error, term}

  @doc """
  Retrieve a filtered list of rules. Accepts a list of fields to include or exclude.

  ## see
  https://auth0.com/docs/api/management/v2/rules/get-rules

  """
  @spec list(map(), config) :: {:ok, list(map()) | map()} | error
  def list(%{} = params, %Config{} = config) do
    List.execute(params, config)
  end

  @doc """
  Create a new rule.

  ## see
  https://auth0.com/docs/api/management/v2/rules/post-rules

  """
  @spec create(map(), config) ::
          {:ok, map()} | error
  def create(%{} = params, %Config{} = config) do
    Create.execute(params, config)
  end

  @doc """
  Retrieve rule details. Accepts a list of fields to include or exclude in the result.

  ## see
  https://auth0.com/docs/api/management/v2/rules/get-rules-by-id

  """
  @spec get(id, map(), config) ::
          {:ok, map()} | error
  def get(id, %{} = params, %Config{} = config) do
    Get.execute(id, params, config)
  end

  @doc """
  Delete a rule.

  ## see
  https://auth0.com/docs/api/management/v2/rules/delete-rules-by-id

  """
  @spec delete(id, config) :: {:ok, String.t()} | error
  def delete(id, %Config{} = config) do
    Delete.execute(id, config)
  end

  @doc """
  Update an existing rule.

  ## see
  https://auth0.com/docs/api/management/v2/rules/patch-rules-by-id

  """
  @spec update(id, map(), config) ::
          {:ok, map()} | error
  def update(id, %{} = params, %Config{} = config) do
    Patch.execute(id, params, config)
  end
end
