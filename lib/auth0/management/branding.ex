defmodule Auth0.Management.Branding do
  alias Auth0.Config
  alias Auth0.Management.Branding.Get
  alias Auth0.Management.Branding.Patch
  alias Auth0.Management.Branding.Phone
  alias Auth0.Management.Branding.Templates.UniversalLogin
  alias Auth0.Management.Branding.Themes

  @type id :: String.t()
  @type theme_id :: String.t()
  @type config :: Config.t()
  @type error :: {:error, integer, term} | {:error, term}

  @doc """
  Retrieve branding settings.

  ## see
  https://auth0.com/docs/api/management/v2/branding/get-branding

  """
  @spec get(config) ::
          {:ok, map()} | error
  def get(%Config{} = config) do
    Get.execute(config)
  end

  @doc """
  Update branding settings.

  ## see
  https://auth0.com/docs/api/management/v2/branding/patch-branding

  """
  @spec update(map(), config) ::
          {:ok, map()} | error
  def update(%{} = params, %Config{} = config) do
    Patch.execute(params, config)
  end

  @doc """
  Retrieve a list ofphone providers details set for a Tenant. A list of fields to include or exclude may also be specified.

  ## see
  https://auth0.com/docs/api/management/v2/branding/get-branding-phone-providers

  """
  @spec list_phone_providers(map(), config) ::
          {:ok, map()} | error
  def list_phone_providers(%{} = params, %Config{} = config) do
    Phone.Providers.List.execute(params, config)
  end

  @doc """
  Create an phone provider.

  ## see
  https://auth0.com/docs/api/management/v2/branding/create-phone-provider

  """
  @spec configure_phone_provider(map(), config) ::
          {:ok, map()} | error
  def configure_phone_provider(%{} = params, %Config{} = config) do
    Phone.Providers.Configure.execute(params, config)
  end

  @doc """
  Retrieve phone provider details. A list of fields to include or exclude may also be specified.

  ## see
  https://auth0.com/docs/api/management/v2/branding/get-phone-provider

  """
  @spec get_phone_provider(id, config) ::
          {:ok, map()} | error
  def get_phone_provider(id, %Config{} = config) do
    Phone.Providers.Get.execute(id, config)
  end

  @doc """
  Delete the configured phone provider.

  ## see
  https://auth0.com/docs/api/management/v2/branding/delete-phone-provider

  """
  @spec delete_phone_provider(id, config) ::
          {:ok, map()} | error
  def delete_phone_provider(id, %Config{} = config) do
    Phone.Providers.Delete.execute(id, config)
  end

  @doc """
  Update an phone provider.

  ## see
  https://auth0.com/docs/api/management/v2/branding/update-phone-provider

  """
  @spec update_phone_provider(id, map(), config) ::
          {:ok, map()} | error
  def update_phone_provider(id, %{} = params, %Config{} = config) do
    Phone.Providers.Patch.execute(id, params, config)
  end

  @doc """
  Send a test phone notification for the configured provider

  ## see
  https://auth0.com/docs/api/management/v2/branding/try-phone-provider

  """
  @spec test_phone_provider(id, map(), config) ::
          {:ok, map()} | error
  def test_phone_provider(id, %{} = params, %Config{} = config) do
    Phone.Providers.Try.execute(id, params, config)
  end

  @doc """
  Get a list of phone notification templates

  ## see
  https://auth0.com/docs/api/management/v2/branding/get-phone-templates

  """
  @spec list_phone_templates(map(), config) ::
          {:ok, map()} | error
  def list_phone_templates(%{} = params, %Config{} = config) do
    Phone.Templates.List.execute(params, config)
  end

  @doc """
  Create a phone notification template

  ## see
  https://auth0.com/docs/api/management/v2/branding/create-phone-template

  """
  @spec create_phone_template(map(), config) ::
          {:ok, map()} | error
  def create_phone_template(%{} = params, %Config{} = config) do
    Phone.Templates.Create.execute(params, config)
  end

  @doc """
  Get a phone notification template

  ## see
  https://auth0.com/docs/api/management/v2/branding/get-phone-template

  """
  @spec get_phone_template(id, config) ::
          {:ok, map()} | error
  def get_phone_template(id, %Config{} = config) do
    Phone.Templates.Get.execute(id, config)
  end

  @doc """
  Delete a phone notification template

  ## see
  https://auth0.com/docs/api/management/v2/branding/delete-phone-template

  """
  @spec delete_phone_template(id, config) ::
          {:ok, map()} | error
  def delete_phone_template(id, %Config{} = config) do
    Phone.Templates.Delete.execute(id, config)
  end

  @doc """
  Update a phone notification template

  ## see
  https://auth0.com/docs/api/management/v2/branding/update-phone-template

  """
  @spec update_phone_template(id, map(), config) ::
          {:ok, map()} | error
  def update_phone_template(id, %{} = params, %Config{} = config) do
    Phone.Templates.Patch.execute(id, params, config)
  end

  @doc """
  Resets a phone notification template values

  ## see
  https://auth0.com/docs/api/management/v2/branding/reset-phone-template

  """
  @spec reset_phone_template(id, map(), config) ::
          {:ok, map()} | error
  def reset_phone_template(id, %{} = params, %Config{} = config) do
    Phone.Templates.Reset.execute(id, params, config)
  end

  @doc """
  Send a test phone notification for the configured template

  ## see
  https://auth0.com/docs/api/management/v2/branding/try-phone-template

  """
  @spec test_phone_template(id, map(), config) ::
          {:ok, map()} | error
  def test_phone_template(id, %{} = params, %Config{} = config) do
    Phone.Templates.Try.execute(id, params, config)
  end

  @doc """
  Get template for New Universal Login Experience

  ## see
  https://auth0.com/docs/api/management/v2/branding/get-universal-login

  """
  @spec get_universal_login(config) ::
          {:ok, map() | String.t()} | error
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
  Create branding theme.

  ## see
  https://auth0.com/docs/api/management/v2/branding/post-branding-theme

  """
  @spec create_theme(map(), config) ::
          {:ok, map()} | error
  def create_theme(%{} = params, %Config{} = config) do
    Themes.Create.execute(params, config)
  end

  @doc """
  Retrieve default branding theme.

  ## see
  https://auth0.com/docs/api/management/v2/branding/get-default-branding-theme

  """
  @spec get_default_theme(config) ::
          {:ok, map()} | error
  def get_default_theme(%Config{} = config) do
    Themes.Default.Get.execute(config)
  end

  @doc """
  Retrieve branding theme.

  ## see
  https://auth0.com/docs/api/management/v2/branding/get-branding-theme

  """
  @spec get_theme(theme_id, config) ::
          {:ok, map()} | error
  def get_theme(theme_id, %Config{} = config) do
    Themes.Get.execute(theme_id, config)
  end

  @doc """
  Delete branding theme.

  ## see
  https://auth0.com/docs/api/management/v2/branding/delete-branding-theme

  """
  @spec delete_theme(theme_id, config) ::
          {:ok, String.t()} | error
  def delete_theme(theme_id, %Config{} = config) do
    Themes.Delete.execute(theme_id, config)
  end

  @doc """
  Update branding theme.

  ## see
  https://auth0.com/docs/api/management/v2/branding/patch-branding-theme

  """
  @spec update_theme(theme_id, map(), config) ::
          {:ok, map()} | error
  def update_theme(theme_id, %{} = params, %Config{} = config) do
    Themes.Patch.execute(theme_id, params, config)
  end
end
