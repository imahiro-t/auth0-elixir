defmodule Auth0.Management.Connections do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Management.Connections.List
  alias Auth0.Management.Connections.Create
  alias Auth0.Management.Connections.Get
  alias Auth0.Management.Connections.Delete
  alias Auth0.Management.Connections.Patch
  alias Auth0.Management.Connections.ScimConfiguration
  alias Auth0.Management.Connections.Status
  alias Auth0.Management.Connections.Users

  @type id :: String.t()
  @type token_id :: String.t()
  @type config :: Config.t()
  @type error :: {:error, integer, term} | {:error, term}

  @doc """
  Retrieves detailed list of all connections that match the specified strategy. If no strategy is provided, all connections within your tenant are retrieved. This action can accept a list of fields to include or exclude from the resulting list of connections.

  ## see
  https://auth0.com/docs/api/management/v2/connections/get-connections

  """
  @spec list(map(), config) ::
          {:ok, list(map()) | map()} | error
  def list(%{} = params, %Config{} = config) do
    List.execute(params, config)
  end

  @doc """
  Creates a new connection according to the JSON object received in body.

  ## see
  https://auth0.com/docs/api/management/v2/connections/post-connections

  """
  @spec create(map(), config) ::
          {:ok, map()} | error
  def create(%{} = params, %Config{} = config) do
    Create.execute(params, config)
  end

  @doc """
  Retrieve details for a specified connection along with options that can be used for identity provider configuration.

  ## see
  https://auth0.com/docs/api/management/v2/connections/get-connections-by-id

  """
  @spec get(id, map(), config) ::
          {:ok, map()} | error
  def get(id, %{} = params, %Config{} = config) do
    Get.execute(id, params, config)
  end

  @doc """
  Removes a specific connection from your tenant. This action cannot be undone. Once removed, users can no longer use this connection to authenticate.

  ## see
  https://auth0.com/docs/api/management/v2/connections/delete-connections-by-id

  """
  @spec delete(id, config) :: {:ok, String.t()} | error
  def delete(id, %Config{} = config) do
    Delete.execute(id, config)
  end

  @doc """
  Update details for a specific connection, including option properties for identity provider configuration.

  ## see
  https://auth0.com/docs/api/management/v2/connections/patch-connections-by-id

  """
  @spec update(id, map(), config) ::
          {:ok, map()} | error
  def update(id, %{} = params, %Config{} = config) do
    Patch.execute(id, params, config)
  end

  @doc """
  Retrieves a scim configuration by its connectionId.

  ## see
  https://auth0.com/docs/api/management/v2/connections/get-scim-configuration

  """
  @spec get_scim_configuration(id, config) :: {:ok, map()} | error
  def get_scim_configuration(id, %Config{} = config) do
    ScimConfiguration.Get.execute(id, config)
  end

  @doc """
  Deletes a scim configuration by its connectionId.

  ## see
  https://auth0.com/docs/api/management/v2/connections/delete-scim-configuration

  """
  @spec delete_scim_configuration(id, config) :: {:ok, String.t()} | error
  def delete_scim_configuration(id, %Config{} = config) do
    ScimConfiguration.Delete.execute(id, config)
  end

  @doc """
  Update a scim configuration by its connectionId.

  ## see
  https://auth0.com/docs/api/management/v2/connections/patch-scim-configuration

  """
  @spec update_scim_configuration(id, map(), config) :: {:ok, map()} | error
  def update_scim_configuration(id, %{} = params, %Config{} = config) do
    ScimConfiguration.Patch.execute(id, params, config)
  end

  @doc """
  Create a scim configuration for a connection.

  ## see
  https://auth0.com/docs/api/management/v2/connections/post-scim-configuration

  """
  @spec create_scim_configuration(id, map(), config) :: {:ok, map()} | error
  def create_scim_configuration(id, %{} = params, %Config{} = config) do
    ScimConfiguration.Create.execute(id, params, config)
  end

  @doc """
  Retrieves a scim configuration's default mapping by its connectionId.

  ## see
  https://auth0.com/docs/api/management/v2/connections/get-default-mapping

  """
  @spec get_scim_configuration_default_mapping(id, config) :: {:ok, map()} | error
  def get_scim_configuration_default_mapping(id, %Config{} = config) do
    ScimConfiguration.DefaultMapping.Get.execute(id, config)
  end

  @doc """
  Retrieves all scim tokens by its connection id.

  ## see
  https://auth0.com/docs/api/management/v2/connections/get-scim-tokens

  """
  @spec get_scim_configuration_tokens(id, config) :: {:ok, list(map())} | error
  def get_scim_configuration_tokens(id, %Config{} = config) do
    ScimConfiguration.Tokens.Get.execute(id, config)
  end

  @doc """
  Create a scim token for a scim client.

  ## see
  https://auth0.com/docs/api/management/v2/connections/post-scim-token

  """
  @spec create_scim_configuration_tokens(id, map(), config) :: {:ok, map()} | error
  def create_scim_configuration_tokens(id, %{} = params, %Config{} = config) do
    ScimConfiguration.Tokens.Create.execute(id, params, config)
  end

  @doc """
  Deletes a scim token by its connection id and tokenId.

  ## see
  https://auth0.com/docs/api/management/v2/connections/delete-tokens-by-token-id

  """
  @spec delete_scim_configuration_tokens(id, token_id, config) :: {:ok, String.t()} | error
  def delete_scim_configuration_tokens(id, token_id, %Config{} = config) do
    ScimConfiguration.Tokens.Delete.execute(id, token_id, config)
  end

  @doc """
  Retrieves the status of an ad/ldap connection referenced by its ID. 200 OK http status code response is returned when the connection is online, otherwise a 404 status code is returned along with an error message

  ## see
  https://auth0.com/docs/api/management/v2/connections/get-status

  """
  @spec get_status(id, config) :: {:ok, boolean} | error
  def get_status(id, %Config{} = config) do
    Status.Check.execute(id, config)
  end

  @doc """
  Deletes a specified connection user by its email (you cannot delete all users from specific connection). Currently, only Database Connections are supported.

  ## see
  https://auth0.com/docs/api/management/v2/connections/delete-users-by-email

  """
  @spec delete_users(id, map(), config) ::
          {:ok, String.t()} | error
  def delete_users(id, %{} = params, %Config{} = config) do
    Users.Delete.execute(id, params, config)
  end
end
