defmodule Auth0.Management.SelfServiceProfiles do
  @moduledoc """
  Facade for the Auth0 Management API Self Service Profiles endpoints.

  Most applications should call `Auth0.Api.Management` instead of this module.
  """

  alias Auth0.Config
  alias Auth0.Management.SelfServiceProfiles.List
  alias Auth0.Management.SelfServiceProfiles.Create
  alias Auth0.Management.SelfServiceProfiles.Get
  alias Auth0.Management.SelfServiceProfiles.Delete
  alias Auth0.Management.SelfServiceProfiles.Patch
  alias Auth0.Management.SelfServiceProfiles.SsoTicket
  alias Auth0.Management.SelfServiceProfiles.CustomText.Get, as: SelfServiceProfilesCustomTextGet
  alias Auth0.Management.SelfServiceProfiles.CustomText.Put, as: SelfServiceProfilesCustomTextPut

  alias Auth0.Management.SelfServiceProfiles.SsoTicket.Revoke,
    as: SelfServiceProfilesSsoTicketRevoke

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
          {:ok, String.t()} | error
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
  @spec create_sso_ticket(id, map(), config, keyword()) ::
          {:ok, map()} | error
  def create_sso_ticket(id, %{} = params, %Config{} = config, opts \\ []) do
    SsoTicket.Create.execute(id, params, config, opts)
  end

  @doc """
  Get custom text for a self-service profile.

  Retrieves text customizations for a given self-service profile, language and Self-Service Enterprise Configuration flow page.

  ## see
  https://auth0.com/docs/api/management/v2/self-service-profiles/get-self-service-profile-custom-text

  """
  @spec get_custom_text(String.t(), String.t(), String.t(), config) :: {:ok, map()} | error
  def get_custom_text(id, language, page, %Config{} = config) do
    SelfServiceProfilesCustomTextGet.execute(id, language, page, config)
  end

  @doc """
  Set custom text for a self-service profile.

  Updates text customizations for a given self-service profile, language and Self-Service Enterprise Configuration flow page.

  ## see
  https://auth0.com/docs/api/management/v2/self-service-profiles/put-self-service-profile-custom-text

  """
  @spec set_custom_text(String.t(), String.t(), String.t(), map(), config) :: {:ok, map()} | error
  def set_custom_text(id, language, page, %{} = params, %Config{} = config) do
    SelfServiceProfilesCustomTextPut.execute(id, language, page, params, config)
  end

  @doc """
  Revoke a Self-Service Enterprise Configuration access ticket.

  Revokes a Self-Service Enterprise Configuration access ticket and invalidates associated sessions. The ticket will no longer be accepted to initiate a Self-Service Enterprise Configuration session. If any users have already started a session through this ticket, their session will be terminated. Clients should expect a `202 Accepted` response upon successful processing, indicating that the request has been acknowledged and that the revocation is underway but may not be fully completed at the ...

  ## see
  https://auth0.com/docs/api/management/v2/self-service-profiles/post-revoke

  """
  @spec revoke_sso_ticket(String.t(), String.t(), config) :: {:ok, String.t()} | error
  def revoke_sso_ticket(profile_id, id, %Config{} = config) do
    SelfServiceProfilesSsoTicketRevoke.execute(profile_id, id, config)
  end
end
