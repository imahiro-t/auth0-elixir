defmodule Auth0.Management.Branding.Phone.Templates.Try do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Util
  alias Auth0.Common.Management.Http

  @type id :: String.t()
  @type params :: map()
  @type config :: Config.t()
  @type entity :: map()
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

  @endpoint "/api/v2/branding/phone/templates/{id}/try"

  @doc """
  Send a test phone notification for the configured template

  ## see
  https://auth0.com/docs/api/management/v2/branding/try-phone-template

  """
  @spec execute(id, params, config) :: response
  def execute(id, %{} = params, %Config{} = config) do
    body = params |> Util.remove_nil()

    @endpoint
    |> String.replace("{id}", id)
    |> Http.post(body, config)
    |> case do
      {:ok, 202, body} -> {:ok, body |> Jason.decode!()}
      error -> error
    end
  end
end
