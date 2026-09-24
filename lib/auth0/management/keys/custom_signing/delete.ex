defmodule Auth0.Management.Keys.CustomSigning.Delete do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Management.Http

  @type config :: Config.t()
  @type entity :: String.t()
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

  @endpoint "/api/v2/keys/custom-signing"

  @doc """
  Delete custom signing keys.

  Delete entire jwks representation of custom signing keys.

  ## see
  https://auth0.com/docs/api/management/v2/keys/delete-custom-signing-keys

  """
  @spec execute(config) :: response
  def execute(%Config{} = config) do
    @endpoint
    |> Http.delete(config)
    |> case do
      {:ok, 204, _body} -> {:ok, ""}
      error -> error
    end
  end
end
