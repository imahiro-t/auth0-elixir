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
  alias Auth0.Management.Clients.Credential

  @type id :: String.t()
  @type client_id :: String.t()
  @type credential_id :: String.t()
  @type config :: Config.t()
  @type response_body :: String.t()
  @type error :: {:error, integer, term} | {:error, term}

  @endpoint "/api/v2/clients"
  @endpoint_by_id "/api/v2/clients/{id}"
  @endpoint_rotate_secret "/api/v2/clients/{id}/rotate-secret"
  @endpoint_credential "/api/v2/clients/{client_id}/credentials"
  @endpoint_credential_by_id "/api/v2/clients/{client_id}/credentials/{credential_id}"

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

  @doc """
  Get client credentials.

  ## see
  https://auth0.com/docs/api/management/v2/clients/get-credentials

  """
  @spec list_credentials(client_id, config) ::
          {:ok, list(map()), response_body} | error
  def list_credentials(client_id, %Config{} = config) do
    Credential.List.execute(@endpoint_credential, client_id, config)
  end

  @doc """
  Create a client credential.

  ## see
  https://auth0.com/docs/api/management/v2/clients/post-credentials

  """
  @spec create_credential(client_id, map, config) ::
          {:ok, map, response_body} | error
  def create_credential(client_id, %{} = params, %Config{} = config) do
    Credential.Create.execute(@endpoint_credential, client_id, params, config)
  end

  @doc """
  Get client credential.

  ## see
  https://auth0.com/docs/api/management/v2/clients/get-credentials-by-credential-id

  """
  @spec get_credential(client_id, credential_id, config) ::
          {:ok, map, response_body} | error
  def get_credential(client_id, credential_id, %Config{} = config) do
    Credential.Get.execute(@endpoint_credential_by_id, client_id, credential_id, config)
  end

  @doc """
  Delete a client credential.

  ## see
  https://auth0.com/docs/api/management/v2/clients/delete-credentials-by-credential-id

  """
  @spec delete_credential(client_id, credential_id, config) ::
          {:ok, String.t(), response_body} | error
  def delete_credential(client_id, credential_id, %Config{} = config) do
    Credential.Delete.execute(@endpoint_credential_by_id, client_id, credential_id, config)
  end

  @doc """
  Update a client credential.

  ## see
  https://auth0.com/docs/api/management/v2/clients/patch-credentials-by-credential-id

  """
  @spec update_credential(client_id, credential_id, map, config) ::
          {:ok, map, response_body} | error
  def update_credential(client_id, credential_id, %{} = params, %Config{} = config) do
    Credential.Patch.execute(@endpoint_credential_by_id, client_id, credential_id, params, config)
  end
end
