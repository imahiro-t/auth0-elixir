defmodule Auth0.Management.Branding.Templates.UniversalLogin.Put do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Util
  alias Auth0.Common.Management.Http

  @type params :: map()
  @type config :: Config.t()
  @type entity :: String.t()
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

  @endpoint "/api/v2/branding/templates/universal-login"

  @doc """
  Update the Universal Login branding template.

  ## see
  https://auth0.com/docs/api/management/v2/branding/put-universal-login

  """
  @spec execute(params, config) :: response
  def execute(%{} = params, %Config{} = config) do
    body = params |> Util.remove_nil()

    Http.put(@endpoint, body, config)
    |> case do
      {:ok, 201, _body} -> {:ok, ""}
      {:ok, 204, _body} -> {:ok, ""}
      error -> error
    end
  end
end
