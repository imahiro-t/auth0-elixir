defmodule Auth0.Management.Branding.Themes.Default.Get do
  @moduledoc """
  Documentation for Auth0 Management Retrieve default branding theme.

  ## see
  https://auth0.com/docs/api/management/v2#!/Branding/get_default_branding_theme
  """

  alias Auth0.Config
  alias Auth0.Common.Management.Http
  alias Auth0.Entity.Theme

  @type endpoint :: String.t()
  @type config :: Config.t()
  @type entity :: Theme.t()
  @type response_body :: String.t()
  @type response :: {:ok, entity, response_body} | {:error, integer, term} | {:error, term}

  @doc """
  Retrieve default branding theme.

  ## see
  https://auth0.com/docs/api/management/v2#!/Branding/get_default_branding_theme

  """
  @spec execute(endpoint, config) :: response
  def execute(endpoint, %Config{} = config) do
    Http.get(endpoint, config)
    |> case do
      {:ok, 200, body} -> {:ok, Theme.from(body |> Jason.decode!()), body}
      error -> error
    end
  end
end
