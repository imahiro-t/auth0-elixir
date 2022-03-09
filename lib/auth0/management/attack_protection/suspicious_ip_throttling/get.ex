defmodule Auth0.Management.AttackProtection.SuspiciousIpThrottling.Get do
  @moduledoc """
  Documentation for Auth0 Management Get the suspicious IP throttling configuration.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Attack_Protection/get_suspicious_ip_throttling
  """

  alias Auth0.Config
  alias Auth0.Common.Management.Http
  alias Auth0.Entity.AttackProtectionSuspiciousIpThrottling

  @type endpoint :: String.t()
  @type config :: Config.t()
  @type entity :: AttackProtectionSuspiciousIpThrottling.t()
  @type response_body :: String.t()
  @type response :: {:ok, entity, response_body} | {:error, integer, term} | {:error, term}

  @doc """
  Get the suspicious IP throttling configuration.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Attack_Protection/get_suspicious_ip_throttling

  """
  @spec execute(endpoint, config) :: response
  def execute(endpoint, %Config{} = config) do
    Http.get(endpoint, config)
    |> case do
      {:ok, 200, body} ->
        {:ok, AttackProtectionSuspiciousIpThrottling.from(body |> Jason.decode!()), body}

      error ->
        error
    end
  end
end
