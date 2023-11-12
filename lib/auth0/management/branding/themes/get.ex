defmodule Auth0.Management.Branding.Themes.Get do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Management.Http
  alias Auth0.Entity.Theme

  @type endpoint :: String.t()
  @type theme_id :: String.t()
  @type config :: Config.t()
  @type entity :: Theme.t()
  @type response_body :: String.t()
  @type response :: {:ok, entity, response_body} | {:error, integer, term} | {:error, term}

  @doc """
  Get branding theme.

  ## see
  https://auth0.com/docs/api/management/v2#!/Branding/get_branding_theme

  """
  @spec execute(endpoint, theme_id, config) :: response
  def execute(endpoint, theme_id, %Config{} = config) do
    endpoint
    |> String.replace("{themeId}", theme_id)
    |> Http.get(config)
    |> case do
      {:ok, 200, body} -> {:ok, Theme.from(body |> Jason.decode!()), body}
      error -> error
    end
  end
end
