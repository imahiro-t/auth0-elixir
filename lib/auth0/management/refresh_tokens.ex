defmodule Auth0.Management.RefreshTokens do
  @moduledoc """
  Facade for the Auth0 Management API Refresh Tokens endpoints.

  Most applications should call `Auth0.Api.Management` instead of this module.
  """

  alias Auth0.Config
  alias Auth0.Management.RefreshTokens.Get
  alias Auth0.Management.RefreshTokens.Delete
  alias Auth0.Management.RefreshTokens.List, as: RefreshTokensList
  alias Auth0.Management.RefreshTokens.Revoke, as: RefreshTokensRevoke
  alias Auth0.Management.RefreshTokens.Patch, as: RefreshTokensPatch

  @type id :: String.t()
  @type config :: Config.t()
  @type error :: {:error, integer, term} | {:error, term}

  @doc """
  Retrieve refresh token information.

  ## see
  https://auth0.com/docs/api/management/v2/refresh-tokens/get-refresh-token

  """
  @spec get(id, config) ::
          {:ok, map()} | error
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

  @doc """
  Get refresh tokens.

  Retrieve a paginated list of refresh tokens for a specific user, with optional filtering by client ID. Results are sorted by credential_id ascending.

  **Early Access**: this endpoint is marked as Early Access (`x-release-lifecycle: EA`) in the Auth0 Management API specification and may not be available on every tenant.

  ## see
  https://auth0.com/docs/api/management/v2/refresh-tokens/get-refresh-tokens

  """
  @spec list(map(), config) :: {:ok, map()} | error
  def list(%{} = params, %Config{} = config) do
    RefreshTokensList.execute(params, config)
  end

  @doc """
  Revoke refresh tokens.

  Revoke refresh tokens in bulk by ID list, user, user+client, or user+client+audience.

  **Early Access**: this endpoint is marked as Early Access (`x-release-lifecycle: EA`) in the Auth0 Management API specification and may not be available on every tenant.

  ## see
  https://auth0.com/docs/api/management/v2/refresh-tokens/revoke-refresh-tokens

  """
  @spec revoke(map(), config) :: {:ok, String.t()} | error
  def revoke(%{} = params, %Config{} = config) do
    RefreshTokensRevoke.execute(params, config)
  end

  @doc """
  Update a refresh token.

  Update a refresh token by its ID.

  ## see
  https://auth0.com/docs/api/management/v2/refresh-tokens/patch-refresh-tokens-by-id

  """
  @spec update(String.t(), map(), config) :: {:ok, map()} | error
  def update(id, %{} = params, %Config{} = config) do
    RefreshTokensPatch.execute(id, params, config)
  end
end
