defmodule Auth0.Management.Users.Create do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Util
  alias Auth0.Common.Management.Http

  @type params :: map()
  @type config :: Config.t()
  @type entity :: list() | map()
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

  @endpoint "/api/v2/users"

  @doc """
  Create a new user for a given database or passwordless connection.

  ## see
  https://auth0.com/docs/api/management/v2/users/post-users

  """
  @spec execute(params, config) :: response
  def execute(%{} = params, %Config{} = config) do
    body = params |> Util.remove_nil()

    Http.post(@endpoint, body, config)
    |> case do
      {:ok, 201, body} -> {:ok, body |> Jason.decode!()}
      error -> error
    end
  end
end
