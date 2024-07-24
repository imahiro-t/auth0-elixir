defmodule Auth0.Management.ClientGrants do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Management.ClientGrants.List
  alias Auth0.Management.ClientGrants.Create
  alias Auth0.Management.ClientGrants.Delete
  alias Auth0.Management.ClientGrants.Patch

  @type id :: String.t()
  @type config :: Config.t()
  @type error :: {:error, integer, term} | {:error, term}

  @doc """
  Retrieve a list of client grants, including the scopes associated with the application/API pair.

  ## see
  https://auth0.com/docs/api/management/v2/client-grants/get-client-grants

  """
  @spec list(map(), config) ::
          {:ok, list(map()) | map()} | error
  def list(%{} = params, %Config{} = config) do
    List.execute(params, config)
  end

  @doc """
  Create a client grant for a machine-to-machine login flow.

  ## see
  https://auth0.com/docs/api/management/v2/client-grants/post-client-grants

  """
  @spec create(map(), config) ::
          {:ok, map()} | error
  def create(%{} = params, %Config{} = config) do
    Create.execute(params, config)
  end

  @doc """
  Delete the Client Credential Flow from your machine-to-machine application.

  ## see
  https://auth0.com/docs/api/management/v2/client-grants/delete-client-grants-by-id

  """
  @spec delete(id, config) :: {:ok, String.t()} | error
  def delete(id, %Config{} = config) do
    Delete.execute(id, config)
  end

  @doc """
  Update a client grant.

  ## see
  https://auth0.com/docs/api/management/v2/client-grants/patch-client-grants-by-id

  """
  @spec update(id, map(), config) ::
          {:ok, map()} | error
  def update(id, %{} = params, %Config{} = config) do
    Patch.execute(id, params, config)
  end
end
