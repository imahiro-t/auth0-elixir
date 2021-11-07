defmodule Auth0.Management.Keys.Signing.Rotate do
  @moduledoc """
  Documentation for Auth0 Management Rotate the Application Signing Key.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Keys/post_signing_keys
  """

  alias Auth0.Config
  alias Auth0.Common.Management.Http
  alias Auth0.Entity.SigningKey

  @type endpoint :: String.t()
  @type config :: Config.t()
  @type entity :: SigningKey.t()
  @type response_body :: String.t()
  @type response :: {:ok, entity, response_body} | {:error, integer, term} | {:error, term}

  @doc """
  Rotate the Application Signing Key.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Keys/post_signing_keys

  """
  @spec execute(endpoint, config) :: response
  def execute(endpoint, %Config{} = config) do
    endpoint
    |> Http.post(%{}, config)
    |> case do
      {:ok, 201, body} -> {:ok, SigningKey.from(body |> Jason.decode!()), body}
      error -> error
    end
  end
end
