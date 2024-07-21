defmodule Auth0.Management.Branding.Get do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Management.Http

  @type config :: Config.t()
  @type entity :: list() | map()
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

  @endpoint "/api/v2/branding"

  @doc """
  Retrieve branding settings.

  ## see
  https://auth0.com/docs/api/management/v2/branding/get-branding

  """
  @spec execute(config) :: response
  def execute(%Config{} = config) do
    Http.get(@endpoint, config)
    |> case do
      {:ok, 200, body} -> {:ok, body |> Jason.decode!()}
      error -> error
    end
  end
end
