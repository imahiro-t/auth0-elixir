defmodule Auth0.Management.Branding.Templates.UniversalLogin.Get do
  @moduledoc """
  Documentation for Auth0 Management Get template for New Universal Login Experience.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Branding/get_universal_login
  """

  alias Auth0.Config
  alias Auth0.Common.Management.Http
  alias Auth0.Entity.UniversalLogin

  @type endpoint :: String.t()
  @type config :: Config.t()
  @type entity :: UniversalLogin.t()
  @type response_body :: String.t()
  @type response :: {:ok, entity, response_body} | {:error, integer, term} | {:error, term}

  @doc """
  Get template for New Universal Login Experience.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Branding/get_universal_login

  """
  @spec execute(endpoint, config) :: response
  def execute(endpoint, %Config{} = config) do
    Http.get(endpoint, config)
    |> case do
      {:ok, 200, body} -> {:ok, UniversalLogin.from(body |> Jason.decode!()), body}
      error -> error
    end
  end
end
