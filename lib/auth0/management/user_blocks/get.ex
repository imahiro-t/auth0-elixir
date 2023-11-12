defmodule Auth0.Management.UserBlocks.Get do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Util
  alias Auth0.Common.Management.Http
  alias Auth0.Entity.UserBlocks

  defmodule Params do
    @moduledoc false
    defstruct identifier: nil,
              consider_brute_force_enablement: nil

    @type t :: %__MODULE__{
            identifier: String.t(),
            consider_brute_force_enablement: boolean
          }
  end

  @type endpoint :: String.t()
  @type params :: Params.t() | map
  @type config :: Config.t()
  @type entity :: UserBlocks.t()
  @type response_body :: String.t()
  @type response :: {:ok, entity, response_body} | {:error, integer, term} | {:error, term}

  @doc """
  Get blocks by identifier.

  ## see
  https://auth0.com/docs/api/management/v2/#!/User_Blocks/get_user_blocks

  """
  @spec execute(endpoint, params, config) :: response
  def execute(endpoint, %Params{} = params, %Config{} = config) do
    execute(endpoint, params |> Util.to_map(), config)
  end

  def execute(endpoint, %{} = params, %Config{} = config) do
    params
    |> Util.convert_to_query()
    |> Util.append_query(endpoint)
    |> Http.get(config)
    |> case do
      {:ok, 200, body} -> {:ok, UserBlocks.from(body |> Jason.decode!()), body}
      error -> error
    end
  end
end
