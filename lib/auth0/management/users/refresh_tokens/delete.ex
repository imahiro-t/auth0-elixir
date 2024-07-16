defmodule Auth0.Management.Users.RefreshTokens.Delete do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Management.Http

  @type endpoint :: String.t()
  @type user_id :: String.t()
  @type config :: Config.t()
  @type entity :: String.t()
  @type response_body :: String.t()
  @type response :: {:ok, entity, response_body} | {:error, integer, term} | {:error, term}

  @doc """
  Delete all refresh tokens for a user.

  ## see
  https://auth0.com/docs/api/management/v2/users/delete-refresh-tokens-for-user

  """
  @spec execute(endpoint, user_id, config) :: response
  def execute(endpoint, user_id, %Config{} = config) do
    endpoint
    |> String.replace("{user_id}", user_id)
    |> Http.delete(config)
    |> case do
      {:ok, 202, body} -> {:ok, "", body}
      error -> error
    end
  end
end
