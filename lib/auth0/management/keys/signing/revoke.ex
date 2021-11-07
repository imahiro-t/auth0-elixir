defmodule Auth0.Management.Keys.Signing.Revoke do
  @moduledoc """
  Documentation for Auth0 Management Revoke an Application Signing Key by its key id.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Keys/put_signing_keys
  """

  alias Auth0.Config
  alias Auth0.Common.Management.Http
  alias Auth0.Entity.SigningKey

  @type endpoint :: String.t()
  @type kid :: String.t()
  @type config :: Config.t()
  @type entity :: SigningKey.t()
  @type response_body :: String.t()
  @type response :: {:ok, entity, response_body} | {:error, integer, term} | {:error, term}

  @doc """
  Revoke an Application Signing Key by its key id.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Keys/put_signing_keys

  """
  @spec execute(endpoint, kid, config) :: response
  def execute(endpoint, kid, %Config{} = config) do
    endpoint
    |> String.replace("{kid}", kid)
    |> Http.put(%{}, config)
    |> case do
      {:ok, 200, body} -> {:ok, SigningKey.from(body |> Jason.decode!()), body}
      error -> error
    end
  end
end
