defmodule Auth0.Management.Users.AuthenticationMethods.Delete do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Management.Http

  @type id :: String.t()
  @type authentication_method_id :: String.t()
  @type config :: Config.t()
  @type entity :: String.t()
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

  @endpoint "/api/v2/users/{id}/authentication-methods/{authentication_method_id}"

  @doc """
  Remove the authentication method with the given ID from the specified user.

  ## see
  https://auth0.com/docs/api/management/v2/users/delete-authentication-methods-by-authentication-method-id

  """
  @spec execute(id, authentication_method_id, config) :: response
  def execute(id, authentication_method_id, %Config{} = config) do
    @endpoint
    |> String.replace("{id}", id)
    |> String.replace("{authentication_method_id}", authentication_method_id)
    |> Http.delete(config)
    |> case do
      {:ok, 204, _body} -> {:ok, ""}
      error -> error
    end
  end
end
