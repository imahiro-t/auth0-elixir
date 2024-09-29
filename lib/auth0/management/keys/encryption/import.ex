defmodule Auth0.Management.Keys.Encryption.Import do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Util
  alias Auth0.Common.Management.Http

  @type kid :: String.t()
  @type params :: map()
  @type config :: Config.t()
  @type entity :: map()
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

  @endpoint "/api/v2/keys/encryption/{kid}"

  @doc """
  Import wrapped key material and activate encryption key.

  ## see
  https://auth0.com/docs/api/management/v2/keys/post-encryption-key

  """
  @spec execute(kid, params, config) :: response
  def execute(kid, %{} = params, %Config{} = config) do
    body = params |> Util.remove_nil()

    @endpoint
    |> String.replace("{kid}", kid)
    |> Http.post(body, config)
    |> case do
      {:ok, 201, body} -> {:ok, body |> Jason.decode!()}
      error -> error
    end
  end
end
