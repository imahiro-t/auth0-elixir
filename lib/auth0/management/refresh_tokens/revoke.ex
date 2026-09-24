defmodule Auth0.Management.RefreshTokens.Revoke do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Management.Http

  @type params :: map()
  @type config :: Config.t()
  @type entity :: String.t()
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

  @endpoint "/api/v2/refresh-tokens/revoke"

  @doc """
  Revoke refresh tokens.

  Revoke refresh tokens in bulk by ID list, user, user+client, or user+client+audience.

  **Early Access**: this endpoint is marked as Early Access (`x-release-lifecycle: EA`) in the Auth0 Management API specification and may not be available on every tenant.

  ## see
  https://auth0.com/docs/api/management/v2/refresh-tokens/revoke-refresh-tokens

  """
  @spec execute(params, config) :: response
  def execute(%{} = params, %Config{} = config) do
    @endpoint
    |> Http.post(params, config)
    |> case do
      {:ok, 202, _body} -> {:ok, ""}
      error -> error
    end
  end
end
