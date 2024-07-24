defmodule Auth0.Management.Hooks do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Management.Hooks.List
  alias Auth0.Management.Hooks.Create
  alias Auth0.Management.Hooks.Get
  alias Auth0.Management.Hooks.Delete
  alias Auth0.Management.Hooks.Patch
  alias Auth0.Management.Hooks.Secrets

  @type id :: String.t()
  @type config :: Config.t()
  @type error :: {:error, integer, term} | {:error, term}

  @doc """
  Retrieve all hooks. Accepts a list of fields to include or exclude in the result.

  ## see
  https://auth0.com/docs/api/management/v2/hooks/get-hooks

  """
  @spec list(map(), config) ::
          {:ok, list(map()) | map()} | error
  def list(%{} = params, %Config{} = config) do
    List.execute(params, config)
  end

  @doc """
  Create a new hook.

  ## see
  https://auth0.com/docs/api/management/v2/hooks/post-hooks

  """
  @spec create(map(), config) ::
          {:ok, map()} | error
  def create(%{} = params, %Config{} = config) do
    Create.execute(params, config)
  end

  @doc """
  Retrieve a hook by its ID. Accepts a list of fields to include in the result.

  ## see
  https://auth0.com/docs/api/management/v2/hooks/get-hooks-by-id

  """
  @spec get(id, map(), config) ::
          {:ok, map()} | error
  def get(id, %{} = params, %Config{} = config) do
    Get.execute(id, params, config)
  end

  @doc """
  Delete a hook.

  ## see
  https://auth0.com/docs/api/management/v2/hooks/delete-hooks-by-id

  """
  @spec delete(id, config) :: {:ok, String.t()} | error
  def delete(id, %Config{} = config) do
    Delete.execute(id, config)
  end

  @doc """
  Update an existing hook.

  ## see
  https://auth0.com/docs/api/management/v2/hooks/patch-hooks-by-id

  """
  @spec update(id, map(), config) ::
          {:ok, map()} | error
  def update(id, %{} = params, %Config{} = config) do
    Patch.execute(id, params, config)
  end

  @doc """
  Retrieve a hook's secrets by the ID of the hook.

  ## see
  https://auth0.com/docs/api/management/v2/hooks/get-secrets

  """
  @spec get_secrets(id, config) ::
          {:ok, map()} | error
  def get_secrets(id, %Config{} = config) do
    Secrets.Get.execute(id, config)
  end

  @doc """
  Delete one or more existing secrets for a given hook. Accepts an array of secret names to delete.

  ## see
  https://auth0.com/docs/api/management/v2/hooks/delete-secrets

  """
  @spec delete_secrets(id, map(), config) ::
          {:ok, String.t()} | error
  def delete_secrets(id, %{} = params, %Config{} = config) do
    Secrets.Delete.execute(id, params, config)
  end

  @doc """
  Update an existing hook.

  ## see
  https://auth0.com/docs/api/management/v2/hooks/patch-hooks-by-id

  """
  @spec update_secrets(id, map(), config) ::
          {:ok, map()} | error
  def update_secrets(id, %{} = params, %Config{} = config) do
    Secrets.Patch.execute(id, params, config)
  end

  @doc """
  Add one or more secrets to an existing hook. Accepts an object of key-value pairs, where the key is the name of the secret. A hook can have a maximum of 20 secrets.

  ## see
  https://auth0.com/docs/api/management/v2/hooks/post-secrets

  """
  @spec add_secrets(id, map(), config) :: {:ok, map()} | error
  def add_secrets(id, %{} = params, %Config{} = config) do
    Secrets.Add.execute(id, params, config)
  end
end
