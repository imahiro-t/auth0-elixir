defmodule Auth0.Management.Guardian.Twilio.Phone.Configuration.Get do
  @moduledoc """
  Documentation for Auth0 Management Retrieve Twilio phone configuration.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Guardian/get_twilio
  """

  alias Auth0.Config
  alias Auth0.Common.Management.Http
  alias Auth0.Entity.GuardianTwilioConfiguration

  @type endpoint :: String.t()
  @type config :: Config.t()
  @type entity :: GuardianTwilioConfiguration.t()
  @type response_body :: String.t()
  @type response :: {:ok, entity, response_body} | {:error, integer, term} | {:error, term}

  @doc """
  Retrieve Twilio phone configuration.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Guardian/get_twilio

  """
  @spec execute(endpoint, config) :: response
  def execute(endpoint, %Config{} = config) do
    endpoint
    |> Http.get(config)
    |> case do
      {:ok, 200, body} ->
        {:ok, GuardianTwilioConfiguration.from(body |> Jason.decode!()), body}

      error ->
        error
    end
  end
end
