defmodule Auth0.Management.Clients do
  @moduledoc false

  alias Auth0.Config
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
  @type error :: {:error, integer, term} | {:error, term}

  @doc """
  Retrieve clients (applications and SSO integrations) matching provided filters. A list of fields to include or exclude may also be specified.

  ## see
  https://auth0.com/docs/api/management/v2/clients/get-clients

  """
  @spec list(map(), config) ::
          {:ok, list() | map()} | error
  def list(%{} = params, %Config{} = config) do
    List.execute(params, config)
  end

  @doc """
  Create a new client (application or SSO integration).

  ## see
  https://auth0.com/docs/api/management/v2/clients/post-clients

  """
  @spec create(map(), config) ::
          {:ok, list() | map()} | error
  def create(%{} = params, %Config{} = config) do
    Create.execute(params, config)
  end

  @doc """
  Retrieve client details by ID. Clients are SSO connections or Applications linked with your Auth0 tenant. A list of fields to include or exclude may also be specified.

  ## see
  https://auth0.com/docs/api/management/v2/clients/get-clients-by-id

  """
  @spec get(id, map(), config) ::
          {:ok, list() | map()} | error
  def get(id, %{} = params, %Config{} = config) do
    Get.execute(id, params, config)
  end

  @doc """
  Delete a client and related configuration (rules, connections, etc).

  ## see
  https://auth0.com/docs/api/management/v2/clients/delete-clients-by-id

  """
  @spec delete(id, config) :: {:ok, String.t()} | error
  def delete(id, %Config{} = config) do
    Delete.execute(id, config)
  end

  @doc """
  Updates a client's settings

  ## see
  https://auth0.com/docs/api/management/v2/clients/patch-clients-by-id

  """
  @spec update(id, map(), config) ::
          {:ok, list() | map()} | error
  def update(id, %{} = params, %Config{} = config) do
    Patch.execute(id, params, config)
  end

  @doc """
  Rotate a client secret.

  ## see
  https://auth0.com/docs/api/management/v2/clients/post-rotate-secret

  """
  @spec rotate_secret(id, config) ::
          {:ok, list() | map()} | error
  def rotate_secret(id, %Config{} = config) do
    RotateSecret.execute(id, config)
  end

  @doc """
  Get the details of a client credential.

  ## see
  https://auth0.com/docs/api/management/v2/clients/get-credentials

  """
  @spec list_credentials(client_id, config) ::
          {:ok, list(map())} | error
  def list_credentials(client_id, %Config{} = config) do
    Credential.List.execute(client_id, config)
  end

  @doc """
  Create a client credential associated to your application. The credential will be created but not yet enabled for use with Private Key JWT authentication method. To enable the credential, set the client_authentication_methods property on the client.

  ## see
  https://auth0.com/docs/api/management/v2/clients/post-credentials

  """
  @spec create_credential(client_id, map, config) ::
          {:ok, map} | error
  def create_credential(client_id, %{} = params, %Config{} = config) do
    Credential.Create.execute(client_id, params, config)
  end

  @doc """
  Get the details of a client credential.

  ## see
  https://auth0.com/docs/api/management/v2/clients/get-credentials-by-credential-id

  """
  @spec get_credential(client_id, credential_id, config) ::
          {:ok, map} | error
  def get_credential(client_id, credential_id, %Config{} = config) do
    Credential.Get.execute(client_id, credential_id, config)
  end

  @doc """
  Delete a client credential you previously created. May be enabled or disabled.

  ## see
  https://auth0.com/docs/api/management/v2/clients/delete-credentials-by-credential-id

  """
  @spec delete_credential(client_id, credential_id, config) ::
          {:ok, String.t()} | error
  def delete_credential(client_id, credential_id, %Config{} = config) do
    Credential.Delete.execute(client_id, credential_id, config)
  end

  @doc """
  Change a client credential you previously created. May be enabled or disabled.

  ## see
  https://auth0.com/docs/api/management/v2/clients/patch-credentials-by-credential-id

  """
  @spec update_credential(client_id, credential_id, map, config) ::
          {:ok, map} | error
  def update_credential(client_id, credential_id, %{} = params, %Config{} = config) do
    Credential.Patch.execute(client_id, credential_id, params, config)
  end
end
