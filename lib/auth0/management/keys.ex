defmodule Auth0.Management.Keys do
  alias Auth0.Config
  alias Auth0.Management.Keys.Signing
  alias Auth0.Management.Keys.Encryption

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

  @doc """
  Retrieve details of all the encryption keys associated with your tenant.

  ## see
  https://auth0.com/docs/api/management/v2/keys/get-encryption-keys

  """
  @spec get_encryption_keys(map(), config) ::
          {:ok, list(map()) | map()} | error
  def get_encryption_keys(%{} = params, %Config{} = config) do
    Encryption.List.execute(params, config)
  end

  @doc """
  Create the new, pre-activated encryption key, without the key material.

  ## see
  https://auth0.com/docs/api/management/v2/keys/post-encryption

  """
  @spec create_encryption_key(map(), config) ::
          {:ok, map()} | error
  def create_encryption_key(%{} = params, %Config{} = config) do
    Encryption.Create.execute(params, config)
  end

  @doc """
  Perform rekeying operation on the key hierarchy.

  ## see
  https://auth0.com/docs/api/management/v2/keys/post-encryption-rekey

  """
  @spec rekey_encryption_key(config) ::
          {:ok, String.t()} | error
  def rekey_encryption_key(%Config{} = config) do
    Encryption.Rekey.execute(config)
  end

  @doc """
  Retrieve details of the encryption key with the given ID.

  ## see
  https://auth0.com/docs/api/management/v2/keys/get-encryption-key

  """
  @spec get_encryption_key(kid, config) ::
          {:ok, map()} | error
  def get_encryption_key(kid, %Config{} = config) do
    Encryption.Get.execute(kid, config)
  end

  @doc """
  Delete the custom provided encryption key with the given ID and move back to using native encryption key.

  ## see
  https://auth0.com/docs/api/management/v2/keys/delete-encryption-key

  """
  @spec delete_encryption_key(kid, config) ::
          {:ok, String.t()} | error
  def delete_encryption_key(kid, %Config{} = config) do
    Encryption.Delete.execute(kid, config)
  end

  @doc """
  Import wrapped key material and activate encryption key.

  ## see
  https://auth0.com/docs/api/management/v2/keys/post-encryption-key

  """
  @spec import_encryption_key(kid, map(), config) ::
          {:ok, map()} | error
  def import_encryption_key(kid, %{} = params, %Config{} = config) do
    Encryption.Import.execute(kid, params, config)
  end

  @doc """
  Create the public wrapping key to wrap your own encryption key material.

  ## see
  https://auth0.com/docs/api/management/v2/keys/post-encryption-wrapping-key

  """
  @spec create_encryption_wrapping_key(kid, config) ::
          {:ok, map()} | error
  def create_encryption_wrapping_key(kid, %Config{} = config) do
    Encryption.WrappingKey.Create.execute(kid, config)
  end
end
