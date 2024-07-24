defmodule Auth0.Management.Users do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Management.Users.List
  alias Auth0.Management.Users.Create
  alias Auth0.Management.Users.Get
  alias Auth0.Management.Users.Delete
  alias Auth0.Management.Users.Patch
  alias Auth0.Management.Users.Enrollments
  alias Auth0.Management.Users.AuthenticationMethods
  alias Auth0.Management.Users.Authenticators
  alias Auth0.Management.Users.Enrollments
  alias Auth0.Management.Users.Roles
  alias Auth0.Management.Users.Logs
  alias Auth0.Management.Users.Organizations
  alias Auth0.Management.Users.Permissions
  alias Auth0.Management.Users.Multifactor
  alias Auth0.Management.Users.Identities
  alias Auth0.Management.Users.RecoveryCodeRegeneration
  alias Auth0.Management.Users.RefreshTokens
  alias Auth0.Management.Users.Sessions

  @type id :: String.t()
  @type authentication_method_id :: String.t()
  @type provider :: String.t()
  @type user_id :: String.t()
  @type config :: Config.t()
  @type error :: {:error, integer, term} | {:error, term}

  @doc """
  Retrieve details of users.

  ## see
  https://auth0.com/docs/api/management/v2/users/get-users

  """
  @spec list(map(), config) :: {:ok, list(map()) | map()} | error
  def list(%{} = params, %Config{} = config) do
    List.execute(params, config)
  end

  @doc """
  Create a new user for a given database or passwordless connection.

  ## see
  https://auth0.com/docs/api/management/v2/users/post-users

  """
  @spec create(map(), config) ::
          {:ok, map()} | error
  def create(%{} = params, %Config{} = config) do
    Create.execute(params, config)
  end

  @doc """
  Retrieve user details. A list of fields to include or exclude may also be specified.

  ## see
  https://auth0.com/docs/api/management/v2/users/get-users-by-id

  """
  @spec get(id, map(), config) ::
          {:ok, map()} | error
  def get(id, %{} = params, %Config{} = config) do
    Get.execute(id, params, config)
  end

  @doc """
  Delete a user by user ID. This action cannot be undone.

  ## see
  https://auth0.com/docs/api/management/v2/users/delete-users-by-id

  """
  @spec delete(id, config) :: {:ok, String.t()} | error
  def delete(id, %Config{} = config) do
    Delete.execute(id, config)
  end

  @doc """
  Update a user.

  ## see
  https://auth0.com/docs/api/management/v2/users/patch-users-by-id

  """
  @spec update(id, map(), config) ::
          {:ok, map()} | error
  def update(id, %{} = params, %Config{} = config) do
    Patch.execute(id, params, config)
  end

  @doc """
  Retrieve detailed list of authentication methods associated with a specified user.

  ## see
  https://auth0.com/docs/api/management/v2/users/get-authentication-methods

  """
  @spec list_authentication_methods(id, map(), config) ::
          {:ok, list(map()) | map()} | error
  def list_authentication_methods(id, %{} = params, %Config{} = config) do
    AuthenticationMethods.List.execute(id, params, config)
  end

  @doc """
  Remove all authentication methods (i.e., enrolled MFA factors) from the specified user account. This action cannot be undone.

  ## see
  https://auth0.com/docs/api/management/v2/users/delete-authentication-methods

  """
  @spec delete_authentication_methods(id, config) ::
          {:ok, String.t()} | error
  def delete_authentication_methods(id, %Config{} = config) do
    AuthenticationMethods.DeleteAll.execute(id, config)
  end

  @doc """
  Create an authentication method. Authentication methods created via this endpoint will be auto confirmed and should already have verification completed.

  ## see
  https://auth0.com/docs/api/management/v2/users/post-authentication-methods

  """
  @spec create_authentication_methods(id, map(), config) ::
          {:ok, map()} | error
  def create_authentication_methods(id, %{} = params, %Config{} = config) do
    AuthenticationMethods.Create.execute(id, params, config)
  end

  @doc """
  Replace the specified user authentication methods with supplied values.

  ## see
  https://auth0.com/docs/api/management/v2/users/put-authentication-methods

  """
  @spec update_authentication_methods(id, map(), config) ::
          {:ok, list(map())} | error
  def update_authentication_methods(id, %{} = params, %Config{} = config) do
    AuthenticationMethods.PutAll.execute(id, params, config)
  end

  @doc """
  Get an authentication method by ID

  ## see
  https://auth0.com/docs/api/management/v2/users/get-authentication-methods-by-authentication-method-id

  """
  @spec get_authentication_method(id, authentication_method_id, config) ::
          {:ok, map()} | error
  def get_authentication_method(id, authentication_method_id, %Config{} = config) do
    AuthenticationMethods.Get.execute(id, authentication_method_id, config)
  end

  @doc """
  Remove the authentication method with the given ID from the specified user.

  ## see
  https://auth0.com/docs/api/management/v2/users/delete-authentication-methods-by-authentication-method-id

  """
  @spec delete_authentication_method(id, authentication_method_id, config) ::
          {:ok, String.t()} | error
  def delete_authentication_method(id, authentication_method_id, %Config{} = config) do
    AuthenticationMethods.Delete.execute(id, authentication_method_id, config)
  end

  @doc """
  Modify the authentication method with the given ID from the specified user.

  ## see
  https://auth0.com/docs/api/management/v2/users/patch-authentication-methods-by-authentication-method-id

  """
  @spec update_authentication_method(id, authentication_method_id, map(), config) ::
          {:ok, map()} | error
  def update_authentication_method(id, authentication_method_id, %{} = params, %Config{} = config) do
    AuthenticationMethods.Patch.execute(id, authentication_method_id, params, config)
  end

  @doc """
  Remove all authenticators registered to a given user ID, such as OTP, email, phone, and push-notification. This action cannot be undone.

  ## see
  https://auth0.com/docs/api/management/v2/users/delete-authenticators

  """
  @spec delete_authenticators(id, config) ::
          {:ok, String.t()} | error
  def delete_authenticators(id, %Config{} = config) do
    Authenticators.Delete.execute(id, config)
  end

  @doc """
  Retrieve the first multi-factor authentication enrollment that a specific user has confirmed.

  ## see
  https://auth0.com/docs/api/management/v2/users/get-enrollments

  """
  @spec get_enrollments(id, config) ::
          {:ok, list(map())} | error
  def get_enrollments(id, %Config{} = config) do
    Enrollments.List.execute(id, config)
  end

  @doc """
  Link two user accounts together forming a primary and secondary relationship. On successful linking, the endpoint returns the new array of the primary account identities.

  ## see
  https://auth0.com/docs/api/management/v2/users/post-identities

  """
  @spec link_identities(id, map(), config) ::
          {:ok, list(map())} | error
  def link_identities(
        id,
        %{} = params,
        %Config{} = config
      ) do
    Identities.Link.execute(id, params, config)
  end

  @doc """
  Unlink a specific secondary account from a target user. This action requires the ID of both the target user and the secondary account.

  ## see
  https://auth0.com/docs/api/management/v2/users/delete-user-identity-by-user-id

  """
  @spec unlink_identities(id, provider, user_id, config) ::
          {:ok, list(map())} | error
  def unlink_identities(
        id,
        provider,
        user_id,
        %Config{} = config
      ) do
    Identities.Unlink.execute(id, provider, user_id, config)
  end

  @doc """
  Retrieve log events for a specific user.

  ## see
  https://auth0.com/docs/api/management/v2/users/get-logs-by-user

  """
  @spec get_logs(id, map(), config) ::
          {:ok, list(map()) | map()} | error
  def get_logs(id, %{} = params, %Config{} = config) do
    Logs.List.execute(id, params, config)
  end

  @doc """
  Invalidate all remembered browsers across all authentication factors for a user.

  ## see
  https://auth0.com/docs/api/management/v2/users/post-invalidate-remember-browser

  """
  @spec invalidate_remembered_browser_for_multifactor(id, config) ::
          {:ok, String.t()} | error
  def invalidate_remembered_browser_for_multifactor(
        id,
        %Config{} = config
      ) do
    Multifactor.InvalidateRememberedBrowser.execute(
      id,
      config
    )
  end

  @doc """
  Remove a multifactor authentication configuration from a user's account. This forces the user to manually reconfigure the multi-factor provider.

  ## see
  https://auth0.com/docs/api/management/v2/users/delete-multifactor-by-provider

  """
  @spec delete_multifactor(id, map(), config) ::
          {:ok, String.t()} | error
  def delete_multifactor(
        id,
        %{} = params,
        %Config{} = config
      ) do
    Multifactor.Delete.execute(id, params, config)
  end

  @doc """
  Retrieve list of the specified user's current Organization memberships. User must be specified by user ID.

  ## see
  https://auth0.com/docs/api/management/v2/users/get-user-organizations

  """
  @spec get_organizations(id, map(), config) ::
          {:ok, list(map()) | map()} | error
  def get_organizations(id, %{} = params, %Config{} = config) do
    Organizations.List.execute(id, params, config)
  end

  @doc """
  Retrieve all permissions associated with the user.

  ## see
  https://auth0.com/docs/api/management/v2/users/get-permissions

  """
  @spec get_permissions(id, map(), config) ::
          {:ok, list(map()) | map()} | error
  def get_permissions(id, %{} = params, %Config{} = config) do
    Permissions.List.execute(id, params, config)
  end

  @doc """
  Remove permissions from a user.

  ## see
  https://auth0.com/docs/api/management/v2/users/delete-permissions

  """
  @spec remove_permissions(id, map(), config) ::
          {:ok, String.t()} | error
  def remove_permissions(id, %{} = params, %Config{} = config) do
    Permissions.Remove.execute(id, params, config)
  end

  @doc """
  Assign permissions to a user.

  ## see
  https://auth0.com/docs/api/management/v2/users/post-permissions

  """
  @spec assign_permissions(id, map(), config) ::
          {:ok, String.t()} | error
  def assign_permissions(id, %{} = params, %Config{} = config) do
    Permissions.Assign.execute(id, params, config)
  end

  @doc """
  Remove an existing multi-factor authentication (MFA) recovery code and generate a new one. If a user cannot access the original device or account used for MFA enrollment, they can use a recovery code to authenticate.

  ## see
  https://auth0.com/docs/api/management/v2/users/post-recovery-code-regeneration

  """
  @spec regenerate_recovery_code(id, config) ::
          {:ok, map()} | error
  def regenerate_recovery_code(
        id,
        %Config{} = config
      ) do
    RecoveryCodeRegeneration.Regenerate.execute(
      id,
      config
    )
  end

  @doc """
  Retrieve detailed list of all user roles currently assigned to a user.

  ## see
  https://auth0.com/docs/api/management/v2/users/get-user-roles

  """
  @spec get_roles(id, map(), config) ::
          {:ok, list(map()) | map()} | error
  def get_roles(id, %{} = params, %Config{} = config) do
    Roles.List.execute(id, params, config)
  end

  @doc """
  Remove one or more specified user roles assigned to a user.

  ## see
  https://auth0.com/docs/api/management/v2/users/delete-user-roles

  """
  @spec remove_roles(id, map(), config) ::
          {:ok, String.t()} | error
  def remove_roles(id, %{} = params, %Config{} = config) do
    Roles.Remove.execute(id, params, config)
  end

  @doc """
  Assign one or more existing user roles to a user.

  ## see
  https://auth0.com/docs/api/management/v2/users/post-user-roles

  """
  @spec assign_roles(id, map(), config) ::
          {:ok, String.t()} | error
  def assign_roles(id, %{} = params, %Config{} = config) do
    Roles.Assign.execute(id, params, config)
  end

  @doc """
  Retrieve details for a user's refresh tokens.

  ## see
  https://auth0.com/docs/api/management/v2/users/get-refresh-tokens-for-user

  """
  @spec get_refresh_tokens(id, map(), config) ::
          {:ok, map()} | error
  def get_refresh_tokens(id, %{} = params, %Config{} = config) do
    RefreshTokens.List.execute(id, params, config)
  end

  @doc """
  Delete all refresh tokens for a user.

  ## see
  https://auth0.com/docs/api/management/v2/users/delete-refresh-tokens-for-user

  """
  @spec delete_refresh_tokens(id, config) ::
          {:ok, String.t()} | error
  def delete_refresh_tokens(id, %Config{} = config) do
    RefreshTokens.Delete.execute(id, config)
  end

  @doc """
  Retrieve details for a user's sessions.

  ## see
  https://auth0.com/docs/api/management/v2/users/get-sessions-for-user

  """
  @spec get_sessions(id, map(), config) ::
          {:ok, map()} | error
  def get_sessions(id, %{} = params, %Config{} = config) do
    Sessions.List.execute(id, params, config)
  end

  @doc """
  Retrieve details for a user's sessions.

  ## see
  https://auth0.com/docs/api/management/v2/users/get-sessions-for-user

  """
  @spec delete_sessions(id, config) ::
          {:ok, String.t()} | error
  def delete_sessions(id, %Config{} = config) do
    Sessions.Delete.execute(id, config)
  end
end
