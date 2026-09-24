defmodule Auth0.Management.AttackProtection.PhoneProviderProtection.Patch do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Management.Http

  @type params :: map()
  @type config :: Config.t()
  @type entity :: map()
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

  @endpoint "/api/v2/attack-protection/phone-provider-protection"

  @doc """
  Update Phone Provider Protection settings.

  Update the phone provider protection configuration for a tenant.

  ## see
  https://auth0.com/docs/api/management/v2/attack-protection/patch-phone-provider-protection

  """
  @spec execute(params, config) :: response
  def execute(%{} = params, %Config{} = config) do
    @endpoint
    |> Http.patch(params, config)
    |> case do
      {:ok, 200, body} -> {:ok, body |> Jason.decode!()}
      error -> error
    end
  end
end
