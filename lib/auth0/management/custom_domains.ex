defmodule Auth0.Management.CustomDomains do
  @moduledoc """
  Facade for the Auth0 Management API Custom Domains endpoints.

  Most applications should call `Auth0.Api.Management` instead of this module.
  """

  alias Auth0.Config
  alias Auth0.Management.CustomDomains.List
  alias Auth0.Management.CustomDomains.Configure
  alias Auth0.Management.CustomDomains.Get
  alias Auth0.Management.CustomDomains.Delete
  alias Auth0.Management.CustomDomains.Patch
  alias Auth0.Management.CustomDomains.Verify
  alias Auth0.Management.CustomDomains.Default.Get, as: CustomDomainsDefaultGet
  alias Auth0.Management.CustomDomains.Default.Patch, as: CustomDomainsDefaultPatch
  alias Auth0.Management.CustomDomains.Test, as: CustomDomainsTest

  @type id :: String.t()
  @type config :: Config.t()
  @type error :: {:error, integer, term} | {:error, term}

  @doc """
  Retrieve details on custom domains.

  ## see
  https://auth0.com/docs/api/management/v2/custom-domains/get-custom-domains

  """
  @spec list(config) ::
          {:ok, list(map())} | error
  def list(%Config{} = config) do
    List.execute(config)
  end

  @doc """
  Create a new custom domain.

  ## see
  https://auth0.com/docs/api/management/v2/custom-domains/post-custom-domains

  """
  @spec configure(map(), config) ::
          {:ok, map()} | error
  def configure(%{} = params, %Config{} = config) do
    Configure.execute(params, config)
  end

  @doc """
  Get custom domain configuration.

  ## see
  https://auth0.com/docs/api/management/v2/custom-domains/get-custom-domains-by-id

  """
  @spec get(id, config) ::
          {:ok, map()} | error
  def get(id, %Config{} = config) do
    Get.execute(id, config)
  end

  @doc """
  Delete a custom domain and stop serving requests for it.

  ## see
  https://auth0.com/docs/api/management/v2/custom-domains/delete-custom-domains-by-id

  """
  @spec delete(id, config) :: {:ok, String.t()} | error
  def delete(id, %Config{} = config) do
    Delete.execute(id, config)
  end

  @doc """
  Update a custom domain.

  ## see
  https://auth0.com/docs/api/management/v2/custom-domains/patch-custom-domains-by-id

  """
  @spec update(id, map(), config) ::
          {:ok, map()} | error
  def update(id, %{} = params, %Config{} = config) do
    Patch.execute(id, params, config)
  end

  @doc """
  Run the verification process on a custom domain.

  ## see
  https://auth0.com/docs/api/management/v2/custom-domains/post-verify

  """
  @spec verify(id, config) ::
          {:ok, map()} | error
  def verify(id, %Config{} = config) do
    Verify.execute(id, config)
  end

  @doc """
  Get the default domain.

  Retrieve the tenant's default domain.

  ## see
  https://auth0.com/docs/api/management/v2/custom-domains/get-default

  """
  @spec get_default(config) :: {:ok, map() | list(map())} | error
  def get_default(%Config{} = config) do
    CustomDomainsDefaultGet.execute(config)
  end

  @doc """
  Update the default custom domain for the tenant.

  Set the default custom domain for the tenant.

  ## see
  https://auth0.com/docs/api/management/v2/custom-domains/patch-default

  """
  @spec set_default(map(), config) :: {:ok, map() | list(map())} | error
  def set_default(%{} = params, %Config{} = config) do
    CustomDomainsDefaultPatch.execute(params, config)
  end

  @doc """
  Test a custom domain.

  Run the test process on a custom domain.

  ## see
  https://auth0.com/docs/api/management/v2/custom-domains/post-test-domain

  """
  @spec test(String.t(), config) :: {:ok, map()} | error
  def test(id, %Config{} = config) do
    CustomDomainsTest.execute(id, config)
  end
end
