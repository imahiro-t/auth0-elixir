defmodule Auth0.Management.Keys.Encryption.Get do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Management.Http

  @type kid :: String.t()
  @type config :: Config.t()
  @type entity :: map()
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

  @endpoint "/api/v2/keys/encryption/{kid}"

  @doc """
  Retrieve details of the encryption key with the given ID.

  ## see
  https://auth0.com/docs/api/management/v2/keys/get-encryption-key

  """
  @spec execute(kid, config) :: response
  def execute(kid, %Config{} = config) do
    @endpoint
    |> String.replace("{kid}", kid)
    |> Http.get(config)
    |> case do
      {:ok, 200, body} -> {:ok, body |> Jason.decode!()}
      error -> error
    end
  end
end
