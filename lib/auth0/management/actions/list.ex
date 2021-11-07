defmodule Auth0.Management.Actions.List do
  @moduledoc """
  Documentation for Auth0 Management Get actions.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Actions/get_actions
  """

  alias Auth0.Config
  alias Auth0.Common.Util
  alias Auth0.Common.Management.Http
  alias Auth0.Entity.Actions

  defmodule Params do
    defstruct page: nil,
              per_page: nil,
              triggerId: nil,
              actionName: nil,
              deployed: nil,
              installed: nil

    @type t :: %__MODULE__{
            page: integer,
            per_page: integer,
            triggerId: String.t(),
            actionName: String.t(),
            deployed: boolean,
            installed: boolean
          }
  end

  @type endpoint :: String.t()
  @type params :: Params.t()
  @type config :: Config.t()
  @type entity :: Actions.t()
  @type response_body :: String.t()
  @type response :: {:ok, entity, response_body} | {:error, integer, term} | {:error, term}

  @doc """
  Get actions.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Actions/get_actions

  """
  @spec execute(endpoint, params, config) :: response
  def execute(endpoint, %Params{} = params, %Config{} = config) do
    params
    |> Util.to_map()
    |> Util.convert_to_query()
    |> Util.append_query(endpoint)
    |> Http.get(config)
    |> case do
      {:ok, 200, body} -> {:ok, Actions.from(body |> Jason.decode!()), body}
      error -> error
    end
  end
end
