defmodule Auth0.Management.Users.AuthenticationMethods.PutAll do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Util
  alias Auth0.Common.Management.Http

  @type id :: String.t()
  @type params :: map()
  @type config :: Config.t()
  @type entity :: list() | map()
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

  @endpoint "/api/v2/users/{id}/authentication-methods"

  @doc """
  Replace the specified user authentication methods with supplied values.

  ## see
  https://auth0.com/docs/api/management/v2/users/put-authentication-methods

  """
  @spec execute(id, params, config) :: response
  def execute(id, %{} = params, %Config{} = config) do
    body = params |> Util.remove_nil()

    @endpoint
    |> String.replace("{id}", id)
    |> Http.put(body, config)
    |> case do
      {:ok, 200, body} -> {:ok, body |> Jason.decode!()}
      error -> error
    end
  end
end
