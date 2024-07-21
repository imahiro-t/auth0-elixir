defmodule Auth0.Management.Guardian.Twilio.Sms.Configuration.Get do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Management.Http

  @type config :: Config.t()
  @type entity :: list() | map()
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

  @endpoint "/api/v2/guardian/factors/sms/providers/twilio"

  @doc """
  Retrieve the Twilio SMS provider configuration (subscription required).

  ## see
  https://auth0.com/docs/api/management/v2/guardian/get-sms-twilio-factor-provider

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
