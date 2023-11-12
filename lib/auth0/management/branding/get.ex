defmodule Auth0.Management.Branding.Get do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Management.Http
  alias Auth0.Entity.Branding

  @type endpoint :: String.t()
  @type config :: Config.t()
  @type entity :: Branding.t()
  @type response_body :: String.t()
  @type response :: {:ok, entity, response_body} | {:error, integer, term} | {:error, term}

  @doc """
  Get branding settings.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Branding/get_branding

  """
  @spec execute(endpoint, config) :: response
  def execute(endpoint, %Config{} = config) do
    Http.get(endpoint, config)
    |> case do
      {:ok, 200, body} -> {:ok, Branding.from(body |> Jason.decode!()), body}
      error -> error
    end
  end
end
