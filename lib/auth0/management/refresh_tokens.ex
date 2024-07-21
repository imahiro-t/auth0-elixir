defmodule Auth0.Management.RefreshTokens do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Management.RefreshTokens.Get
  alias Auth0.Management.RefreshTokens.Delete

  @type id :: String.t()
  @type config :: Config.t()
  @type error :: {:error, integer, term} | {:error, term}

  @doc """
  Retrieve refresh token information.

  ## see
  https://auth0.com/docs/api/management/v2/refresh-tokens/get-refresh-token

  """
  @spec get(id, config) ::
          {:ok, list() | map()} | error
  def get(id, %Config{} = config) do
    Get.execute(id, config)
  end

  @doc """
  Delete a refresh token by its ID.

  ## see
  https://auth0.com/docs/api/management/v2/refresh-tokens/delete-refresh-token

  """
  @spec delete(id, config) :: {:ok, String.t()} | error
  def delete(id, %Config{} = config) do
    Delete.execute(id, config)
  end
end
