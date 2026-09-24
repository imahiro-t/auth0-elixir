defmodule Auth0.Management.RiskAssessments do
  @moduledoc """
  Facade for the Auth0 Management API Risk Assessments endpoints.

  Most applications should call `Auth0.Api.Management` instead of this module.
  """

  alias Auth0.Config
  alias Auth0.Management.RiskAssessments.Create
  alias Auth0.Management.RiskAssessments.Get
  alias Auth0.Management.RiskAssessments.Settings.Get, as: RiskAssessmentsSettingsGet
  alias Auth0.Management.RiskAssessments.Settings.Patch, as: RiskAssessmentsSettingsPatch

  alias Auth0.Management.RiskAssessments.Settings.NewDevice.Get,
    as: RiskAssessmentsSettingsNewDeviceGet

  alias Auth0.Management.RiskAssessments.Settings.NewDevice.Patch,
    as: RiskAssessmentsSettingsNewDevicePatch

  @type id :: String.t()
  @type config :: Config.t()
  @type error :: {:error, integer, term} | {:error, term}

  @doc """
  Create a risk assessment.

  **Deprecated**: `POST /api/v2/risk-assessments` / `GET /api/v2/risk-assessments/{id}` are not part of the Auth0 Management API v2 specification. Use `get_settings/1` / `update_settings/2` instead.

  ## see
  https://auth0.com/docs/api/management/v2/risk-assessments/post-risk-assessments
  """
  @spec create(map(), config) :: {:ok, map()} | error
  def create(%{} = params, %Config{} = config) do
    Create.execute(params, config)
  end

  @doc """
  Retrieve a risk assessment by its ID.

  **Deprecated**: `POST /api/v2/risk-assessments` / `GET /api/v2/risk-assessments/{id}` are not part of the Auth0 Management API v2 specification. Use `get_settings/1` / `update_settings/2` instead.

  ## see
  https://auth0.com/docs/api/management/v2/risk-assessments/get-risk-assessments-by-id
  """
  @spec get(id, config) :: {:ok, map()} | error
  def get(id, %Config{} = config) do
    Get.execute(id, config)
  end

  @doc """
  Get risk assessment settings.

  Gets the tenant settings for risk assessments

  ## see
  https://auth0.com/docs/api/management/v2/risk-assessments/get-risk-assessments-settings

  """
  @spec get_settings(config) :: {:ok, map()} | error
  def get_settings(%Config{} = config) do
    RiskAssessmentsSettingsGet.execute(config)
  end

  @doc """
  Update risk assessment settings.

  Updates the tenant settings for risk assessments

  ## see
  https://auth0.com/docs/api/management/v2/risk-assessments/patch-risk-assessments-settings

  """
  @spec update_settings(map(), config) :: {:ok, map()} | error
  def update_settings(%{} = params, %Config{} = config) do
    RiskAssessmentsSettingsPatch.execute(params, config)
  end

  @doc """
  Get new device assessor.

  Gets the risk assessment settings for the new device assessor

  ## see
  https://auth0.com/docs/api/management/v2/risk-assessments/get-new-device

  """
  @spec get_new_device_settings(config) :: {:ok, map()} | error
  def get_new_device_settings(%Config{} = config) do
    RiskAssessmentsSettingsNewDeviceGet.execute(config)
  end

  @doc """
  Update new device assessor.

  Updates the risk assessment settings for the new device assessor

  ## see
  https://auth0.com/docs/api/management/v2/risk-assessments/patch-new-device

  """
  @spec update_new_device_settings(map(), config) :: {:ok, map()} | error
  def update_new_device_settings(%{} = params, %Config{} = config) do
    RiskAssessmentsSettingsNewDevicePatch.execute(params, config)
  end
end
