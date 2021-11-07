defmodule Auth0.Management.Blacklist.Tokens.List do
  @moduledoc """
  Documentation for Auth0 Management Get blacklisted tokens.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Blacklists/get_tokens
  """

  alias Auth0.Config
  alias Auth0.Common.Util
  alias Auth0.Common.Management.Http
  alias Auth0.Entity.BlacklistTokens

  defmodule Params do
    defstruct aud: nil

    @type t :: %__MODULE__{
            aud: String.t()
          }
  end

  @type endpoint :: String.t()
  @type params :: Params.t()
  @type config :: Config.t()
  @type entity :: BlacklistTokens.t()
  @type response_body :: String.t()
  @type response :: {:ok, entity, response_body} | {:error, integer, term} | {:error, term}

  @doc """
  Get blacklisted tokens.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Blacklists/get_tokens

  """
  @spec execute(endpoint, params, config) :: response
  def execute(endpoint, %Params{} = params, %Config{} = config) do
    params
    |> Util.to_map()
    |> Util.convert_to_query()
    |> Util.append_query(endpoint)
    |> Http.get(config)
    |> case do
      {:ok, 200, body} -> {:ok, BlacklistTokens.from(body |> Jason.decode!()), body}
      error -> error
    end
  end
end
