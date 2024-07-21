defmodule Auth0.Management.Branding.Templates.UniversalLogin.Delete do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Management.Http

  @type config :: Config.t()
  @type entity :: String.t()
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

  @endpoint "/api/v2/branding/templates/universal-login"

  @doc """
  Delete template for New Universal Login Experience

  ## see
  https://auth0.com/docs/api/management/v2/branding/delete-universal-login

  """
  @spec execute(config) :: response
  def execute(%Config{} = config) do
    Http.delete(@endpoint, config)
    |> case do
      {:ok, 204, _body} -> {:ok, ""}
      error -> error
    end
  end
end
