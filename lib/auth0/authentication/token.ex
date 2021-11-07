defmodule Auth0.Authentication.Token do
  @moduledoc """
  Documentation for Auth0 Authentication API of Token.

  ## endpoint
  - /oauth/token
  """

  alias Auth0.Config
  alias Auth0.Entity
  alias Auth0.Authentication.Token.ClientCredentials

  @type config :: Config.t()
  @type response_body :: String.t()
  @type error :: {:error, integer, term} | {:error, term}

  @endpoint "/oauth/token"

  @doc """
  Client Credentials Flow.

  ## see
  https://auth0.com/docs/api/authentication#client-credentials-flow

  """
  @spec token_by_client_credentials(ClientCredentials.Params.t(), config) ::
          {:ok, Entity.Token.t(), response_body} | error
  def token_by_client_credentials(%ClientCredentials.Params{} = params, %Config{} = config) do
    ClientCredentials.execute(@endpoint, params, config)
  end
end
