defmodule Auth0.Management.ClientGrants do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Entity
  alias Auth0.Management.ClientGrants.List
  alias Auth0.Management.ClientGrants.Create
  alias Auth0.Management.ClientGrants.Delete
  alias Auth0.Management.ClientGrants.Patch

  @type id :: String.t()
  @type config :: Config.t()
  @type response_body :: String.t()
  @type error :: {:error, integer, term} | {:error, term}

  @endpoint "/api/v2/client-grants"
  @endpoint_by_id "/api/v2/client-grants/{id}"

  @doc """
  Get client grants.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Client_Grants/get_client_grants

  """
  @spec list(List.Params.t() | map, config) ::
          {:ok, Entity.ClientGrants.t(), response_body} | error
  def list(%{} = params, %Config{} = config) do
    List.execute(@endpoint, params, config)
  end

  @doc """
  Create client grant.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Client_Grants/post_client_grants

  """
  @spec create(Create.Params.t() | map, config) ::
          {:ok, Entity.ClientGrant.t(), response_body} | error
  def create(%{} = params, %Config{} = config) do
    Create.execute(@endpoint, params, config)
  end

  @doc """
  Delete client grant.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Client_Grants/delete_client_grants_by_id

  """
  @spec delete(id, config) :: {:ok, String.t(), response_body} | error
  def delete(id, %Config{} = config) do
    Delete.execute(@endpoint_by_id, id, config)
  end

  @doc """
  Update client grant.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Client_Grants/patch_client_grants_by_id

  """
  @spec update(id, Patch.Params.t() | map, config) ::
          {:ok, Entity.ClientGrant.t(), response_body} | error
  def update(id, %{} = params, %Config{} = config) do
    Patch.execute(@endpoint_by_id, id, params, config)
  end
end
