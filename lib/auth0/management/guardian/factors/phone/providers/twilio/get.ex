defmodule Auth0.Management.Guardian.Factors.Phone.Providers.Twilio.Get do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Management.Http

  @type config :: Config.t()
  @type entity :: map()
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

  @endpoint "/api/v2/guardian/factors/phone/providers/twilio"

  @doc """
  Retrieve configuration details for a Twilio phone provider that has been set up in your tenant.

  ## see
  https://auth0.com/docs/api/management/v2/guardian/get-phone-twilio-factor-provider

  """
  @spec execute(config) :: response
  def execute(%Config{} = config) do
    @endpoint
    |> Http.get(config)
    |> case do
      {:ok, 200, body} ->
        {:ok, body |> Jason.decode!()}

      error ->
        error
    end
  end
end
