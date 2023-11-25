defmodule Auth0.Management.Grants do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Entity
  alias Auth0.Management.Grants.List
  alias Auth0.Management.Grants.Delete
  alias Auth0.Management.Grants.DeleteByUserId

  @type id :: String.t()
  @type config :: Config.t()
  @type response_body :: String.t()
  @type error :: {:error, integer, term} | {:error, term}

  @endpoint "/api/v2/grants"
  @endpoint_by_id "/api/v2/grants/{id}"

  @doc """
  Get grants.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Grants/get_grants

  """
  @spec list(List.Params.t() | map, config) ::
          {:ok, Entity.Grants.t(), response_body} | error
  def list(%{} = params, %Config{} = config) do
    List.execute(@endpoint, params, config)
  end

  @doc """
  Delete a grant.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Grants/delete_grants_by_id

  """
  @spec delete(id, config) :: {:ok, String.t(), response_body} | error
  def delete(id, %Config{} = config) do
    Delete.execute(@endpoint_by_id, id, config)
  end

  @doc """
  Delete a grant by user_id.

  ## see
  https://auth0.com/docs/api/management/v2/grants/delete-grants-by-user-id

  """
  @spec delete_by_user_id(map, config) :: {:ok, String.t(), response_body} | error
  def delete_by_user_id(%{} = params, %Config{} = config) do
    DeleteByUserId.execute(@endpoint, params, config)
  end
end
