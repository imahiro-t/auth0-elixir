defmodule Auth0.Management.Flows.Executions.List do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Util
  alias Auth0.Common.Management.Http

  @type flow_id :: String.t()
  @type params :: map()
  @type config :: Config.t()
  @type entity :: map() | list(map())
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

  @endpoint "/api/v2/flows/{flow_id}/executions"

  @doc """
  Get flow executions.

  ## see
  https://auth0.com/docs/api/management/v2/flows/get-flows-executions

  """
  @spec execute(flow_id, params, config) :: response
  def execute(flow_id, %{} = params, %Config{} = config) do
    params
    |> Util.convert_to_query()
    |> Util.append_query(Util.build_path(@endpoint, flow_id: flow_id))
    |> Http.get(config)
    |> case do
      {:ok, 200, body} -> {:ok, body |> Jason.decode!()}
      error -> error
    end
  end
end
