defmodule Auth0.Management.Branding do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Management.Branding.Get
  alias Auth0.Management.Branding.Patch
  alias Auth0.Management.Branding.Templates.UniversalLogin
  alias Auth0.Management.Branding.Themes

  @type theme_id :: String.t()
  @type config :: Config.t()
  @type error :: {:error, integer, term} | {:error, term}

  @endpoint "/api/v2/branding"
  @endpoint_universal_login "/api/v2/branding/templates/universal-login"
  @endpoint_default_theme "/api/v2/branding/themes/default"
  @endpoint_theme_by_theme_id "/api/v2/branding/themes/{themeId}"
  @endpoint_theme "/api/v2/branding/themes"

  @doc """
  Get branding settings.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Branding/get_branding

  """
  @spec get(config) ::
          {:ok, list() | map()} | error
  def get(%Config{} = config) do
    Get.execute(@endpoint, config)
  end

  @doc """
  Update branding settings.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Branding/patch_branding

  """
  @spec update(Patch.Params.t() | map, config) ::
          {:ok, list() | map()} | error
  def update(%{} = params, %Config{} = config) do
    Patch.execute(@endpoint, params, config)
  end

  @doc """
  Get template for New Universal Login Experience.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Branding/get_universal_login

  """
  @spec get_universal_login(config) ::
          {:ok, list() | map()} | error
  def get_universal_login(%Config{} = config) do
    UniversalLogin.Get.execute(@endpoint_universal_login, config)
  end

  @doc """
  Delete template for New Universal Login Experience.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Branding/delete_universal_login

  """
  @spec delete_universal_login(config) :: {:ok, String.t()} | error
  def delete_universal_login(%Config{} = config) do
    UniversalLogin.Delete.execute(@endpoint_universal_login, config)
  end

  @doc """
  Set template for New Universal Login Experience.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Branding/put_universal_login

  """
  @spec set_universal_login(UniversalLogin.Put.Params.t() | map, config) ::
          {:ok, String.t()} | error
  def set_universal_login(%{} = params, %Config{} = config) do
    UniversalLogin.Put.execute(@endpoint_universal_login, params, config)
  end

  @doc """
  Retrieve default branding theme.

  ## see
  https://auth0.com/docs/api/management/v2#!/Branding/get_default_branding_theme

  """
  @spec get_default_theme(config) ::
          {:ok, list() | map()} | error
  def get_default_theme(%Config{} = config) do
    Themes.Default.Get.execute(@endpoint_default_theme, config)
  end

  @doc """
  Get branding theme.

  ## see
  https://auth0.com/docs/api/management/v2#!/Branding/get_branding_theme

  """
  @spec get_theme(theme_id, config) ::
          {:ok, list() | map()} | error
  def get_theme(theme_id, %Config{} = config) do
    Themes.Get.execute(@endpoint_theme_by_theme_id, theme_id, config)
  end

  @doc """
  Delete branding theme.

  ## see
  https://auth0.com/docs/api/management/v2#!/Branding/delete_branding_theme

  """
  @spec delete_theme(theme_id, config) ::
          {:ok, list() | map()} | error
  def delete_theme(theme_id, %Config{} = config) do
    Themes.Delete.execute(@endpoint_theme_by_theme_id, theme_id, config)
  end

  @doc """
  Update branding theme.

  ## see
  https://auth0.com/docs/api/management/v2#!/Branding/patch_branding_theme

  """
  @spec update_theme(theme_id, Themes.Patch.Params.t() | map, config) ::
          {:ok, list() | map()} | error
  def update_theme(theme_id, %{} = params, %Config{} = config) do
    Themes.Patch.execute(@endpoint_theme_by_theme_id, theme_id, params, config)
  end

  @doc """
  Create branding theme.

  ## see
  https://auth0.com/docs/api/management/v2#!/Branding/post_branding_theme

  """
  @spec create_theme(Themes.Create.Params.t() | map, config) ::
          {:ok, list() | map()} | error
  def create_theme(%{} = params, %Config{} = config) do
    Themes.Create.execute(@endpoint_theme, params, config)
  end
end
