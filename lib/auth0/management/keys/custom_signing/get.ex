defmodule Auth0.Management.Keys.CustomSigning.Get do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Management.Http

  @type config :: Config.t()
  @type entity :: map()
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

  @endpoint "/api/v2/keys/custom-signing"

  @doc """
  Get custom signing keys.

  Get entire jwks representation of custom signing keys.

  ## see
  https://auth0.com/docs/api/management/v2/keys/get-custom-signing-keys

  """
  @spec execute(config) :: response
  def execute(%Config{} = config) do
    @endpoint
    |> Http.get(config)
    |> case do
      {:ok, 200, body} -> {:ok, body |> Jason.decode!()}
      error -> error
    end
  end
end
