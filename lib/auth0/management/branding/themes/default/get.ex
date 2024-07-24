defmodule Auth0.Management.Branding.Themes.Default.Get do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Management.Http

  @type config :: Config.t()
  @type entity :: map()
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

  @endpoint "/api/v2/branding/themes/default"

  @doc """
  Retrieve default branding theme.

  ## see
  https://auth0.com/docs/api/management/v2/branding/get-default-branding-theme

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
