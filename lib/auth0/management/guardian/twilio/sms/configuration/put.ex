defmodule Auth0.Management.Guardian.Twilio.Sms.Configuration.Put do
  @moduledoc """
  Documentation for Auth0 Management Update Twilio SMS configuration.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Guardian/put_twilio_0
  """

  alias Auth0.Config
  alias Auth0.Common.Util
  alias Auth0.Common.Management.Http
  alias Auth0.Entity.GuardianTwilioConfiguration

  defmodule Params do
    defstruct from: nil,
              messaging_service_sid: nil,
              auth_token: nil,
              sid: nil

    @type t :: %__MODULE__{
            from: String.t(),
            messaging_service_sid: String.t(),
            auth_token: String.t(),
            sid: String.t()
          }
  end

  @type endpoint :: String.t()
  @type params :: Params.t()
  @type config :: Config.t()
  @type entity :: GuardianTwilioConfiguration.t()
  @type response_body :: String.t()
  @type response :: {:ok, entity, response_body} | {:error, integer, term} | {:error, term}

  @doc """
  Update Twilio SMS configuration.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Guardian/put_twilio_0

  """
  @spec execute(endpoint, params, config) :: response
  def execute(endpoint, %Params{} = params, %Config{} = config) do
    body = params |> Util.to_map() |> Util.remove_nil()

    endpoint
    |> Http.put(body, config)
    |> case do
      {:ok, 200, body} ->
        {:ok, GuardianTwilioConfiguration.from(body |> Jason.decode!()), body}

      error ->
        error
    end
  end
end
