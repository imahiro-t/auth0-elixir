defmodule Auth0.Management.Connections.ScimConfiguration.Tokens.Delete do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Management.Http

  @type id :: String.t()
  @type token_id :: String.t()
  @type config :: Config.t()
  @type entity :: String.t()
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

  @endpoint "/api/v2/connections/{id}/scim-configuration/tokens/{tokenId}"

  @doc """
  Deletes a scim token by its connection id and tokenId.

  ## see
  https://auth0.com/docs/api/management/v2/connections/delete-tokens-by-token-id

  """
  @spec execute(id, token_id, config) :: response
  def execute(id, token_id, %Config{} = config) do
    @endpoint
    |> String.replace("{id}", id)
    |> String.replace("{tokenId}", token_id)
    |> Http.delete(config)
    |> case do
      {:ok, 204, _body} -> {:ok, ""}
      error -> error
    end
  end
end
