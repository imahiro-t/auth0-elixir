defmodule Auth0.Management.AttackProtection do
  @moduledoc """
  Documentation for Auth0 Management API of AttackProAuth0.Management.AttackProtection.

  ## endpoint
  - /api/v2/attack-protection/breached-password-detection
  - /api/v2/attack-protection/brute-force-protection
  - /api/v2/attack-protection/suspicious-ip-throttling
  """

  alias Auth0.Config
  alias Auth0.Entity
  alias Auth0.Management.AttackProtection.BreachedPasswordDetection
  alias Auth0.Management.AttackProtection.BruteForceProtection
  alias Auth0.Management.AttackProtection.SuspiciousIpThrottling

  @type config :: Config.t()
  @type response_body :: String.t()
  @type error :: {:error, integer, term} | {:error, term}

  @endpoint_breached_password_detection "/api/v2/attack-protection/breached-password-detection"
  @endpoint_brute_force_protection "/api/v2/attack-protection/brute-force-protection"
  @endpoint_suspicious_ip_throttling "/api/v2/attack-protection/suspicious-ip-throttling"

  @doc """
  Get breached password detection settings.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Attack_Protection/get_breached_password_detection

  """
  @spec get_breached_password_detection(config) ::
          {:ok, Entity.AttackProtectionBreachedPasswordDetection.t(), response_body} | error
  def get_breached_password_detection(%Config{} = config) do
    BreachedPasswordDetection.Get.execute(@endpoint_breached_password_detection, config)
  end

  @doc """
  Update breached password detection settings.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Attack_Protection/patch_breached_password_detection

  """
  @spec update_breached_password_detection(BreachedPasswordDetection.Patch.Params.t(), config) ::
          {:ok, Entity.AttackProtectionBreachedPasswordDetection.t(), response_body} | error
  def update_breached_password_detection(
        %BreachedPasswordDetection.Patch.Params{} = params,
        %Config{} = config
      ) do
    BreachedPasswordDetection.Patch.execute(@endpoint_breached_password_detection, params, config)
  end

  @doc """
  Get the brute force configuration.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Attack_Protection/get_brute_force_protection

  """
  @spec get_brute_force_protection(config) ::
          {:ok, Entity.AttackProtectionBruteForceProtection.t(), response_body} | error
  def get_brute_force_protection(%Config{} = config) do
    BruteForceProtection.Get.execute(@endpoint_brute_force_protection, config)
  end

  @doc """
  Update the brute force configuration.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Attack_Protection/patch_brute_force_protection

  """
  @spec update_brute_force_protection(BruteForceProtection.Patch.Params.t(), config) ::
          {:ok, Entity.AttackProtectionBruteForceProtection.t(), response_body} | error
  def update_brute_force_protection(
        %BruteForceProtection.Patch.Params{} = params,
        %Config{} = config
      ) do
    BruteForceProtection.Patch.execute(@endpoint_brute_force_protection, params, config)
  end

  @doc """
  Get the suspicious IP throttling configuration.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Attack_Protection/get_suspicious_ip_throttling

  """
  @spec get_suspicious_ip_throttling(config) ::
          {:ok, Entity.AttackProtectionSuspiciousIpThrottling.t(), response_body} | error
  def get_suspicious_ip_throttling(%Config{} = config) do
    SuspiciousIpThrottling.Get.execute(@endpoint_suspicious_ip_throttling, config)
  end

  @doc """
  Update the suspicious IP throttling configuration.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Attack_Protection/patch_suspicious_ip_throttling

  """
  @spec update_suspicious_ip_throttling(SuspiciousIpThrottling.Patch.Params.t(), config) ::
          {:ok, Entity.AttackProtectionSuspiciousIpThrottling.t(), response_body} | error
  def update_suspicious_ip_throttling(
        %SuspiciousIpThrottling.Patch.Params{} = params,
        %Config{} = config
      ) do
    SuspiciousIpThrottling.Patch.execute(@endpoint_suspicious_ip_throttling, params, config)
  end
end
