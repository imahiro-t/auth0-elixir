defmodule Auth0.Authentication do
  @moduledoc """
  Documentation for Auth0 Authentication API.

  """

  alias Auth0.Config
  alias Auth0.Entity
  alias Auth0.Authentication.Token

  @type config :: Config.t()
  @type response_body :: String.t()
  @type error :: {:error, integer, term} | {:error, term}

  @doc """
  Client Credentials Flow.

  ## see
  https://auth0.com/docs/api/authentication#client-credentials-flow

  """
  @spec token_by_client_credentials(Token.ClientCredentials.Params.t(), config) ::
          {:ok, Entity.Token.t(), response_body} | error
  def token_by_client_credentials(%Token.ClientCredentials.Params{} = params, %Config{} = config) do
    Token.token_by_client_credentials(params, config)
  end
end
