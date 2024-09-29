defmodule Auth0.Management.Keys.Encryption.Rekey do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Management.Http

  @type config :: Config.t()
  @type entity :: String.t()
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

  @endpoint "/api/v2/keys/encryption"

  @doc """
  Perform rekeying operation on the key hierarchy.

  ## see
  https://auth0.com/docs/api/management/v2/keys/post-encryption-rekey

  """
  @spec execute(config) :: response
  def execute(%Config{} = config) do
    Http.post(@endpoint, {}, config)
    |> case do
      {:ok, 204, _body} -> {:ok, ""}
      error -> error
    end
  end
end
