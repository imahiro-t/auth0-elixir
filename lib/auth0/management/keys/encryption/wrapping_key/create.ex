defmodule Auth0.Management.Keys.Encryption.WrappingKey.Create do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Management.Http

  @type kid :: String.t()
  @type config :: Config.t()
  @type entity :: map()
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

  @endpoint "/api/v2/keys/encryption/{kid}/wrapping-key"

  @doc """
  Create the public wrapping key to wrap your own encryption key material.

  ## see
  https://auth0.com/docs/api/management/v2/keys/post-encryption-wrapping-key

  """
  @spec execute(kid, config) :: response
  def execute(kid, %Config{} = config) do
    @endpoint
    |> String.replace("{kid}", kid)
    |> Http.post({}, config)
    |> case do
      {:ok, 201, body} -> {:ok, body |> Jason.decode!()}
      error -> error
    end
  end
end
