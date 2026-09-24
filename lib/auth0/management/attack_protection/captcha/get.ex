defmodule Auth0.Management.AttackProtection.Captcha.Get do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Management.Http

  @type config :: Config.t()
  @type entity :: map()
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

  @endpoint "/api/v2/attack-protection/captcha"

  @doc """
  Get the CAPTCHA configuration for a tenant.

  Get the CAPTCHA configuration for your client.

  ## see
  https://auth0.com/docs/api/management/v2/attack-protection/get-captcha

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
