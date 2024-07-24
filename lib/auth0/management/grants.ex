defmodule Auth0.Management.Grants do
  alias Auth0.Config
  alias Auth0.Management.Grants.List
  alias Auth0.Management.Grants.Delete
  alias Auth0.Management.Grants.DeleteByUserId

  @type id :: String.t()
  @type config :: Config.t()
  @type error :: {:error, integer, term} | {:error, term}

  @doc """
  Retrieve the grants associated with your account.

  ## see
  https://auth0.com/docs/api/management/v2/grants/get-grants

  """
  @spec list(map(), config) ::
          {:ok, list(map()) | map()} | error
  def list(%{} = params, %Config{} = config) do
    List.execute(params, config)
  end

  @doc """
  Delete a grant associated with your account.

  ## see
  https://auth0.com/docs/api/management/v2/grants/delete-grants-by-id

  """
  @spec delete(id, config) :: {:ok, String.t()} | error
  def delete(id, %Config{} = config) do
    Delete.execute(id, config)
  end

  @doc """
  Delete a grant associated with your account.

  ## see
  https://auth0.com/docs/api/management/v2/grants/delete-grants-by-user-id

  """
  @spec delete_by_user_id(map, config) :: {:ok, String.t()} | error
  def delete_by_user_id(%{} = params, %Config{} = config) do
    DeleteByUserId.execute(params, config)
  end
end
