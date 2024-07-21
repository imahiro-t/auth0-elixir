defmodule Auth0.Management.Users.Sessions.Delete do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Management.Http

  @type user_id :: String.t()
  @type config :: Config.t()
  @type entity :: String.t()
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

  @endpoint "/api/v2/users/{user_id}/sessions"

  @doc """
  Delete all sessions for a user.

  ## see
  https://auth0.com/docs/api/management/v2/users/delete-sessions-for-user

  """
  @spec execute(user_id, config) :: response
  def execute(user_id, %Config{} = config) do
    @endpoint
    |> String.replace("{user_id}", user_id)
    |> Http.delete(config)
    |> case do
      {:ok, 202, _body} -> {:ok, ""}
      error -> error
    end
  end
end
