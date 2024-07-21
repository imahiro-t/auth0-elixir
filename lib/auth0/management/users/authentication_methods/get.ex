defmodule Auth0.Management.Users.AuthenticationMethods.Get do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Management.Http

  @type id :: String.t()
  @type authentication_method_id :: String.t()
  @type config :: Config.t()
  @type entity :: list() | map()
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

  @endpoint "/api/v2/users/{id}/authentication-methods/{authentication_method_id}"

  @doc """
  Get an authentication method by ID

  ## see
  https://auth0.com/docs/api/management/v2/users/get-authentication-methods-by-authentication-method-id

  """
  @spec execute(id, authentication_method_id, config) :: response
  def execute(id, authentication_method_id, %Config{} = config) do
    @endpoint
    |> String.replace("{id}", id)
    |> String.replace("{authentication_method_id}", authentication_method_id)
    |> Http.get(config)
    |> case do
      {:ok, 200, body} -> {:ok, body |> Jason.decode!()}
      error -> error
    end
  end
end
