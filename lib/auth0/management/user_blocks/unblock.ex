defmodule Auth0.Management.UserBlocks.Unblock do
  @moduledoc """
  Documentation for Auth0 Management Unblock by identifier.

  ## see
  https://auth0.com/docs/api/management/v2/#!/User_Blocks/delete_user_blocks
  """

  alias Auth0.Config
  alias Auth0.Common.Util
  alias Auth0.Common.Management.Http

  defmodule Params do
    defstruct identifier: nil

    @type t :: %__MODULE__{
            identifier: String.t()
          }
  end

  @type endpoint :: String.t()
  @type params :: Params.t()
  @type config :: Config.t()
  @type entity :: String.t()
  @type response_body :: String.t()
  @type response :: {:ok, entity, response_body} | {:error, integer, term} | {:error, term}

  @doc """
  Unblock by identifier.

  ## see
  https://auth0.com/docs/api/management/v2/#!/User_Blocks/delete_user_blocks

  """
  @spec execute(endpoint, params, config) :: response
  def execute(endpoint, %Params{} = params, %Config{} = config) do
    params
    |> Util.to_map()
    |> Util.convert_to_query()
    |> Util.append_query(endpoint)
    |> Http.delete(config)
    |> case do
      {:ok, 204, body} -> {:ok, "", body}
      error -> error
    end
  end
end
