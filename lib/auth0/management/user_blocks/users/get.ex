defmodule Auth0.Management.UserBlocks.Users.Get do
  @moduledoc """
  Documentation for Auth0 Management Get a user's blocks.

  ## see
  https://auth0.com/docs/api/management/v2/#!/User_Blocks/get_user_blocks
  """

  alias Auth0.Config
  alias Auth0.Common.Util
  alias Auth0.Common.Management.Http
  alias Auth0.Entity.UserBlocks

  defmodule Params do
    defstruct consider_brute_force_enablement: nil

    @type t :: %__MODULE__{
            consider_brute_force_enablement: boolean
          }
  end

  @type endpoint :: String.t()
  @type id :: String.t()
  @type params :: Params.t()
  @type config :: Config.t()
  @type entity :: UserBlocks.t()
  @type response_body :: String.t()
  @type response :: {:ok, entity, response_body} | {:error, integer, term} | {:error, term}

  @doc """
  Get a user's blocks.

  ## see
  https://auth0.com/docs/api/management/v2/#!/User_Blocks/get_user_blocks

  """
  @spec execute(endpoint, id, params, config) :: response
  def execute(endpoint, id, %Params{} = params, %Config{} = config) do
    params
    |> Util.to_map()
    |> Util.convert_to_query()
    |> Util.append_query(endpoint |> String.replace("{id}", id))
    |> Http.get(config)
    |> case do
      {:ok, 200, body} -> {:ok, UserBlocks.from(body |> Jason.decode!()), body}
      error -> error
    end
  end
end
