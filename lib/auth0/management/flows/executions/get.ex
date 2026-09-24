defmodule Auth0.Management.Flows.Executions.Get do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Util
  alias Auth0.Common.Management.Http

  @type flow_id :: String.t()
  @type execution_id :: String.t()
  @type params :: map()
  @type config :: Config.t()
  @type entity :: map()
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

  @endpoint "/api/v2/flows/{flow_id}/executions/{execution_id}"

  @doc """
  Get a flow execution.

  ## see
  https://auth0.com/docs/api/management/v2/flows/get-flows-executions-by-execution-id

  """
  @spec execute(flow_id, execution_id, params, config) :: response
  def execute(flow_id, execution_id, %{} = params, %Config{} = config) do
    params
    |> Util.convert_to_query()
    |> Util.append_query(path(flow_id, execution_id))
    |> Http.get(config)
    |> case do
      {:ok, 200, body} -> {:ok, body |> Jason.decode!()}
      error -> error
    end
  end

  defp path(flow_id, execution_id) do
    @endpoint
    |> String.replace("{flow_id}", Util.encode_path_param(flow_id))
    |> String.replace("{execution_id}", Util.encode_path_param(execution_id))
  end
end
