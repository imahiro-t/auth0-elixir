defmodule Auth0.Authentication.Token do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Entity
  alias Auth0.Authentication.Token.ClientCredentials

  @type config :: Config.t()
  @type error :: {:error, integer, term} | {:error, term}

  @doc """
  Client Credentials Flow.

  ## see
  https://auth0.com/docs/api/authentication#client-credentials-flow

  """
  @spec token_by_client_credentials(ClientCredentials.Params.t(), config) ::
          {:ok, Entity.Token.t()} | error
  def token_by_client_credentials(%ClientCredentials.Params{} = params, %Config{} = config) do
    ClientCredentials.execute(params, config)
  end
end
