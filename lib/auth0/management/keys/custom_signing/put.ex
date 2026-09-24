defmodule Auth0.Management.Keys.CustomSigning.Put do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Management.Http

  @type params :: map()
  @type config :: Config.t()
  @type entity :: map()
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

  @endpoint "/api/v2/keys/custom-signing"

  @doc """
  Create or replace custom signing keys.

  Create or replace entire jwks representation of custom signing keys.

  ## see
  https://auth0.com/docs/api/management/v2/keys/put-custom-signing-keys

  """
  @spec execute(params, config) :: response
  def execute(%{} = params, %Config{} = config) do
    @endpoint
    |> Http.put(params, config)
    |> case do
      {:ok, 200, body} -> {:ok, body |> Jason.decode!()}
      error -> error
    end
  end
end
