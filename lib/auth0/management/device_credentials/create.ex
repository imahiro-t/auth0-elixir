defmodule Auth0.Management.DeviceCredentials.Create do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Util
  alias Auth0.Common.Management.Http

  @type params :: map()
  @type config :: Config.t()
  @type entity :: list() | map()
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

  @endpoint "/api/v2/device-credentials"

  @doc """
  Create a device credential public key to manage refresh token rotation for a given user_id. Device Credentials APIs are designed for ad-hoc administrative use only and paging is by default enabled for GET requests.

  ## see
  https://auth0.com/docs/api/management/v2/device-credentials/post-device-credentials

  """
  @spec execute(params, config) :: response
  def execute(%{} = params, %Config{} = config) do
    body = params |> Util.remove_nil()

    Http.post(@endpoint, body, config)
    |> case do
      {:ok, 201, body} -> {:ok, body |> Jason.decode!()}
      error -> error
    end
  end
end
