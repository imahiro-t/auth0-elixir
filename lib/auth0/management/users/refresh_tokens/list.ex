defmodule Auth0.Management.Users.RefreshTokens.List do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Util
  alias Auth0.Common.Management.Http

  @type user_id :: String.t()
  @type params :: map()
  @type config :: Config.t()
  @type entity :: map()
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

  @endpoint "/api/v2/users/{user_id}/refresh-tokens"

  @doc """
  Retrieve details for a user's refresh tokens.

  ## see
  https://auth0.com/docs/api/management/v2/users/get-refresh-tokens-for-user

  """
  @spec execute(user_id, params, config) :: response
  def execute(user_id, %{} = params, %Config{} = config) do
    params
    |> Util.convert_to_query()
    |> Util.append_query(@endpoint |> String.replace("{user_id}", user_id))
    |> Http.get(config)
    |> case do
      {:ok, 200, body} -> {:ok, body |> Jason.decode!()}
      error -> error
    end
  end
end
