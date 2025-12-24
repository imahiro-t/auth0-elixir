defmodule Auth0.Management.TokenExchangeProfiles do
  alias Auth0.Config
  alias Auth0.Management.TokenExchangeProfiles.List
  alias Auth0.Management.TokenExchangeProfiles.Create
  alias Auth0.Management.TokenExchangeProfiles.Get
  alias Auth0.Management.TokenExchangeProfiles.Delete
  alias Auth0.Management.TokenExchangeProfiles.Patch

  @type id :: String.t()
  @type config :: Config.t()
  @type error :: {:error, integer, term} | {:error, term}

  @doc """
  Retrieve a list of token exchange profiles.

  ## see
  https://auth0.com/docs/api/management/v2/token-exchange-profiles/get-token-exchange-profiles
  """
  @spec list(map(), config) :: {:ok, list(map())} | error
  def list(%{} = params, %Config{} = config) do
    List.execute(params, config)
  end

  @doc """
  Create a token exchange profile.

  ## see
  https://auth0.com/docs/api/management/v2/token-exchange-profiles/post-token-exchange-profiles
  """
  @spec create(map(), config) :: {:ok, map()} | error
  def create(%{} = params, %Config{} = config) do
    Create.execute(params, config)
  end

  @doc """
  Retrieve a token exchange profile by its ID.

  ## see
  https://auth0.com/docs/api/management/v2/token-exchange-profiles/get-token-exchange-profiles-by-id
  """
  @spec get(id, config) :: {:ok, map()} | error
  def get(id, %Config{} = config) do
    Get.execute(id, config)
  end

  @doc """
  Delete a token exchange profile.

  ## see
  https://auth0.com/docs/api/management/v2/token-exchange-profiles/delete-token-exchange-profiles-by-id
  """
  @spec delete(id, config) :: {:ok, String.t()} | error
  def delete(id, %Config{} = config) do
    Delete.execute(id, config)
  end

  @doc """
  Update a token exchange profile.

  ## see
  https://auth0.com/docs/api/management/v2/token-exchange-profiles/patch-token-exchange-profiles-by-id
  """
  @spec update(id, map(), config) :: {:ok, map()} | error
  def update(id, %{} = params, %Config{} = config) do
    Patch.execute(id, params, config)
  end
end
