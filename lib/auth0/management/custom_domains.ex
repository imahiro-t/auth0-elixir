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

  @endpoint "/api/v2/custom-domains"
  @endpoint_by_id "/api/v2/custom-domains/{id}"
  @endpoint_verify "/api/v2/custom-domains/{id}/verify"

  @doc """
  Get custom domains configurations.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Custom_Domains/get_custom_domains

  """
  @spec list(config) ::
          {:ok, list() | map()} | error
  def list(%Config{} = config) do
    List.execute(@endpoint, config)
  end

  @doc """
  Configure a new custom domain.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Custom_Domains/post_custom_domains

  """
  @spec configure(Configure.Params.t() | map, config) ::
          {:ok, list() | map()} | error
  def configure(%{} = params, %Config{} = config) do
    Configure.execute(@endpoint, params, config)
  end

  @doc """
  Get custom domain configuration.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Custom_Domains/get_custom_domains_by_id

  """
  @spec get(id, config) ::
          {:ok, list() | map()} | error
  def get(id, %Config{} = config) do
    Get.execute(@endpoint_by_id, id, config)
  end

  @doc """
  Delete custom domain configuration.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Custom_Domains/delete_custom_domains_by_id

  """
  @spec delete(id, config) :: {:ok, String.t()} | error
  def delete(id, %Config{} = config) do
    Delete.execute(@endpoint_by_id, id, config)
  end

  @doc """
  Update custom domain configuration.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Custom_Domains/patch_custom_domains_by_id

  """
  @spec update(id, Patch.Params.t() | map, config) ::
          {:ok, list() | map()} | error
  def update(id, %{} = params, %Config{} = config) do
    Patch.execute(@endpoint_by_id, id, params, config)
  end

  @doc """
  Verify a custom domain.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Custom_Domains/post_verify

  """
  @spec verify(id, config) ::
          {:ok, list() | map()} | error
  def verify(id, %Config{} = config) do
    Verify.execute(@endpoint_verify, id, config)
  end
end
