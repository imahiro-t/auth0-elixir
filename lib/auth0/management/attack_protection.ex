defmodule Auth0.Management.AttackProtection do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Management.AttackProtection.BreachedPasswordDetection
  alias Auth0.Management.AttackProtection.BruteForceProtection
  alias Auth0.Management.AttackProtection.SuspiciousIpThrottling

  @type config :: Config.t()
  @type error :: {:error, integer, term} | {:error, term}

  @doc """
  Retrieve details of the Breached Password Detection configuration of your tenant.

  ## see
  https://auth0.com/docs/api/management/v2/attack-protection/get-breached-password-detection

  """
  @spec get_breached_password_detection(config) ::
          {:ok, list() | map()} | error
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
          {:ok, list() | map()} | error
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
          {:ok, list() | map()} | error
  def get_brute_force_protection(%Config{} = config) do
    BruteForceProtection.Get.execute(config)
  end

  @doc """
  Update the Brute-force Protection configuration of your tenant.

  ## see
  https://auth0.com/docs/api/management/v2/attack-protection/patch-brute-force-protection

  """
  @spec update_brute_force_protection(map(), config) ::
          {:ok, list() | map()} | error
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
          {:ok, list() | map()} | error
  def get_suspicious_ip_throttling(%Config{} = config) do
    SuspiciousIpThrottling.Get.execute(config)
  end

  @doc """
  Update the details of the Suspicious IP Throttling configuration of your tenant.

  ## see
  https://auth0.com/docs/api/management/v2/attack-protection/patch-suspicious-ip-throttling

  """
  @spec update_suspicious_ip_throttling(map(), config) ::
          {:ok, list() | map()} | error
  def update_suspicious_ip_throttling(
        %{} = params,
        %Config{} = config
      ) do
    SuspiciousIpThrottling.Patch.execute(params, config)
  end
end
