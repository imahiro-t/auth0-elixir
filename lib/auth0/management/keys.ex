defmodule Auth0.Management.Keys do
  alias Auth0.Config
  alias Auth0.Management.Keys.Signing

  @type kid :: String.t()
  @type config :: Config.t()
  @type error :: {:error, integer, term} | {:error, term}

  @doc """
  Retrieve details of all the application signing keys associated with your tenant.

  ## see
  https://auth0.com/docs/api/management/v2/keys/get-signing-keys

  """
  @spec list_signing(config) ::
          {:ok, list(map())} | error
  def list_signing(%Config{} = config) do
    Signing.List.execute(config)
  end

  @doc """
  Retrieve details of the application signing key with the given ID.

  ## see
  https://auth0.com/docs/api/management/v2/keys/get-signing-key

  """
  @spec get_signing(kid, config) ::
          {:ok, map()} | error
  def get_signing(kid, %Config{} = config) do
    Signing.Get.execute(kid, config)
  end

  @doc """
  Rotate the application signing key of your tenant.

  ## see
  https://auth0.com/docs/api/management/v2/keys/post-signing-keys

  """
  @spec rotate_signing(config) ::
          {:ok, map()} | error
  def rotate_signing(%Config{} = config) do
    Signing.Rotate.execute(config)
  end

  @doc """
  Revoke the application signing key with the given ID.

  ## see
  https://auth0.com/docs/api/management/v2/keys/put-signing-keys

  """
  @spec revoke_signing(kid, config) ::
          {:ok, map()} | error
  def revoke_signing(kid, %Config{} = config) do
    Signing.Revoke.execute(kid, config)
  end
end
