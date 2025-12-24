defmodule Auth0.Management.ConnectionProfiles do
  alias Auth0.Config
  alias Auth0.Management.ConnectionProfiles.List
  alias Auth0.Management.ConnectionProfiles.Get
  alias Auth0.Management.ConnectionProfiles.Patch

  @type id :: String.t()
  @type config :: Config.t()
  @type error :: {:error, integer, term} | {:error, term}

  @doc """
  Retrieve a list of connection profiles.

  ## see
  https://auth0.com/docs/api/management/v2/connection-profiles/get-connection-profiles
  """
  @spec list(map(), config) :: {:ok, list(map())} | error
  def list(%{} = params, %Config{} = config) do
    List.execute(params, config)
  end

  @doc """
  Retrieve a connection profile by its ID.

  ## see
  https://auth0.com/docs/api/management/v2/connection-profiles/get-connection-profiles-by-id
  """
  @spec get(id, config) :: {:ok, map()} | error
  def get(id, %Config{} = config) do
    Get.execute(id, config)
  end

  @doc """
  Update a connection profile.

  ## see
  https://auth0.com/docs/api/management/v2/connection-profiles/patch-connection-profiles-by-id
  """
  @spec update(id, map(), config) :: {:ok, map()} | error
  def update(id, %{} = params, %Config{} = config) do
    Patch.execute(id, params, config)
  end
end
