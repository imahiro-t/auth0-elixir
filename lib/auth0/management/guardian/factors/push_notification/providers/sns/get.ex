defmodule Auth0.Management.Guardian.Factors.PushNotification.Providers.Sns.Get do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Management.Http

  @type config :: Config.t()
  @type entity :: map()
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

  @endpoint "/api/v2/guardian/factors/push-notification/providers/sns"

  @doc """
  Retrieve configuration details for an AWS SNS push notification provider that has been enabled for MFA.

  ## see
  https://auth0.com/docs/api/management/v2/guardian/get-sns

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
