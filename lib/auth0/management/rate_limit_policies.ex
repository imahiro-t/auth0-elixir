defmodule Auth0.Management.RateLimitPolicies do
  @moduledoc """
  Facade for the Auth0 Management API Rate limit policies (Early Access).
  """

  alias Auth0.Config
  alias Auth0.Management.RateLimitPolicies.List, as: RateLimitPoliciesList
  alias Auth0.Management.RateLimitPolicies.Create, as: RateLimitPoliciesCreate
  alias Auth0.Management.RateLimitPolicies.Get, as: RateLimitPoliciesGet
  alias Auth0.Management.RateLimitPolicies.Patch, as: RateLimitPoliciesPatch
  alias Auth0.Management.RateLimitPolicies.Delete, as: RateLimitPoliciesDelete

  @type config :: Config.t()
  @type error :: {:error, integer, term} | {:error, term}

  @doc """
  Get rate limit policies.

  **Early Access**: this endpoint is marked as Early Access (`x-release-lifecycle: EA`) in the Auth0 Management API specification and may not be available on every tenant.

  ## see
  https://auth0.com/docs/api/management/v2/rate-limit-policies/get-rate-limit-policies

  """
  @spec list(map(), config) :: {:ok, map()} | error
  def list(%{} = params, %Config{} = config) do
    RateLimitPoliciesList.execute(params, config)
  end

  @doc """
  Create a rate limit policy.

  **Early Access**: this endpoint is marked as Early Access (`x-release-lifecycle: EA`) in the Auth0 Management API specification and may not be available on every tenant.

  ## see
  https://auth0.com/docs/api/management/v2/rate-limit-policies/post-rate-limit-policies

  """
  @spec create(map(), config) :: {:ok, map()} | error
  def create(%{} = params, %Config{} = config) do
    RateLimitPoliciesCreate.execute(params, config)
  end

  @doc """
  Get a rate limit policy.

  **Early Access**: this endpoint is marked as Early Access (`x-release-lifecycle: EA`) in the Auth0 Management API specification and may not be available on every tenant.

  ## see
  https://auth0.com/docs/api/management/v2/rate-limit-policies/get-rate-limit-policies-by-id

  """
  @spec get(String.t(), config) :: {:ok, map()} | error
  def get(id, %Config{} = config) do
    RateLimitPoliciesGet.execute(id, config)
  end

  @doc """
  Update a rate limit policy.

  **Early Access**: this endpoint is marked as Early Access (`x-release-lifecycle: EA`) in the Auth0 Management API specification and may not be available on every tenant.

  ## see
  https://auth0.com/docs/api/management/v2/rate-limit-policies/patch-rate-limit-policies-by-id

  """
  @spec update(String.t(), map(), config) :: {:ok, map()} | error
  def update(id, %{} = params, %Config{} = config) do
    RateLimitPoliciesPatch.execute(id, params, config)
  end

  @doc """
  Delete a rate limit policy.

  **Early Access**: this endpoint is marked as Early Access (`x-release-lifecycle: EA`) in the Auth0 Management API specification and may not be available on every tenant.

  ## see
  https://auth0.com/docs/api/management/v2/rate-limit-policies/delete-rate-limit-policies-by-id

  """
  @spec delete(String.t(), config) :: {:ok, String.t()} | error
  def delete(id, %Config{} = config) do
    RateLimitPoliciesDelete.execute(id, config)
  end
end
