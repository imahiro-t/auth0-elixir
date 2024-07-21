defmodule Auth0.Management.Guardian.Sms.Configuration.Get do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Management.Http

  @type config :: Config.t()
  @type entity :: list() | map()
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

  @endpoint "/api/v2/guardian/factors/sms/selected-provider"

  @doc """
  Retrieve SMS configuration (one of auth0|twilio|phone-message-hook).

  ## see
  https://auth0.com/docs/api/management/v2/guardian/get-sms-providers

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
