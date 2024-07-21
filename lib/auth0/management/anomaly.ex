defmodule Auth0.Management.Anomaly do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Management.Anomaly.Blocks

  @type config :: Config.t()
  @type ip :: String.t()
  @type error :: {:error, integer, term} | {:error, term}

  @doc """
  Check if the given IP address is blocked via the Suspicious IP Throttling due to multiple suspicious attempts.

  ## see
  https://auth0.com/docs/api/management/v2/anomaly/get-ips-by-id

  """
  @spec check_ip_blocked(ip, config) :: {:ok, boolean} | error
  def check_ip_blocked(ip, %Config{} = config) do
    Blocks.Ips.Check.execute(ip, config)
  end

  @doc """
  Remove a block imposed by Suspicious IP Throttling for the given IP address.

  ## see
  https://auth0.com/docs/api/management/v2/anomaly/delete-ips-by-id

  """
  @spec remove_blocked_ip(ip, config) :: {:ok, String.t()} | error
  def remove_blocked_ip(ip, %Config{} = config) do
    Blocks.Ips.Remove.execute(ip, config)
  end
end
