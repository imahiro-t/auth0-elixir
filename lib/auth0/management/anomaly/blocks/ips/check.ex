defmodule Auth0.Management.Anomaly.Blocks.Ips.Check do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Management.Http

  @type ip :: String.t()
  @type config :: Config.t()
  @type entity :: boolean
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

  @endpoint "/api/v2/anomaly/blocks/ips/{id}"

  @doc """
  Check if the given IP address is blocked via the Suspicious IP Throttling due to multiple suspicious attempts.

  ## see
  https://auth0.com/docs/api/management/v2/anomaly/get-ips-by-id

  """
  @spec execute(ip, config) :: response
  def execute(ip, %Config{} = config) do
    @endpoint
    |> String.replace("{id}", ip)
    |> Http.get(config)
    |> case do
      {:ok, 200, _body} -> {:ok, true}
      {:error, 404, _body} -> {:ok, false}
      error -> error
    end
  end
end
