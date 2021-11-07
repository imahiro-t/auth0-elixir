defmodule Auth0.Management.Guardian.Sms.Configuration.Get do
  @moduledoc """
  Documentation for Auth0 Management Retrieve SMS configuration (one of auth0|twilio|phone-message-hook).

  ## see
  https://auth0.com/docs/api/management/v2/#!/Guardian/get_selected_provider_0
  """

  alias Auth0.Config
  alias Auth0.Common.Management.Http
  alias Auth0.Entity.GuardianSmsConfiguration

  @type endpoint :: String.t()
  @type config :: Config.t()
  @type entity :: GuardianSmsConfiguration.t()
  @type response_body :: String.t()
  @type response :: {:ok, entity, response_body} | {:error, integer, term} | {:error, term}

  @doc """
  Retrieve SMS configuration (one of auth0|twilio|phone-message-hook).

  ## see
  https://auth0.com/docs/api/management/v2/#!/Guardian/get_selected_provider_0

  """
  @spec execute(endpoint, config) :: response
  def execute(endpoint, %Config{} = config) do
    endpoint
    |> Http.get(config)
    |> case do
      {:ok, 200, body} ->
        {:ok, GuardianSmsConfiguration.from(body |> Jason.decode!()), body}

      error ->
        error
    end
  end
end
