defmodule Auth0.Management.Users.Identities.Unlink do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Management.Http

  @type id :: String.t()
  @type provider :: String.t()
  @type user_id :: String.t()
  @type config :: Config.t()
  @type entity :: list(map())
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

  @endpoint "/api/v2/users/{id}/identities/{provider}/{user_id}"

  @doc """
  Unlink a specific secondary account from a target user. This action requires the ID of both the target user and the secondary account.

  ## see
  https://auth0.com/docs/api/management/v2/users/delete-user-identity-by-user-id

  """
  @spec execute(id, provider, user_id, config) :: response
  def execute(id, provider, user_id, %Config{} = config) do
    @endpoint
    |> String.replace("{id}", id)
    |> String.replace("{provider}", provider)
    |> String.replace("{user_id}", user_id)
    |> Http.delete(config)
    |> case do
      {:ok, 200, body} -> {:ok, body |> Jason.decode!()}
      error -> error
    end
  end
end
