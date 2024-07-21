defmodule Auth0.Management.Connections do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Management.Connections.List
  alias Auth0.Management.Connections.Create
  alias Auth0.Management.Connections.Get
  alias Auth0.Management.Connections.Delete
  alias Auth0.Management.Connections.Patch
  alias Auth0.Management.Connections.Status
  alias Auth0.Management.Connections.Users

  @type id :: String.t()
  @type config :: Config.t()
  @type error :: {:error, integer, term} | {:error, term}

  @doc """
  Retrieves detailed list of all connections that match the specified strategy. If no strategy is provided, all connections within your tenant are retrieved. This action can accept a list of fields to include or exclude from the resulting list of connections.

  ## see
  https://auth0.com/docs/api/management/v2/connections/get-connections

  """
  @spec list(map(), config) ::
          {:ok, list() | map()} | error
  def list(%{} = params, %Config{} = config) do
    List.execute(params, config)
  end

  @doc """
  Creates a new connection according to the JSON object received in body.

  ## see
  https://auth0.com/docs/api/management/v2/connections/post-connections

  """
  @spec create(map(), config) ::
          {:ok, list() | map()} | error
  def create(%{} = params, %Config{} = config) do
    Create.execute(params, config)
  end

  @doc """
  Retrieve details for a specified connection along with options that can be used for identity provider configuration.

  ## see
  https://auth0.com/docs/api/management/v2/connections/get-connections-by-id

  """
  @spec get(id, map(), config) ::
          {:ok, list() | map()} | error
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
          {:ok, list() | map()} | error
  def update(id, %{} = params, %Config{} = config) do
    Patch.execute(id, params, config)
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
