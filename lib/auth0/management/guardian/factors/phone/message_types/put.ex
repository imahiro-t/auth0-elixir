defmodule Auth0.Management.Guardian.Factors.Phone.MessageTypes.Put do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Util
  alias Auth0.Common.Management.Http

  @type params :: map()
  @type config :: Config.t()
  @type entity :: map()
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

  @endpoint "/api/v2/guardian/factors/phone/message-types"

  @doc """
  Replace the list of phone-type MFA factors (i.e., sms and voice) that are enabled for your tenant.

  ## see
  https://auth0.com/docs/api/management/v2/guardian/put-message-types

  """
  @spec execute(params, config) :: response
  def execute(%{} = params, %Config{} = config) do
    body = params |> Util.remove_nil()

    @endpoint
    |> Http.put(body, config)
    |> case do
      {:ok, 200, body} -> {:ok, body |> Jason.decode!()}
      error -> error
    end
  end
end
