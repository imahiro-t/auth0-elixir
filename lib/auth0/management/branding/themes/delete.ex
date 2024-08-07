defmodule Auth0.Management.Branding.Themes.Delete do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Management.Http

  @type theme_id :: String.t()
  @type config :: Config.t()
  @type entity :: String.t()
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

  @endpoint "/api/v2/branding/themes/{themeId}"

  @doc """
  Delete branding theme.

  ## see
  https://auth0.com/docs/api/management/v2/branding/delete-branding-theme

  """
  @spec execute(theme_id, config) :: response
  def execute(theme_id, %Config{} = config) do
    @endpoint
    |> String.replace("{themeId}", theme_id)
    |> Http.delete(config)
    |> case do
      {:ok, 204, _body} -> {:ok, ""}
      error -> error
    end
  end
end
