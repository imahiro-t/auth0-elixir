defmodule Auth0.Management.Users.Identities.Unlink do
  @moduledoc """
  Documentation for Auth0 Management Unlink a User Identity.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Users/delete_user_identity_by_user_id
  """

  alias Auth0.Config
  alias Auth0.Common.Management.Http
  alias Auth0.Entity.Identities

  @type endpoint :: String.t()
  @type id :: String.t()
  @type provider :: String.t()
  @type user_id :: String.t()
  @type config :: Config.t()
  @type entity :: Identities.t()
  @type response_body :: String.t()
  @type response :: {:ok, entity, response_body} | {:error, integer, term} | {:error, term}

  @doc """
  Unlink a User Identity.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Users/delete_user_identity_by_user_id

  """
  @spec execute(endpoint, id, provider, user_id, config) :: response
  def execute(endpoint, id, provider, user_id, %Config{} = config) do
    endpoint
    |> String.replace("{id}", id)
    |> String.replace("{provider}", provider)
    |> String.replace("{user_id}", user_id)
    |> Http.delete(config)
    |> case do
      {:ok, 200, body} -> {:ok, Identities.from(body |> Jason.decode!()), body}
      error -> error
    end
  end
end
