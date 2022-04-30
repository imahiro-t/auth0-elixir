defmodule Auth0.Management.Branding do
  @moduledoc """
  Documentation for Auth0 Management API of Branding.

  ## endpoint
  - /api/v2/branding
  - /api/v2/branding/templates/universal-login
  """

  alias Auth0.Config
  alias Auth0.Entity
  alias Auth0.Management.Branding.Get
  alias Auth0.Management.Branding.Patch
  alias Auth0.Management.Branding.Templates.UniversalLogin

  @type config :: Config.t()
  @type response_body :: String.t()
  @type error :: {:error, integer, term} | {:error, term}

  @endpoint "/api/v2/branding"
  @endpoint_universal_login "/api/v2/branding/templates/universal-login"

  @doc """
  Get branding settings.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Branding/get_branding

  """
  @spec get(config) :: {:ok, Entity.Branding.t(), response_body} | error
  def get(%Config{} = config) do
    Get.execute(@endpoint, config)
  end

  @doc """
  Update branding settings.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Branding/patch_branding

  """
  @spec update(Patch.Params.t() | map, config) ::
          {:ok, Entity.Branding.t(), response_body} | error
  def update(%{} = params, %Config{} = config) do
    Patch.execute(@endpoint, params, config)
  end

  @doc """
  Get template for New Universal Login Experience.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Branding/get_universal_login

  """
  @spec get_universal_login(config) ::
          {:ok, Entity.UniversalLogin.t(), response_body} | error
  def get_universal_login(%Config{} = config) do
    UniversalLogin.Get.execute(@endpoint_universal_login, config)
  end

  @doc """
  Delete template for New Universal Login Experience.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Branding/delete_universal_login

  """
  @spec delete_universal_login(config) :: {:ok, String.t(), response_body} | error
  def delete_universal_login(%Config{} = config) do
    UniversalLogin.Delete.execute(@endpoint_universal_login, config)
  end

  @doc """
  Set template for New Universal Login Experience.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Branding/put_universal_login

  """
  @spec set_universal_login(UniversalLogin.Put.Params.t() | map, config) ::
          {:ok, String.t(), response_body} | error
  def set_universal_login(%{} = params, %Config{} = config) do
    UniversalLogin.Put.execute(@endpoint_universal_login, params, config)
  end
end
