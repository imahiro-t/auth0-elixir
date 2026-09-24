defmodule Auth0.Management.AttackProtection do
  @moduledoc """
  Facade for the Auth0 Management API Attack Protection endpoints.

  Most applications should call `Auth0.Api.Management` instead of this module.
  """

  alias Auth0.Config
  alias Auth0.Management.AttackProtection.BreachedPasswordDetection
  alias Auth0.Management.AttackProtection.BruteForceProtection
  alias Auth0.Management.AttackProtection.SuspiciousIpThrottling
  alias Auth0.Management.AttackProtection.BotDetection
  alias Auth0.Management.AttackProtection.Captcha.Get, as: AttackProtectionCaptchaGet
  alias Auth0.Management.AttackProtection.Captcha.Patch, as: AttackProtectionCaptchaPatch

  alias Auth0.Management.AttackProtection.PhoneProviderProtection.Get,
    as: AttackProtectionPhoneProviderProtectionGet

  alias Auth0.Management.AttackProtection.PhoneProviderProtection.Patch,
    as: AttackProtectionPhoneProviderProtectionPatch

  @type config :: Config.t()
  @type error :: {:error, integer, term} | {:error, term}

  @doc """
  Retrieve details of the Bot Detection configuration of your tenant.

  ## see
  There is no public documentation for this endpoint yet, but it follows the standard pattern.
  """
  @spec get_bot_detection(config) :: {:ok, map()} | error
  def get_bot_detection(%Config{} = config) do
    BotDetection.Get.execute(config)
  end

  @doc """
  Update details of the Bot Detection configuration of your tenant.

  ## see
  There is no public documentation for this endpoint yet, but it follows the standard pattern.
  """
  @spec update_bot_detection(map(), config) :: {:ok, map()} | error
  def update_bot_detection(%{} = params, %Config{} = config) do
    BotDetection.Patch.execute(params, config)
  end

  @doc """
  Retrieve details of the Breached Password Detection configuration of your tenant.

  ## see
  https://auth0.com/docs/api/management/v2/attack-protection/get-breached-password-detection

  """
  @spec get_breached_password_detection(config) ::
          {:ok, map()} | error
  def get_breached_password_detection(%Config{} = config) do
    BreachedPasswordDetection.Get.execute(config)
  end

  @doc """
  Update details of the Breached Password Detection configuration of your tenant.

  ## see
  https://auth0.com/docs/api/management/v2/attack-protection/patch-breached-password-detection

  """
  @spec update_breached_password_detection(
          map(),
          config
        ) ::
          {:ok, map()} | error
  def update_breached_password_detection(
        %{} = params,
        %Config{} = config
      ) do
    BreachedPasswordDetection.Patch.execute(params, config)
  end

  @doc """
  Retrieve details of the Brute-force Protection configuration of your tenant.

  ## see
  https://auth0.com/docs/api/management/v2/attack-protection/get-brute-force-protection

  """
  @spec get_brute_force_protection(config) ::
          {:ok, map()} | error
  def get_brute_force_protection(%Config{} = config) do
    BruteForceProtection.Get.execute(config)
  end

  @doc """
  Update the Brute-force Protection configuration of your tenant.

  ## see
  https://auth0.com/docs/api/management/v2/attack-protection/patch-brute-force-protection

  """
  @spec update_brute_force_protection(map(), config) ::
          {:ok, map()} | error
  def update_brute_force_protection(
        %{} = params,
        %Config{} = config
      ) do
    BruteForceProtection.Patch.execute(params, config)
  end

  @doc """
  Retrieve details of the Suspicious IP Throttling configuration of your tenant.

  ## see
  https://auth0.com/docs/api/management/v2/attack-protection/get-suspicious-ip-throttling

  """
  @spec get_suspicious_ip_throttling(config) ::
          {:ok, map()} | error
  def get_suspicious_ip_throttling(%Config{} = config) do
    SuspiciousIpThrottling.Get.execute(config)
  end

  @doc """
  Update the details of the Suspicious IP Throttling configuration of your tenant.

  ## see
  https://auth0.com/docs/api/management/v2/attack-protection/patch-suspicious-ip-throttling

  """
  @spec update_suspicious_ip_throttling(map(), config) ::
          {:ok, map()} | error
  def update_suspicious_ip_throttling(
        %{} = params,
        %Config{} = config
      ) do
    SuspiciousIpThrottling.Patch.execute(params, config)
  end

  @doc """
  Get the CAPTCHA configuration for a tenant.

  Get the CAPTCHA configuration for your client.

  ## see
  https://auth0.com/docs/api/management/v2/attack-protection/get-captcha

  """
  @spec get_captcha(config) :: {:ok, map()} | error
  def get_captcha(%Config{} = config) do
    AttackProtectionCaptchaGet.execute(config)
  end

  @doc """
  Partial Update for CAPTCHA Configuration.

  Update existing CAPTCHA configuration for your client.

  ## see
  https://auth0.com/docs/api/management/v2/attack-protection/patch-captcha

  """
  @spec update_captcha(map(), config) :: {:ok, map()} | error
  def update_captcha(%{} = params, %Config{} = config) do
    AttackProtectionCaptchaPatch.execute(params, config)
  end

  @doc """
  Get Phone Provider Protection settings.

  Get the phone provider protection configuration for a tenant.

  ## see
  https://auth0.com/docs/api/management/v2/attack-protection/get-phone-provider-protection

  """
  @spec get_phone_provider_protection(config) :: {:ok, map()} | error
  def get_phone_provider_protection(%Config{} = config) do
    AttackProtectionPhoneProviderProtectionGet.execute(config)
  end

  @doc """
  Update Phone Provider Protection settings.

  Update the phone provider protection configuration for a tenant.

  ## see
  https://auth0.com/docs/api/management/v2/attack-protection/patch-phone-provider-protection

  """
  @spec update_phone_provider_protection(map(), config) :: {:ok, map()} | error
  def update_phone_provider_protection(%{} = params, %Config{} = config) do
    AttackProtectionPhoneProviderProtectionPatch.execute(params, config)
  end
end
