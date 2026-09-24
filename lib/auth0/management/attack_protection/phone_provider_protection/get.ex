defmodule Auth0.Management.AttackProtection.PhoneProviderProtection.Get do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Management.Http

  @type config :: Config.t()
  @type entity :: map()
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

  @endpoint "/api/v2/attack-protection/phone-provider-protection"

  @doc """
  Get Phone Provider Protection settings.

  Get the phone provider protection configuration for a tenant.

  ## see
  https://auth0.com/docs/api/management/v2/attack-protection/get-phone-provider-protection

  """
  @spec execute(config) :: response
  def execute(%Config{} = config) do
    @endpoint
    |> Http.get(config)
    |> case do
      {:ok, 200, body} -> {:ok, body |> Jason.decode!()}
      error -> error
    end
  end
end
