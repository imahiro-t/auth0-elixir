defmodule Auth0.Management.Keys do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Management.Keys.Signing

  @type kid :: String.t()
  @type config :: Config.t()
  @type error :: {:error, integer, term} | {:error, term}

  @endpoint_signing "/api/v2/keys/signing"
  @endpoint_signing_by_kid "/api/v2/keys/signing/{kid}"
  @endpoint_signing_rotate "/api/v2/keys/signing/rotate"
  @endpoint_signing_revoke "/api/v2/keys/signing/{kid}/revoke"

  @doc """
  Get all Application Signing Keys.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Keys/get_signing_keys

  """
  @spec list_signing(config) ::
          {:ok, list() | map()} | error
  def list_signing(%Config{} = config) do
    Signing.List.execute(@endpoint_signing, config)
  end

  @doc """
  Get an Application Signing Key by its key id.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Keys/get_signing_key

  """
  @spec get_signing(kid, config) ::
          {:ok, list() | map()} | error
  def get_signing(kid, %Config{} = config) do
    Signing.Get.execute(@endpoint_signing_by_kid, kid, config)
  end

  @doc """
  Rotate the Application Signing Key.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Keys/post_signing_keys

  """
  @spec rotate_signing(config) ::
          {:ok, list() | map()} | error
  def rotate_signing(%Config{} = config) do
    Signing.Rotate.execute(@endpoint_signing_rotate, config)
  end

  @doc """
  Revoke an Application Signing Key by its key id.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Keys/put_signing_keys

  """
  @spec revoke_signing(kid, config) ::
          {:ok, list() | map()} | error
  def revoke_signing(kid, %Config{} = config) do
    Signing.Revoke.execute(@endpoint_signing_revoke, kid, config)
  end
end
