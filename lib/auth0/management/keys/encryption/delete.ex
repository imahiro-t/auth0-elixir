defmodule Auth0.Management.Keys.Encryption.Delete do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Management.Http

  @type kid :: String.t()
  @type config :: Config.t()
  @type entity :: String.t()
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

  @endpoint "/api/v2/keys/encryption/{kid}"

  @doc """
  Delete the custom provided encryption key with the given ID and move back to using native encryption key.

  ## see
  https://auth0.com/docs/api/management/v2/keys/delete-encryption-key

  """
  @spec execute(kid, config) :: response
  def execute(kid, %Config{} = config) do
    @endpoint
    |> String.replace("{kid}", kid)
    |> Http.delete(config)
    |> case do
      {:ok, 204, _body} -> {:ok, ""}
      error -> error
    end
  end
end
