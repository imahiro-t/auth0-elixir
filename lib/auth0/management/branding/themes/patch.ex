defmodule Auth0.Management.Branding.Themes.Patch do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Util
  alias Auth0.Common.Management.Http

  @type theme_id :: String.t()
  @type params :: map()
  @type config :: Config.t()
  @type entity :: list() | map()
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

  @endpoint "/api/v2/branding/themes/{themeId}"

  @doc """
  Update branding theme.

  ## see
  https://auth0.com/docs/api/management/v2/branding/patch-branding-theme

  """
  @spec execute(theme_id, params, config) :: response
  def execute(theme_id, %{} = params, %Config{} = config) do
    body = params |> Util.remove_nil()

    @endpoint
    |> String.replace("{themeId}", theme_id)
    |> Http.patch(body, config)
    |> case do
      {:ok, 200, body} -> {:ok, body |> Jason.decode!()}
      error -> error
    end
  end
end
