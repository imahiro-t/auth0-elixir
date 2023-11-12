defmodule Auth0.Management.UserBlocks do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Entity
  alias Auth0.Management.UserBlocks.Get
  alias Auth0.Management.UserBlocks.Unblock
  alias Auth0.Management.UserBlocks.Users

  @type id :: String.t()
  @type config :: Config.t()
  @type response_body :: String.t()
  @type error :: {:error, integer, term} | {:error, term}

  @endpoint "/api/v2/user-blocks"
  @endpoint_by_id "/api/v2/user-blocks/{id}"

  @doc """
  Get blocks by identifier.

  ## see
  https://auth0.com/docs/api/management/v2/#!/User_Blocks/get_user_blocks

  """
  @spec get(Get.Params.t() | map, config) ::
          {:ok, Entity.UserBlocks.t(), response_body} | error
  def get(%{} = params, %Config{} = config) do
    Get.execute(@endpoint, params, config)
  end

  @doc """
  Unblock by identifier.

  ## see
  https://auth0.com/docs/api/management/v2/#!/User_Blocks/delete_user_blocks

  """
  @spec unblock(Unblock.Params.t() | map, config) :: {:ok, String.t(), response_body} | error
  def unblock(%{} = params, %Config{} = config) do
    Unblock.execute(@endpoint, params, config)
  end

  @doc """
  Get a user's blocks.

  ## see
  https://auth0.com/docs/api/management/v2/#!/User_Blocks/get_user_blocks_by_id

  """
  @spec get_by_user_id(id, Users.Get.Params.t() | map, config) ::
          {:ok, Entity.UserBlocks.t(), response_body} | error
  def get_by_user_id(id, %{} = params, %Config{} = config) do
    Users.Get.execute(@endpoint_by_id, id, params, config)
  end

  @doc """
  Unblock a user.

  ## see
  https://auth0.com/docs/api/management/v2/#!/User_Blocks/delete_user_blocks_by_id

  """
  @spec unblock_by_user_id(id, config) :: {:ok, String.t(), response_body} | error
  def unblock_by_user_id(id, %Config{} = config) do
    Users.Unblock.execute(@endpoint_by_id, id, config)
  end
end
