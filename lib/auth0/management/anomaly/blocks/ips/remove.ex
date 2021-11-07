defmodule Auth0.Management.Anomaly.Blocks.Ips.Remove do
  @moduledoc """
  Documentation for Auth0 Management Remove the blocked IP address.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Anomaly/delete_ips_by_id
  """

  alias Auth0.Config
  alias Auth0.Common.Management.Http

  @type endpoint :: String.t()
  @type ip :: String.t()
  @type config :: Config.t()
  @type entity :: String.t()
  @type response_body :: String.t()
  @type response :: {:ok, entity, response_body} | {:error, integer, term} | {:error, term}

  @doc """
  Remove the blocked IP address.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Anomaly/delete_ips_by_id

  """
  @spec execute(endpoint, ip, config) :: response
  def execute(endpoint, ip, %Config{} = config) do
    endpoint
    |> String.replace("{id}", ip)
    |> Http.delete(config)
    |> case do
      {:ok, 204, body} -> {:ok, "", body}
      error -> error
    end
  end
end
