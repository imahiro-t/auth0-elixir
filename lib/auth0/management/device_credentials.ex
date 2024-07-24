defmodule Auth0.Management.DeviceCredentials do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Management.DeviceCredentials.List
  alias Auth0.Management.DeviceCredentials.Create
  alias Auth0.Management.DeviceCredentials.Delete

  @type id :: String.t()
  @type config :: Config.t()
  @type error :: {:error, integer, term} | {:error, term}

  @doc """
  Retrieve device credential information (public_key, refresh_token, or rotating_refresh_token) associated with a specific user.

  ## see
  https://auth0.com/docs/api/management/v2/device-credentials/get-device-credentials

  """
  @spec list(map(), config) ::
          {:ok, list(map())} | error
  def list(%{} = params, %Config{} = config) do
    List.execute(params, config)
  end

  @doc """
  Create a device credential public key to manage refresh token rotation for a given user_id. Device Credentials APIs are designed for ad-hoc administrative use only and paging is by default enabled for GET requests.

  ## see
  https://auth0.com/docs/api/management/v2/device-credentials/post-device-credentials

  """
  @spec create(map(), config) ::
          {:ok, map()} | error
  def create(%{} = params, %Config{} = config) do
    Create.execute(params, config)
  end

  @doc """
  Permanently delete a device credential (such as a refresh token or public key) with the given ID.

  ## see
  https://auth0.com/docs/api/management/v2/device-credentials/delete-device-credentials-by-id

  """
  @spec delete(id, config) :: {:ok, String.t()} | error
  def delete(id, %Config{} = config) do
    Delete.execute(id, config)
  end
end
