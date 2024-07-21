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

  @doc """
  Retrieve branding settings.

  ## see
  https://auth0.com/docs/api/management/v2/branding/get-branding

  """
  @spec get(config) ::
          {:ok, list() | map()} | error
  def get(%Config{} = config) do
    Get.execute(config)
  end

  @doc """
  Update branding settings.

  ## see
  https://auth0.com/docs/api/management/v2/branding/patch-branding

  """
  @spec update(map(), config) ::
          {:ok, list() | map()} | error
  def update(%{} = params, %Config{} = config) do
    Patch.execute(params, config)
  end

  @doc """
  Get template for New Universal Login Experience

  ## see
  https://auth0.com/docs/api/management/v2/branding/get-universal-login

  """
  @spec get_universal_login(config) ::
          {:ok, list() | map()} | error
  def get_universal_login(%Config{} = config) do
    UniversalLogin.Get.execute(config)
  end

  @doc """
  Delete template for New Universal Login Experience

  ## see
  https://auth0.com/docs/api/management/v2/branding/delete-universal-login

  """
  @spec delete_universal_login(config) :: {:ok, String.t()} | error
  def delete_universal_login(%Config{} = config) do
    UniversalLogin.Delete.execute(config)
  end

  @doc """
  Update the Universal Login branding template.

  ## see
  https://auth0.com/docs/api/management/v2/branding/put-universal-login

  """
  @spec set_universal_login(map(), config) ::
          {:ok, String.t()} | error
  def set_universal_login(%{} = params, %Config{} = config) do
    UniversalLogin.Put.execute(params, config)
  end

  @doc """
  Retrieve default branding theme.

  ## see
  https://auth0.com/docs/api/management/v2/branding/get-default-branding-theme

  """
  @spec get_default_theme(config) ::
          {:ok, list() | map()} | error
  def get_default_theme(%Config{} = config) do
    Themes.Default.Get.execute(config)
  end

  @doc """
  Retrieve branding theme.

  ## see
  https://auth0.com/docs/api/management/v2/branding/get-branding-theme

  """
  @spec get_theme(theme_id, config) ::
          {:ok, list() | map()} | error
  def get_theme(theme_id, %Config{} = config) do
    Themes.Get.execute(theme_id, config)
  end

  @doc """
  Delete branding theme.

  ## see
  https://auth0.com/docs/api/management/v2/branding/delete-branding-theme

  """
  @spec delete_theme(theme_id, config) ::
          {:ok, list() | map()} | error
  def delete_theme(theme_id, %Config{} = config) do
    Themes.Delete.execute(theme_id, config)
  end

  @doc """
  Update branding theme.

  ## see
  https://auth0.com/docs/api/management/v2/branding/patch-branding-theme

  """
  @spec update_theme(theme_id, map(), config) ::
          {:ok, list() | map()} | error
  def update_theme(theme_id, %{} = params, %Config{} = config) do
    Themes.Patch.execute(theme_id, params, config)
  end

  @doc """
  Create branding theme.

  ## see
  https://auth0.com/docs/api/management/v2/branding/post-branding-theme

  """
  @spec create_theme(map(), config) ::
          {:ok, list() | map()} | error
  def create_theme(%{} = params, %Config{} = config) do
    Themes.Create.execute(params, config)
  end
end
