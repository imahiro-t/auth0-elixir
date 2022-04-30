defmodule Auth0.Management.Actions.Versions.List do
  @moduledoc """
  Documentation for Auth0 Management Get an action's versions.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Actions/get_action_versions
  """

  alias Auth0.Config
  alias Auth0.Common.Util
  alias Auth0.Common.Management.Http
  alias Auth0.Entity.ActionVersions

  defmodule Params do
    defstruct page: nil,
              per_page: nil

    @type t :: %__MODULE__{
            page: integer,
            per_page: integer
          }
  end

  @type endpoint :: String.t()
  @type action_id :: String.t()
  @type params :: Params.t() | map()
  @type config :: Config.t()
  @type entity :: ActionVersions.t()
  @type response_body :: String.t()
  @type response :: {:ok, entity, response_body} | {:error, integer, term} | {:error, term}

  @doc """
  Get an action's versions.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Actions/get_action_versions

  """
  @spec execute(endpoint, action_id, params, config) :: response
  def execute(endpoint, action_id, %Params{} = params, %Config{} = config) do
    execute(endpoint, action_id, params |> Util.to_map(), config)
  end

  def execute(endpoint, action_id, %{} = params, %Config{} = config) do
    params
    |> Util.convert_to_query()
    |> Util.append_query(endpoint |> String.replace("{actionId}", action_id))
    |> Http.get(config)
    |> case do
      {:ok, 200, body} -> {:ok, ActionVersions.from(body |> Jason.decode!()), body}
      error -> error
    end
  end
end
