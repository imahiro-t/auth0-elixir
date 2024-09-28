defmodule Auth0.Management.SelfServiceProfiles do
  alias Auth0.Config
  alias Auth0.Management.SelfServiceProfiles.List
  alias Auth0.Management.SelfServiceProfiles.Create
  alias Auth0.Management.SelfServiceProfiles.Get
  alias Auth0.Management.SelfServiceProfiles.Delete
  alias Auth0.Management.SelfServiceProfiles.Patch
  alias Auth0.Management.SelfServiceProfiles.SsoTicket

  @type id :: String.t()
  @type config :: Config.t()
  @type error :: {:error, integer, term} | {:error, term}

  @doc """
  Retrieves self-service profiles. Currently only one profile can be created per tenant.

  ## see
  https://auth0.com/docs/api/management/v2/self-service-profiles/get-self-service-profiles

  """
  @spec list(map(), config) ::
          {:ok, map()} | error
  def list(%{} = params, %Config{} = config) do
    List.execute(params, config)
  end

  @doc """
  Creates a self-service profile. Currently only one profile can be created per tenant.

  ## see
  https://auth0.com/docs/api/management/v2/self-service-profiles/post-self-service-profiles

  """
  @spec create(map(), config) ::
          {:ok, map()} | error
  def create(%{} = params, %Config{} = config) do
    Create.execute(params, config)
  end

  @doc """
  Retrieves a self-service profile by Id.

  ## see
  https://auth0.com/docs/api/management/v2/self-service-profiles/get-self-service-profiles-by-id

  """
  @spec get(id, config) ::
          {:ok, map()} | error
  def get(id, %Config{} = config) do
    Get.execute(id, config)
  end

  @doc """
  Deletes a self-service profile by Id.

  ## see
  https://auth0.com/docs/api/management/v2/self-service-profiles/delete-self-service-profiles-by-id

  """
  @spec delete(id, config) ::
          {:ok, map()} | error
  def delete(id, %Config{} = config) do
    Delete.execute(id, config)
  end

  @doc """
  Updates a self-service profile.

  ## see
  https://auth0.com/docs/api/management/v2/self-service-profiles/patch-self-service-profiles-by-id

  """
  @spec update(id, map(), config) ::
          {:ok, map()} | error
  def update(id, %{} = params, %Config{} = config) do
    Patch.execute(id, params, config)
  end

  @doc """
  Creates an sso-access ticket to initiate the Self Service SSO Flow using a self-service profile.

  ## see
  https://auth0.com/docs/api/management/v2/self-service-profiles/post-sso-ticket

  """
  @spec create_sso_ticket(id, map(), config) ::
          {:ok, map()} | error
  def create_sso_ticket(id, %{} = params, %Config{} = config) do
    SsoTicket.Create.execute(id, params, config)
  end
end
