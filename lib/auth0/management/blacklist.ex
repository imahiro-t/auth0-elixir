defmodule Auth0.Management.Blacklist do
  @moduledoc false

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
  @spec list_tokens(Tokens.List.Params.t() | map, config) ::
          {:ok, Entity.BlacklistTokens.t(), response_body} | error
  def list_tokens(%{} = params, %Config{} = config) do
    Tokens.List.execute(@endpoint_tokens, params, config)
  end

  @doc """
  Blacklist a token.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Blacklists/post_tokens

  """
  @spec add_token(Tokens.Add.Params.t() | map, config) :: {:ok, String.t(), response_body} | error
  def add_token(%{} = params, %Config{} = config) do
    Tokens.Add.execute(@endpoint_tokens, params, config)
  end
end
