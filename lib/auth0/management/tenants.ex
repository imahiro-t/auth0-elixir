defmodule Auth0.Management.Tenants do
  alias Auth0.Config
  alias Auth0.Management.Tenants.Settings

  @type config :: Config.t()
  @type error :: {:error, integer, term} | {:error, term}

  @doc """
  Retrieve tenant settings. A list of fields to include or exclude may also be specified.

  ## see
  https://auth0.com/docs/api/management/v2/tenants/tenant-settings-route

  """
  @spec get_setting(map(), config) ::
          {:ok, map()} | error
  def get_setting(%{} = params, %Config{} = config) do
    Settings.Get.execute(params, config)
  end

  @doc """
  Update settings for a tenant.

  ## see
  https://auth0.com/docs/api/management/v2/tenants/patch-settings

  """
  @spec update_setting(map(), config) ::
          {:ok, map()} | error
  def update_setting(%{} = params, %Config{} = config) do
    Settings.Patch.execute(params, config)
  end
end
