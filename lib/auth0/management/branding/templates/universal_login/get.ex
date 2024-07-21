defmodule Auth0.Management.Branding.Templates.UniversalLogin.Get do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Management.Http

  @type config :: Config.t()
  @type entity :: list() | map()
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

  @endpoint "/api/v2/branding/templates/universal-login"

  @doc """
  Get template for New Universal Login Experience

  ## see
  https://auth0.com/docs/api/management/v2/branding/get-universal-login

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
