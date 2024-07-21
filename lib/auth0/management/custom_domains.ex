defmodule Auth0.Management.CustomDomains do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Management.CustomDomains.List
  alias Auth0.Management.CustomDomains.Configure
  alias Auth0.Management.CustomDomains.Get
  alias Auth0.Management.CustomDomains.Delete
  alias Auth0.Management.CustomDomains.Patch
  alias Auth0.Management.CustomDomains.Verify

  @type id :: String.t()
  @type config :: Config.t()
  @type error :: {:error, integer, term} | {:error, term}

  @doc """
  Retrieve details on custom domains.

  ## see
  https://auth0.com/docs/api/management/v2/custom-domains/get-custom-domains

  """
  @spec list(config) ::
          {:ok, list() | map()} | error
  def list(%Config{} = config) do
    List.execute(config)
  end

  @doc """
  Create a new custom domain.

  ## see
  https://auth0.com/docs/api/management/v2/custom-domains/post-custom-domains

  """
  @spec configure(map(), config) ::
          {:ok, list() | map()} | error
  def configure(%{} = params, %Config{} = config) do
    Configure.execute(params, config)
  end

  @doc """
  Get custom domain configuration.

  ## see
  https://auth0.com/docs/api/management/v2/custom-domains/get-custom-domains-by-id

  """
  @spec get(id, config) ::
          {:ok, list() | map()} | error
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
          {:ok, list() | map()} | error
  def update(id, %{} = params, %Config{} = config) do
    Patch.execute(id, params, config)
  end

  @doc """
  Run the verification process on a custom domain.

  ## see
  https://auth0.com/docs/api/management/v2/custom-domains/post-verify

  """
  @spec verify(id, config) ::
          {:ok, list() | map()} | error
  def verify(id, %Config{} = config) do
    Verify.execute(id, config)
  end
end
