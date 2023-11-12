defmodule Auth0.Management.Clients do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Entity
  alias Auth0.Management.Clients.List
  alias Auth0.Management.Clients.Create
  alias Auth0.Management.Clients.Get
  alias Auth0.Management.Clients.Delete
  alias Auth0.Management.Clients.Patch
  alias Auth0.Management.Clients.RotateSecret

  @type id :: String.t()
  @type config :: Config.t()
  @type response_body :: String.t()
  @type error :: {:error, integer, term} | {:error, term}

  @endpoint "/api/v2/clients"
  @endpoint_by_id "/api/v2/clients/{id}"
  @endpoint_rotate_secret "/api/v2/clients/{id}/rotate-secret"

  @doc """
  Get clients.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Clients/get_clients

  """
  @spec list(List.Params.t() | map, config) ::
          {:ok, Entity.Clients.t(), response_body} | error
  def list(%{} = params, %Config{} = config) do
    List.execute(@endpoint, params, config)
  end

  @doc """
  Create a client.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Clients/post_clients

  """
  @spec create(Create.Params.t() | map, config) ::
          {:ok, Entity.Client.t(), response_body} | error
  def create(%{} = params, %Config{} = config) do
    Create.execute(@endpoint, params, config)
  end

  @doc """
  Get a client.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Clients/get_clients_by_id

  """
  @spec get(id, Get.Params.t() | map, config) ::
          {:ok, Entity.Client.t(), response_body} | error
  def get(id, %{} = params, %Config{} = config) do
    Get.execute(@endpoint_by_id, id, params, config)
  end

  @doc """
  Delete a client.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Clients/delete_clients_by_id

  """
  @spec delete(id, config) :: {:ok, String.t(), response_body} | error
  def delete(id, %Config{} = config) do
    Delete.execute(@endpoint_by_id, id, config)
  end

  @doc """
  Update a client.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Clients/patch_clients_by_id

  """
  @spec update(id, Patch.Params.t() | map, config) ::
          {:ok, Entity.Client.t(), response_body} | error
  def update(id, %{} = params, %Config{} = config) do
    Patch.execute(@endpoint_by_id, id, params, config)
  end

  @doc """
  Rotate a client secret.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Clients/post_rotate_secret

  """
  @spec rotate_secret(id, config) :: {:ok, Entity.Client.t(), response_body} | error
  def rotate_secret(id, %Config{} = config) do
    RotateSecret.execute(@endpoint_rotate_secret, id, config)
  end
end
