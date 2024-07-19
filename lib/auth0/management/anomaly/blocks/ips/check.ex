defmodule Auth0.Management.Anomaly.Blocks.Ips.Check do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Management.Http

  @type endpoint :: String.t()
  @type ip :: String.t()
  @type config :: Config.t()
  @type entity :: boolean
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

  @doc """
  Check if an IP address is blocked.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Anomaly/get_ips_by_id

  """
  @spec execute(endpoint, ip, config) :: response
  def execute(endpoint, ip, %Config{} = config) do
    endpoint
    |> String.replace("{id}", ip)
    |> Http.get(config)
    |> case do
      {:ok, 200, _body} -> {:ok, true}
      {:error, 404, _body} -> {:ok, false}
      error -> error
    end
  end
end
