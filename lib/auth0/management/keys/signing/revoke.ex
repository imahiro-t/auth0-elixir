defmodule Auth0.Management.Keys.Signing.Revoke do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Management.Http

  @type kid :: String.t()
  @type config :: Config.t()
  @type entity :: list() | map()
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

  @endpoint "/api/v2/keys/signing/{kid}/revoke"

  @doc """
  Revoke the application signing key with the given ID.

  ## see
  https://auth0.com/docs/api/management/v2/keys/put-signing-keys

  """
  @spec execute(kid, config) :: response
  def execute(kid, %Config{} = config) do
    @endpoint
    |> String.replace("{kid}", kid)
    |> Http.put(%{}, config)
    |> case do
      {:ok, 200, body} -> {:ok, body |> Jason.decode!()}
      error -> error
    end
  end
end
