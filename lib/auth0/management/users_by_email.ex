defmodule Auth0.Management.UsersByEmail do
  @moduledoc """
  Documentation for Auth0 Management API of UsersByEmail.

  ## endpoint
  - /api/v2/users-by-email
  """

  alias Auth0.Config
  alias Auth0.Entity
  alias Auth0.Management.UsersByEmail.List

  @type config :: Config.t()
  @type response_body :: String.t()
  @type error :: {:error, integer, term} | {:error, term}

  @endpoint "/api/v2/users-by-email"

  @doc """
  Search Users by Email.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Users_By_Email/get_users_by_email

  """
  @spec list(List.Params.t(), config) :: {:ok, Entity.Users.t(), response_body} | error
  def list(%List.Params{} = params, %Config{} = config) do
    List.execute(@endpoint, params, config)
  end
end
