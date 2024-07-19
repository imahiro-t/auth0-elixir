defmodule Auth0.Management.Tenants do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Management.Tenants.Settings

  @type config :: Config.t()
  @type error :: {:error, integer, term} | {:error, term}

  @endpoint_settings "/api/v2/tenants/settings"

  @doc """
  Get tenant settings.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Tenants/tenant_settings_route

  """
  @spec get_setting(Settings.Get.Params.t() | map, config) ::
          {:ok, list() | map()} | error
  def get_setting(%{} = params, %Config{} = config) do
    Settings.Get.execute(@endpoint_settings, params, config)
  end

  @doc """
  Update tenant settings.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Tenants/patch_settings

  """
  @spec update_setting(Settings.Patch.Params.t() | map, config) ::
          {:ok, list() | map()} | error
  def update_setting(%{} = params, %Config{} = config) do
    Settings.Patch.execute(@endpoint_settings, params, config)
  end
end
