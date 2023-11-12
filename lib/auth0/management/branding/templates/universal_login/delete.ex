defmodule Auth0.Management.Branding.Templates.UniversalLogin.Delete do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Management.Http

  @type endpoint :: String.t()
  @type config :: Config.t()
  @type entity :: String.t()
  @type response_body :: String.t()
  @type response :: {:ok, entity, response_body} | {:error, integer, term} | {:error, term}

  @doc """
  Delete template for New Universal Login Experience.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Branding/delete_universal_login

  """
  @spec execute(endpoint, config) :: response
  def execute(endpoint, %Config{} = config) do
    Http.delete(endpoint, config)
    |> case do
      {:ok, 204, body} -> {:ok, "", body}
      error -> error
    end
  end
end
