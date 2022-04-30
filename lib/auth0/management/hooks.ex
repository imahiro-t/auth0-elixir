defmodule Auth0.Management.Hooks do
  @moduledoc """
  Documentation for Auth0 Management API of Hooks.

  ## endpoint
  - /api/v2/hooks
  - /api/v2/hooks/{id}
  - /api/v2/hooks/{id}/secrets
  """

  alias Auth0.Config
  alias Auth0.Entity
  alias Auth0.Management.Hooks.List
  alias Auth0.Management.Hooks.Create
  alias Auth0.Management.Hooks.Get
  alias Auth0.Management.Hooks.Delete
  alias Auth0.Management.Hooks.Patch
  alias Auth0.Management.Hooks.Secrets

  @type id :: String.t()
  @type config :: Config.t()
  @type response_body :: String.t()
  @type error :: {:error, integer, term} | {:error, term}

  @endpoint "/api/v2/hooks"
  @endpoint_by_id "/api/v2/hooks/{id}"
  @endpoint_secrets "/api/v2/hooks/{id}/secrets"

  @doc """
  Get hooks.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Hooks/get_hooks

  """
  @spec list(List.Params.t() | map, config) :: {:ok, Entity.Hooks.t(), response_body} | error
  def list(%{} = params, %Config{} = config) do
    List.execute(@endpoint, params, config)
  end

  @doc """
  Create a hook.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Hooks/post_hooks

  """
  @spec create(Create.Params.t() | map, config) ::
          {:ok, Entity.Hook.t(), response_body} | error
  def create(%{} = params, %Config{} = config) do
    Create.execute(@endpoint, params, config)
  end

  @doc """
  Get a hook.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Hooks/get_hooks_by_id

  """
  @spec get(id, Get.Params.t() | map, config) ::
          {:ok, Entity.Hook.t(), response_body} | error
  def get(id, %{} = params, %Config{} = config) do
    Get.execute(@endpoint_by_id, id, params, config)
  end

  @doc """
  Delete a hook.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Hooks/delete_hooks_by_id

  """
  @spec delete(id, config) :: {:ok, String.t(), response_body} | error
  def delete(id, %Config{} = config) do
    Delete.execute(@endpoint_by_id, id, config)
  end

  @doc """
  Update a hook.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Hooks/patch_hooks_by_id

  """
  @spec update(id, Patch.Params.t() | map, config) ::
          {:ok, Entity.Hook.t(), response_body} | error
  def update(id, %{} = params, %Config{} = config) do
    Patch.execute(@endpoint_by_id, id, params, config)
  end

  @doc """
  Get hook secrets.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Hooks/get_secrets

  """
  @spec get_secrets(id, config) :: {:ok, Entity.HookSecret.t(), response_body} | error
  def get_secrets(id, %Config{} = config) do
    Secrets.Get.execute(@endpoint_secrets, id, config)
  end

  @doc """
  Delete hook secrets.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Hooks/delete_secrets

  """
  @spec delete_secrets(id, Secrets.Delete.Params.t() | map, config) ::
          {:ok, String.t(), response_body} | error
  def delete_secrets(id, %{} = params, %Config{} = config) do
    Secrets.Delete.execute(@endpoint_secrets, id, params, config)
  end

  @doc """
  Update hook secrets.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Hooks/patch_hooks_by_id

  """
  @spec update_secrets(id, Secrets.Patch.Params.t() | map, config) ::
          {:ok, map, response_body} | error
  def update_secrets(id, %{} = params, %Config{} = config) do
    Secrets.Patch.execute(@endpoint_secrets, id, params, config)
  end

  @doc """
  Add hook secrets.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Hooks/post_secrets

  """
  @spec add_secrets(id, Secrets.Add.Params.t() | map, config) :: {:ok, map, response_body} | error
  def add_secrets(id, %{} = params, %Config{} = config) do
    Secrets.Add.execute(@endpoint_secrets, id, params, config)
  end
end
