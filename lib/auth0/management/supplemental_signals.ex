defmodule Auth0.Management.SupplementalSignals do
  @moduledoc """
  Facade for the Auth0 Management API Supplemental Signals endpoints.

  Most applications should call `Auth0.Api.Management` instead of this module.
  """

  alias Auth0.Config
  alias Auth0.Management.SupplementalSignals.Create
  alias Auth0.Management.SupplementalSignals.Get
  alias Auth0.Management.SupplementalSignals.Settings.Get, as: SupplementalSignalsSettingsGet
  alias Auth0.Management.SupplementalSignals.Settings.Patch, as: SupplementalSignalsSettingsPatch

  @type id :: String.t()
  @type config :: Config.t()
  @type error :: {:error, integer, term} | {:error, term}

  @doc """
  Create a supplemental signal.

  ## see
  https://auth0.com/docs/api/management/v2/supplemental-signals/post-supplemental-signals
  """
  @spec create(map(), config) :: {:ok, map()} | error
  def create(%{} = params, %Config{} = config) do
    Create.execute(params, config)
  end

  @doc """
  Retrieve a supplemental signal by its ID.

  ## see
  https://auth0.com/docs/api/management/v2/supplemental-signals/get-supplemental-signals-by-id
  """
  @spec get(id, config) :: {:ok, map()} | error
  def get(id, %Config{} = config) do
    Get.execute(id, config)
  end

  @doc """
  Get the supplemental signals configuration for a tenant.

  **Early Access**: this endpoint is marked as Early Access (`x-release-lifecycle: EA`) in the Auth0 Management API specification and may not be available on every tenant.

  ## see
  https://auth0.com/docs/api/management/v2/supplemental-signals/get-supplemental-signals

  """
  @spec get_settings(config) :: {:ok, map()} | error
  def get_settings(%Config{} = config) do
    SupplementalSignalsSettingsGet.execute(config)
  end

  @doc """
  Update the supplemental signals configuration for a tenant.

  **Early Access**: this endpoint is marked as Early Access (`x-release-lifecycle: EA`) in the Auth0 Management API specification and may not be available on every tenant.

  ## see
  https://auth0.com/docs/api/management/v2/supplemental-signals/patch-supplemental-signals

  """
  @spec update_settings(map(), config) :: {:ok, map()} | error
  def update_settings(%{} = params, %Config{} = config) do
    SupplementalSignalsSettingsPatch.execute(params, config)
  end
end
