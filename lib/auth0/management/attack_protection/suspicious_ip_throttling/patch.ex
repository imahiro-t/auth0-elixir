defmodule Auth0.Management.AttackProtection.SuspiciousIpThrottling.Patch do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Util
  alias Auth0.Common.Management.Http

  @type params :: map()
  @type config :: Config.t()
  @type entity :: map()
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

  @endpoint "/api/v2/attack-protection/suspicious-ip-throttling"

  @doc """
  Update the details of the Suspicious IP Throttling configuration of your tenant.

  ## see
  https://auth0.com/docs/api/management/v2/attack-protection/patch-suspicious-ip-throttling

  """
  @spec execute(params, config) :: response
  def execute(%{} = params, %Config{} = config) do
    body = params |> Util.remove_nil()

    Http.patch(@endpoint, body, config)
    |> case do
      {:ok, 200, body} ->
        {:ok, body |> Jason.decode!()}

      error ->
        error
    end
  end
end
