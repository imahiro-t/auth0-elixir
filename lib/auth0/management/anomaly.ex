defmodule Auth0.Management.Anomaly do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Management.Anomaly.Blocks

  @type config :: Config.t()
  @type ip :: String.t()
  @type response_body :: String.t()
  @type error :: {:error, integer, term} | {:error, term}

  @endpoint_blocks_by_id "/api/v2/anomaly/blocks/ips/{id}"

  @doc """
  Check if an IP address is blocked.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Anomaly/get_ips_by_id

  """
  @spec check_ip_blocked(ip, config) :: {:ok, boolean, response_body} | error
  def check_ip_blocked(ip, %Config{} = config) do
    Blocks.Ips.Check.execute(@endpoint_blocks_by_id, ip, config)
  end

  @doc """
  Remove the blocked IP address.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Anomaly/delete_ips_by_id

  """
  @spec remove_blocked_ip(ip, config) :: {:ok, String.t(), response_body} | error
  def remove_blocked_ip(ip, %Config{} = config) do
    Blocks.Ips.Remove.execute(@endpoint_blocks_by_id, ip, config)
  end
end
