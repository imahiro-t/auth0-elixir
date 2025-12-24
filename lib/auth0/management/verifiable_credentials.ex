defmodule Auth0.Management.VerifiableCredentials do
  alias Auth0.Config
  alias Auth0.Management.VerifiableCredentials.List
  alias Auth0.Management.VerifiableCredentials.Create
  alias Auth0.Management.VerifiableCredentials.Get
  alias Auth0.Management.VerifiableCredentials.Delete
  alias Auth0.Management.VerifiableCredentials.Patch

  @type id :: String.t()
  @type config :: Config.t()
  @type error :: {:error, integer, term} | {:error, term}

  @doc """
  Retrieve a list of verifiable credentials.

  ## see
  https://auth0.com/docs/api/management/v2/verifiable-credentials/get-verifiable-credentials
  """
  @spec list(map(), config) :: {:ok, list(map())} | error
  def list(%{} = params, %Config{} = config) do
    List.execute(params, config)
  end

  @doc """
  Create a verifiable credential.

  ## see
  https://auth0.com/docs/api/management/v2/verifiable-credentials/post-verifiable-credentials
  """
  @spec create(map(), config) :: {:ok, map()} | error
  def create(%{} = params, %Config{} = config) do
    Create.execute(params, config)
  end

  @doc """
  Retrieve a verifiable credential by its ID.

  ## see
  https://auth0.com/docs/api/management/v2/verifiable-credentials/get-verifiable-credentials-by-id
  """
  @spec get(id, config) :: {:ok, map()} | error
  def get(id, %Config{} = config) do
    Get.execute(id, config)
  end

  @doc """
  Delete a verifiable credential.

  ## see
  https://auth0.com/docs/api/management/v2/verifiable-credentials/delete-verifiable-credentials-by-id
  """
  @spec delete(id, config) :: {:ok, String.t()} | error
  def delete(id, %Config{} = config) do
    Delete.execute(id, config)
  end

  @doc """
  Update a verifiable credential.

  ## see
  https://auth0.com/docs/api/management/v2/verifiable-credentials/patch-verifiable-credentials-by-id
  """
  @spec update(id, map(), config) :: {:ok, map()} | error
  def update(id, %{} = params, %Config{} = config) do
    Patch.execute(id, params, config)
  end
end
