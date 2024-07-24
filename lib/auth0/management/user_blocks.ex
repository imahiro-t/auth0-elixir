defmodule Auth0.Management.UserBlocks do
  alias Auth0.Config
  alias Auth0.Management.UserBlocks.Get
  alias Auth0.Management.UserBlocks.Unblock
  alias Auth0.Management.UserBlocks.Users

  @type id :: String.t()
  @type config :: Config.t()
  @type error :: {:error, integer, term} | {:error, term}

  @doc """
  Retrieve details of all Brute-force Protection blocks for a user with the given identifier (username, phone number, or email).

  ## see
  https://auth0.com/docs/api/management/v2/user-blocks/get-user-blocks

  """
  @spec get(map(), config) ::
          {:ok, map()} | error
  def get(%{} = params, %Config{} = config) do
    Get.execute(params, config)
  end

  @doc """
  Remove all Brute-force Protection blocks for the user with the given identifier (username, phone number, or email).

  ## see
  https://auth0.com/docs/api/management/v2/user-blocks/delete-user-blocks

  """
  @spec unblock(map(), config) :: {:ok, String.t()} | error
  def unblock(%{} = params, %Config{} = config) do
    Unblock.execute(params, config)
  end

  @doc """
  Retrieve details of all Brute-force Protection blocks for the user with the given ID.

  ## see
  https://auth0.com/docs/api/management/v2/user-blocks/get-user-blocks-by-id

  """
  @spec get_by_user_id(id, map(), config) ::
          {:ok, map()} | error
  def get_by_user_id(id, %{} = params, %Config{} = config) do
    Users.Get.execute(id, params, config)
  end

  @doc """
  Remove all Brute-force Protection blocks for the user with the given ID.

  ## see
  https://auth0.com/docs/api/management/v2/user-blocks/delete-user-blocks-by-id

  """
  @spec unblock_by_user_id(id, config) :: {:ok, String.t()} | error
  def unblock_by_user_id(id, %Config{} = config) do
    Users.Unblock.execute(id, config)
  end
end
