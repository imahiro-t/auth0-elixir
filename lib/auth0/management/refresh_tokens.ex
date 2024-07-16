defmodule Auth0.Management.RefreshTokens do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Entity
  alias Auth0.Management.RefreshTokens.Get
  alias Auth0.Management.RefreshTokens.Delete

  @type id :: String.t()
  @type config :: Config.t()
  @type response_body :: String.t()
  @type error :: {:error, integer, term} | {:error, term}

  @endpoint_by_id "/api/v2/refresh-tokens/{id}"

  @doc """
  Retrieve refresh token information.

  ## see
  https://auth0.com/docs/api/management/v2/refresh-tokens/get-refresh-token

  """
  @spec get(id, config) ::
          {:ok, Entity.RefreshToken.t(), response_body} | error
  def get(id, %Config{} = config) do
    Get.execute(@endpoint_by_id, id, config)
  end

  @doc """
  Delete a refresh token by its ID.

  ## see
  https://auth0.com/docs/api/management/v2/refresh-tokens/delete-refresh-token

  """
  @spec delete(id, config) :: {:ok, String.t(), response_body} | error
  def delete(id, %Config{} = config) do
    Delete.execute(@endpoint_by_id, id, config)
  end
end
