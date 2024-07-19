defmodule Auth0.Management.UsersByEmail do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Management.UsersByEmail.List

  @type config :: Config.t()
  @type error :: {:error, integer, term} | {:error, term}

  @endpoint "/api/v2/users-by-email"

  @doc """
  Search Users by Email.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Users_By_Email/get_users_by_email

  """
  @spec list(List.Params.t() | map, config) :: {:ok, list() | map()} | error
  def list(%{} = params, %Config{} = config) do
    List.execute(@endpoint, params, config)
  end
end
