defmodule Auth0.Management.Users do
  @moduledoc """
  Documentation for Auth0 Management API of Users.

  ## endpoint
  - /api/v2/users
  - /api/v2/users/{id}
  - /api/v2/users/{id}/enrollments
  - /api/v2/users/{id}/roles
  - /api/v2/users/{id}/logs
  - /api/v2/users/{id}/organizations
  - /api/v2/users/{id}/permissions
  - /api/v2/users/{id}/multifactor/{provider}
  - /api/v2/users/{id}/multifactor/actions/invalidate-remember-browser
  - /api/v2/users/{id}/identities
  - /api/v2/users/{id}/identities/{provider}/{user_id}
  - /api/v2/users/{id}/recovery-code-regeneration
  """

  alias Auth0.Config
  alias Auth0.Entity
  alias Auth0.Management.Users.List
  alias Auth0.Management.Users.Create
  alias Auth0.Management.Users.Get
  alias Auth0.Management.Users.Delete
  alias Auth0.Management.Users.Patch
  alias Auth0.Management.Users.Enrollments
  alias Auth0.Management.Users.Roles
  alias Auth0.Management.Users.Logs
  alias Auth0.Management.Users.Organizations
  alias Auth0.Management.Users.Permissions
  alias Auth0.Management.Users.Multifactor
  alias Auth0.Management.Users.Identities
  alias Auth0.Management.Users.RecoveryCodeRegeneration

  @type id :: String.t()
  @type provider :: String.t()
  @type user_id :: String.t()
  @type config :: Config.t()
  @type response_body :: String.t()
  @type error :: {:error, integer, term} | {:error, term}

  @endpoint "/api/v2/users"
  @endpoint_by_id "/api/v2/users/{id}"
  @endpoint_of_enrollments "/api/v2/users/{id}/enrollments"
  @endpoint_of_roles "/api/v2/users/{id}/roles"
  @endpoint_of_logs "/api/v2/users/{id}/logs"
  @endpoint_of_organizations "/api/v2/users/{id}/organizations"
  @endpoint_of_permissions "/api/v2/users/{id}/permissions"
  @endpoint_of_multifactor "/api/v2/users/{id}/multifactor/{provider}"
  @endpoint_of_multifactor_invalidate_remember_browser "/api/v2/users/{id}/multifactor/actions/invalidate-remember-browser"
  @endpoint_of_identities "/api/v2/users/{id}/identities"
  @endpoint_of_identities_by_provider "/api/v2/users/{id}/identities/{provider}/{user_id}"
  @endpoint_of_recovery_code_regeneration "/api/v2/users/{id}/recovery-code-regeneration"

  @doc """
  List or Search Users.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Users/get_users

  """
  @spec list(List.Params.t() | map, config) :: {:ok, Entity.Users.t(), response_body} | error
  def list(%{} = params, %Config{} = config) do
    List.execute(@endpoint, params, config)
  end

  @doc """
  Create a User.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Users/post_users

  """
  @spec create(Create.Params.t() | map, config) ::
          {:ok, Entity.User.t(), response_body} | error
  def create(%{} = params, %Config{} = config) do
    Create.execute(@endpoint, params, config)
  end

  @doc """
  Get a User.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Users/get_users_by_id

  """
  @spec get(id, Get.Params.t() | map, config) ::
          {:ok, Entity.User.t(), response_body} | error
  def get(id, %{} = params, %Config{} = config) do
    Get.execute(@endpoint_by_id, id, params, config)
  end

  @doc """
  Delete a User.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Users/delete_users_by_id

  """
  @spec delete(id, config) :: {:ok, String.t(), response_body} | error
  def delete(id, %Config{} = config) do
    Delete.execute(@endpoint_by_id, id, config)
  end

  @doc """
  Update a User.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Users/patch_users_by_id

  """
  @spec update(id, Patch.Params.t() | map, config) ::
          {:ok, Entity.User.t(), response_body} | error
  def update(id, %{} = params, %Config{} = config) do
    Patch.execute(@endpoint_by_id, id, params, config)
  end

  @doc """
  Get the First Confirmed Multi-factor Authentication Enrollment.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Users/get_enrollments

  """
  @spec get_enrollments(id, config) ::
          {:ok, Entity.Enrollments.t(), response_body} | error
  def get_enrollments(id, %Config{} = config) do
    Enrollments.List.execute(@endpoint_of_enrollments, id, config)
  end

  @doc """
  Get a user's roles.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Users/get_user_roles

  """
  @spec get_roles(id, Roles.List.Params.t() | map, config) ::
          {:ok, Entity.Roles.t(), response_body} | error
  def get_roles(id, %{} = params, %Config{} = config) do
    Roles.List.execute(@endpoint_of_roles, id, params, config)
  end

  @doc """
  Removes roles from a user.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Users/delete_user_roles

  """
  @spec remove_roles(id, Roles.Remove.Params.t() | map, config) ::
          {:ok, String.t(), response_body} | error
  def remove_roles(id, %{} = params, %Config{} = config) do
    Roles.Remove.execute(@endpoint_of_roles, id, params, config)
  end

  @doc """
  Assign roles to a user.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Users/post_user_roles

  """
  @spec assign_roles(id, Roles.Assign.Params.t() | map, config) ::
          {:ok, String.t(), response_body} | error
  def assign_roles(id, %{} = params, %Config{} = config) do
    Roles.Assign.execute(@endpoint_of_roles, id, params, config)
  end

  @doc """
  Get user's log events.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Users/get_logs_by_user

  """
  @spec get_logs(id, Logs.List.Params.t() | map, config) ::
          {:ok, Entity.Logs.t(), response_body} | error
  def get_logs(id, %{} = params, %Config{} = config) do
    Logs.List.execute(@endpoint_of_logs, id, params, config)
  end

  @doc """
  List user's organizations.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Users/get_user_organizations

  """
  @spec get_organizations(id, Organizations.List.Params.t() | map, config) ::
          {:ok, Entity.Organizations.t(), response_body} | error
  def get_organizations(id, %{} = params, %Config{} = config) do
    Organizations.List.execute(@endpoint_of_organizations, id, params, config)
  end

  @doc """
  Get a User's Permissions.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Users/get_permissions

  """
  @spec get_permissions(id, Permissions.List.Params.t() | map, config) ::
          {:ok, Entity.Permissions.t(), response_body} | error
  def get_permissions(id, %{} = params, %Config{} = config) do
    Permissions.List.execute(@endpoint_of_permissions, id, params, config)
  end

  @doc """
  Remove Permissions from a User.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Users/delete_permissions

  """
  @spec remove_permissions(id, Permissions.Remove.Params.t() | map, config) ::
          {:ok, String.t(), response_body} | error
  def remove_permissions(id, %{} = params, %Config{} = config) do
    Permissions.Remove.execute(@endpoint_of_permissions, id, params, config)
  end

  @doc """
  Assign Permissions to a User.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Users/post_permissions

  """
  @spec assign_permissions(id, Permissions.Assign.Params.t() | map, config) ::
          {:ok, String.t(), response_body} | error
  def assign_permissions(id, %{} = params, %Config{} = config) do
    Permissions.Assign.execute(@endpoint_of_permissions, id, params, config)
  end

  @doc """
  Delete a User's Multi-factor Provider.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Users/delete_multifactor_by_provider

  """
  @spec delete_multifactor(id, Multifactor.Delete.Params.t() | map, config) ::
          {:ok, String.t(), response_body} | error
  def delete_multifactor(
        id,
        %{} = params,
        %Config{} = config
      ) do
    Multifactor.Delete.execute(@endpoint_of_multifactor, id, params, config)
  end

  @doc """
  Invalidate All Remembered Browsers for Multi-factor Authentication.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Users/post_invalidate_remember_browser

  """
  @spec invalidate_remembered_browser_for_multifactor(id, config) ::
          {:ok, String.t(), response_body} | error
  def invalidate_remembered_browser_for_multifactor(
        id,
        %Config{} = config
      ) do
    Multifactor.InvalidateRememberedBrowser.execute(
      @endpoint_of_multifactor_invalidate_remember_browser,
      id,
      config
    )
  end

  @doc """
  Link a User Account.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Users/post_identities

  """
  @spec link_identities(id, Identities.Link.Params.t() | map, config) ::
          {:ok, Entity.Identities.t(), response_body} | error
  def link_identities(
        id,
        %{} = params,
        %Config{} = config
      ) do
    Identities.Link.execute(@endpoint_of_identities, id, params, config)
  end

  @doc """
  Unlink a User Identity.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Users/delete_user_identity_by_user_id

  """
  @spec unlink_identities(id, provider, user_id, config) ::
          {:ok, Entity.Identities.t(), response_body} | error
  def unlink_identities(
        id,
        provider,
        user_id,
        %Config{} = config
      ) do
    Identities.Unlink.execute(@endpoint_of_identities_by_provider, id, provider, user_id, config)
  end

  @doc """
  Generate New Multi-factor Authentication Recovery Code.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Users/post_recovery_code_regeneration

  """
  @spec regenerate_recovery_code(id, config) ::
          {:ok, Entity.RecoveryCodeRegeneration.t(), response_body} | error
  def regenerate_recovery_code(
        id,
        %Config{} = config
      ) do
    RecoveryCodeRegeneration.Regenerate.execute(
      @endpoint_of_recovery_code_regeneration,
      id,
      config
    )
  end
end
