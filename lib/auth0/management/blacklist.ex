defmodule Auth0.Management.Blacklist do
  @moduledoc """
  Documentation for Auth0 Management API of Blacklist.

  ## endpoint
  - /api/v2/blacklists/tokens
  """

  alias Auth0.Config
  alias Auth0.Entity
  alias Auth0.Management.Blacklist.Tokens

  @type config :: Config.t()
  @type response_body :: String.t()
  @type error :: {:error, integer, term} | {:error, term}

  @endpoint_tokens "/api/v2/blacklists/tokens"

  @doc """
  Get blacklisted tokens.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Blacklists/get_tokens

  """
  @spec list_tokens(Tokens.List.Params.t(), config) ::
          {:ok, Entity.BlacklistTokens.t(), response_body} | error
  def list_tokens(%Tokens.List.Params{} = params, %Config{} = config) do
    Tokens.List.execute(@endpoint_tokens, params, config)
  end

  @doc """
  Blacklist a token.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Blacklists/post_tokens

  """
  @spec add_token(Tokens.Add.Params.t(), config) :: {:ok, String.t(), response_body} | error
  def add_token(%Tokens.Add.Params{} = params, %Config{} = config) do
    Tokens.Add.execute(@endpoint_tokens, params, config)
  end
end
