defmodule Auth0.Management.Branding.Themes.Delete do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Management.Http

  @type endpoint :: String.t()
  @type theme_id :: String.t()
  @type config :: Config.t()
  @type entity :: String.t()
  @type response_body :: String.t()
  @type response :: {:ok, entity, response_body} | {:error, integer, term} | {:error, term}

  @doc """
  Delete branding theme.

  ## see
  https://auth0.com/docs/api/management/v2#!/Branding/delete_branding_theme

  """
  @spec execute(endpoint, theme_id, config) :: response
  def execute(endpoint, theme_id, %Config{} = config) do
    endpoint
    |> String.replace("{themeId}", theme_id)
    |> Http.delete(config)
    |> case do
      {:ok, 204, body} -> {:ok, "", body}
      error -> error
    end
  end
end
