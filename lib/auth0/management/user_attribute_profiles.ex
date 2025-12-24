defmodule Auth0.Management.UserAttributeProfiles do
  alias Auth0.Config
  alias Auth0.Management.UserAttributeProfiles.List
  alias Auth0.Management.UserAttributeProfiles.Create
  alias Auth0.Management.UserAttributeProfiles.Get
  alias Auth0.Management.UserAttributeProfiles.Delete
  alias Auth0.Management.UserAttributeProfiles.Patch

  @type id :: String.t()
  @type config :: Config.t()
  @type error :: {:error, integer, term} | {:error, term}

  @doc """
  Retrieve a list of user attribute profiles.

  ## see
  https://auth0.com/docs/api/management/v2/user-attribute-profiles/get-user-attribute-profiles
  """
  @spec list(map(), config) :: {:ok, list(map())} | error
  def list(%{} = params, %Config{} = config) do
    List.execute(params, config)
  end

  @doc """
  Create a user attribute profile.

  ## see
  https://auth0.com/docs/api/management/v2/user-attribute-profiles/post-user-attribute-profiles
  """
  @spec create(map(), config) :: {:ok, map()} | error
  def create(%{} = params, %Config{} = config) do
    Create.execute(params, config)
  end

  @doc """
  Retrieve a user attribute profile by its ID.

  ## see
  https://auth0.com/docs/api/management/v2/user-attribute-profiles/get-user-attribute-profiles-by-id
  """
  @spec get(id, config) :: {:ok, map()} | error
  def get(id, %Config{} = config) do
    Get.execute(id, config)
  end

  @doc """
  Delete a user attribute profile.

  ## see
  https://auth0.com/docs/api/management/v2/user-attribute-profiles/delete-user-attribute-profiles-by-id
  """
  @spec delete(id, config) :: {:ok, String.t()} | error
  def delete(id, %Config{} = config) do
    Delete.execute(id, config)
  end

  @doc """
  Update a user attribute profile.

  ## see
  https://auth0.com/docs/api/management/v2/user-attribute-profiles/patch-user-attribute-profiles-by-id
  """
  @spec update(id, map(), config) :: {:ok, map()} | error
  def update(id, %{} = params, %Config{} = config) do
    Patch.execute(id, params, config)
  end
end
