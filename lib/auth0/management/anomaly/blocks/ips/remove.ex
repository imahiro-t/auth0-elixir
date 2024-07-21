defmodule Auth0.Management.Anomaly.Blocks.Ips.Remove do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Management.Http

  @type ip :: String.t()
  @type config :: Config.t()
  @type entity :: String.t()
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

  @endpoint "/api/v2/anomaly/blocks/ips/{id}"

  @doc """
  Remove a block imposed by Suspicious IP Throttling for the given IP address.

  ## see
  https://auth0.com/docs/api/management/v2/anomaly/delete-ips-by-id

  """
  @spec execute(ip, config) :: response
  def execute(ip, %Config{} = config) do
    @endpoint
    |> String.replace("{id}", ip)
    |> Http.delete(config)
    |> case do
      {:ok, 204, _body} -> {:ok, ""}
      error -> error
    end
  end
end
