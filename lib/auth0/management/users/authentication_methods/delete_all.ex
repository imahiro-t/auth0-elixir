defmodule Auth0.Management.Users.AuthenticationMethods.DeleteAll do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Management.Http

  @type id :: String.t()
  @type config :: Config.t()
  @type entity :: String.t()
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

  @endpoint "/api/v2/users/{id}/authentication-methods"

  @doc """
  Remove all authentication methods (i.e., enrolled MFA factors) from the specified user account. This action cannot be undone.

  ## see
  https://auth0.com/docs/api/management/v2/users/delete-authentication-methods

  """
  @spec execute(id, config) :: response
  def execute(id, %Config{} = config) do
    @endpoint
    |> String.replace("{id}", id)
    |> Http.delete(config)
    |> case do
      {:ok, 204, _body} -> {:ok, ""}
      error -> error
    end
  end
end
