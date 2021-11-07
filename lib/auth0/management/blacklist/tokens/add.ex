defmodule Auth0.Management.Blacklist.Tokens.Add do
  @moduledoc """
  Documentation for Auth0 Management Blacklist a token.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Blacklists/post_tokens
  """

  alias Auth0.Config
  alias Auth0.Common.Util
  alias Auth0.Common.Management.Http

  defmodule Params do
    defstruct aud: nil,
              jti: nil

    @type t :: %__MODULE__{
            aud: String.t(),
            jti: String.t()
          }
  end

  @type endpoint :: String.t()
  @type params :: Params.t()
  @type config :: Config.t()
  @type entity :: String.t()
  @type response_body :: String.t()
  @type response :: {:ok, entity, response_body} | {:error, integer, term} | {:error, term}

  @doc """
  Blacklist a token.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Blacklists/post_tokens

  """
  @spec execute(endpoint, params, config) :: response
  def execute(endpoint, %Params{} = params, %Config{} = config) do
    body = params |> Util.to_map() |> Util.remove_nil()

    Http.post(endpoint, body, config)
    |> case do
      {:ok, 204, body} -> {:ok, "", body}
      error -> error
    end
  end
end
