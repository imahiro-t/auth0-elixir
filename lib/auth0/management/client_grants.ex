defmodule Auth0.Management.ClientGrants do
  @moduledoc """
  Facade for the Auth0 Management API Client Grants endpoints.

  Most applications should call `Auth0.Api.Management` instead of this module.
  """

  alias Auth0.Config
  alias Auth0.Management.ClientGrants.List
  alias Auth0.Management.ClientGrants.Create
  alias Auth0.Management.ClientGrants.Delete
  alias Auth0.Management.ClientGrants.Patch
  alias Auth0.Management.ClientGrants.Get, as: ClientGrantsGet
  alias Auth0.Management.ClientGrants.Organizations.List, as: ClientGrantsOrganizationsList

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

  @doc """
  Get client grant.

  Retrieve a single [client grant](https://auth0.com/docs/get-started/applications/application-access-to-apis-client-grants), including the scopes associated with the application/API pair.

  ## see
  https://auth0.com/docs/api/management/v2/client-grants/get-client-grant

  """
  @spec get(String.t(), config) :: {:ok, map()} | error
  def get(id, %Config{} = config) do
    ClientGrantsGet.execute(id, config)
  end

  @doc """
  Get the organizations associated to a client grant.

  ## see
  https://auth0.com/docs/api/management/v2/client-grants/get-client-grant-organizations

  """
  @spec list_organizations(String.t(), map(), config) :: {:ok, map() | list(map())} | error
  def list_organizations(id, %{} = params, %Config{} = config) do
    ClientGrantsOrganizationsList.execute(id, params, config)
  end
end
