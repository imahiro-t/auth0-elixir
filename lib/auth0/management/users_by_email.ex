defmodule Auth0.Management.UsersByEmail do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Management.UsersByEmail.List

  @type config :: Config.t()
  @type error :: {:error, integer, term} | {:error, term}

  @doc """
  Find users by email. If Auth0 is the identity provider (idP), the email address associated with a user is saved in lower case, regardless of how you initially provided it.

  ## see
  https://auth0.com/docs/api/management/v2/users-by-email/get-users-by-email

  """
  @spec list(map(), config) :: {:ok, list() | map()} | error
  def list(%{} = params, %Config{} = config) do
    List.execute(params, config)
  end
end
