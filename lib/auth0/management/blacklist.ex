defmodule Auth0.Management.Blacklist do
  @moduledoc """
  Facade for the Auth0 Management API Blacklist endpoints.

  Most applications should call `Auth0.Api.Management` instead of this module.
  """

  alias Auth0.Config
  alias Auth0.Management.Blacklist.Tokens

  @type config :: Config.t()
  @type error :: {:error, integer, term} | {:error, term}

  @doc """
  Retrieve the jti and aud of all tokens that are blacklisted.

  ## see
  https://auth0.com/docs/api/management/v2/blacklists/get-tokens

  """
  @spec list_tokens(map(), config) ::
          {:ok, list(map())} | error
  def list_tokens(%{} = params, %Config{} = config) do
    Tokens.List.execute(params, config)
  end

  @doc """
  Add the token identified by the jti to a blacklist for the tenant.

  ## see
  https://auth0.com/docs/api/management/v2/blacklists/post-tokens

  """
  @spec add_token(map(), config) :: {:ok, String.t()} | error
  def add_token(%{} = params, %Config{} = config) do
    Tokens.Add.execute(params, config)
  end
end
