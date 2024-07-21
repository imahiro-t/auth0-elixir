defmodule Auth0.Management.Users.Multifactor.InvalidateRememberedBrowser do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Management.Http

  @type id :: String.t()
  @type config :: Config.t()
  @type entity :: String.t()
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

  @endpoint "/api/v2/users/{id}/multifactor/actions/invalidate-remember-browser"

  @doc """
  Invalidate all remembered browsers across all authentication factors for a user.

  ## see
  https://auth0.com/docs/api/management/v2/users/post-invalidate-remember-browser

  """
  @spec execute(id, config) :: response
  def execute(id, %Config{} = config) do
    @endpoint
    |> String.replace("{id}", id)
    |> Http.post(%{}, config)
    |> case do
      {:ok, 204, _body} -> {:ok, ""}
      error -> error
    end
  end
end
