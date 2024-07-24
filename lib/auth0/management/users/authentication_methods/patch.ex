defmodule Auth0.Management.Users.AuthenticationMethods.Patch do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Util
  alias Auth0.Common.Management.Http

  @type id :: String.t()
  @type authentication_method_id :: String.t()
  @type params :: map()
  @type config :: Config.t()
  @type entity :: map()
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

  @endpoint "/api/v2/users/{id}/authentication-methods/{authentication_method_id}"

  @doc """
  Modify the authentication method with the given ID from the specified user.

  ## see
  https://auth0.com/docs/api/management/v2/users/patch-authentication-methods-by-authentication-method-id

  """
  @spec execute(id, authentication_method_id, params, config) :: response
  def execute(id, authentication_method_id, %{} = params, %Config{} = config) do
    body = params |> Util.remove_nil()

    @endpoint
    |> String.replace("{id}", id)
    |> String.replace("{authentication_method_id}", authentication_method_id)
    |> Http.patch(body, config)
    |> case do
      {:ok, 200, body} -> {:ok, body |> Jason.decode!()}
      error -> error
    end
  end
end
