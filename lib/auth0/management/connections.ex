defmodule Auth0.Management.Connections do
  @moduledoc """
  Documentation for Auth0 Management API of Connections.

  ## endpoint
  - /api/v2/connections
  - /api/v2/connections/{id}
  - /api/v2/connections/{id}/status
  - /api/v2/connections/{id}/users
  """

  alias Auth0.Config
  alias Auth0.Entity
  alias Auth0.Management.Connections.List
  alias Auth0.Management.Connections.Create
  alias Auth0.Management.Connections.Get
  alias Auth0.Management.Connections.Delete
  alias Auth0.Management.Connections.Patch
  alias Auth0.Management.Connections.Status
  alias Auth0.Management.Connections.Users

  @type id :: String.t()
  @type config :: Config.t()
  @type response_body :: String.t()
  @type error :: {:error, integer, term} | {:error, term}

  @endpoint "/api/v2/connections"
  @endpoint_by_id "/api/v2/connections/{id}"
  @endpoint_status "/api/v2/connections/{id}/status"
  @endpoint_users "/api/v2/connections/{id}/users"

  @doc """
  Get all connections.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Connections/get_connections

  """
  @spec list(List.Params.t() | map, config) ::
          {:ok, Entity.Connections.t(), response_body} | error
  def list(%{} = params, %Config{} = config) do
    List.execute(@endpoint, params, config)
  end

  @doc """
  Create a connection.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Connections/post_connections

  """
  @spec create(Create.Params.t() | map, config) ::
          {:ok, Entity.Connection.t(), response_body} | error
  def create(%{} = params, %Config{} = config) do
    Create.execute(@endpoint, params, config)
  end

  @doc """
  Get a connection.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Connections/get_connections_by_id

  """
  @spec get(id, Get.Params.t() | map, config) ::
          {:ok, Entity.Connection.t(), response_body} | error
  def get(id, %{} = params, %Config{} = config) do
    Get.execute(@endpoint_by_id, id, params, config)
  end

  @doc """
  Delete a connection.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Connections/delete_connections_by_id

  """
  @spec delete(id, config) :: {:ok, String.t(), response_body} | error
  def delete(id, %Config{} = config) do
    Delete.execute(@endpoint_by_id, id, config)
  end

  @doc """
  Update a connection.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Connections/patch_connections_by_id

  """
  @spec update(id, Patch.Params.t() | map, config) ::
          {:ok, Entity.Connection.t(), response_body} | error
  def update(id, %{} = params, %Config{} = config) do
    Patch.execute(@endpoint_by_id, id, params, config)
  end

  @doc """
  Check connection status.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Connections/get_status

  """
  @spec get_status(id, config) :: {:ok, boolean, response_body} | error
  def get_status(id, %Config{} = config) do
    Status.Check.execute(@endpoint_status, id, config)
  end

  @doc """
  Delete a connection user.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Connections/delete_users_by_email

  """
  @spec delete_users(id, Users.Delete.Params.t() | map, config) ::
          {:ok, String.t(), response_body} | error
  def delete_users(id, %{} = params, %Config{} = config) do
    Users.Delete.execute(@endpoint_users, id, params, config)
  end
end
