defmodule Auth0.Management.Guardian.Factors.PushNotification.Providers.Fcm.Put do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Util
  alias Auth0.Common.Management.Http

  @type params :: map()
  @type config :: Config.t()
  @type entity :: map()
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

  @endpoint "/api/v2/guardian/factors/push-notification/providers/fcm"

  @doc """
  Overwrite all configuration details of the multi-factor authentication FCM provider associated with your tenant.

  ## see
  https://auth0.com/docs/api/management/v2/guardian/put-fcm

  """
  @spec execute(params, config) :: response
  def execute(%{} = params, %Config{} = config) do
    body = params |> Util.remove_nil()

    @endpoint
    |> Http.put(body, config)
    |> case do
      {:ok, 200, body} ->
        {:ok, body |> Jason.decode!()}

      error ->
        error
    end
  end
end
