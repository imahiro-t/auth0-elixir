defmodule Auth0.Management.Branding.Themes.Get do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Management.Http

  @type theme_id :: String.t()
  @type config :: Config.t()
  @type entity :: map()
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

  @endpoint "/api/v2/branding/themes/{themeId}"

  @doc """
  Retrieve branding theme.

  ## see
  https://auth0.com/docs/api/management/v2/branding/get-branding-theme

  """
  @spec execute(theme_id, config) :: response
  def execute(theme_id, %Config{} = config) do
    @endpoint
    |> String.replace("{themeId}", theme_id)
    |> Http.get(config)
    |> case do
      {:ok, 200, body} -> {:ok, body |> Jason.decode!()}
      error -> error
    end
  end
end
