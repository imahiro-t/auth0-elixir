defmodule Auth0.Management.UserBlocks.Users.Unblock do
  @moduledoc """
  Documentation for Auth0 Management Unblock a user.

  ## see
  https://auth0.com/docs/api/management/v2/#!/User_Blocks/delete_user_blocks_by_id
  """

  alias Auth0.Config
  alias Auth0.Common.Management.Http

  @type endpoint :: String.t()
  @type id :: String.t()
  @type config :: Config.t()
  @type entity :: String.t()
  @type response_body :: String.t()
  @type response :: {:ok, entity, response_body} | {:error, integer, term} | {:error, term}

  @doc """
  Unblock a user.

  ## see
  https://auth0.com/docs/api/management/v2/#!/User_Blocks/delete_user_blocks_by_id

  """
  @spec execute(endpoint, id, config) :: response
  def execute(endpoint, id, %Config{} = config) do
    endpoint
    |> String.replace("{id}", id)
    |> Http.delete(config)
    |> case do
      {:ok, 204, body} -> {:ok, "", body}
      error -> error
    end
  end
end
