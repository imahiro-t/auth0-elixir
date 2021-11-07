defmodule Auth0.Management.Keys.Signing.List do
  @moduledoc """
  Documentation for Auth0 Management Get all Application Signing Keys.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Keys/get_signing_keys
  """

  alias Auth0.Config
  alias Auth0.Common.Management.Http
  alias Auth0.Entity.SigningKeys

  @type endpoint :: String.t()
  @type config :: Config.t()
  @type entity :: SigningKeys.t()
  @type response_body :: String.t()
  @type response :: {:ok, entity, response_body} | {:error, integer, term} | {:error, term}

  @doc """
  Get all Application Signing Keys.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Keys/get_signing_keys

  """
  @spec execute(endpoint, config) :: response
  def execute(endpoint, %Config{} = config) do
    endpoint
    |> Http.get(config)
    |> case do
      {:ok, 200, body} -> {:ok, SigningKeys.from(body |> Jason.decode!()), body}
      error -> error
    end
  end
end
