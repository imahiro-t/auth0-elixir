defmodule Auth0.Management.Flows.Executions.Delete do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Util
  alias Auth0.Common.Management.Http

  @type flow_id :: String.t()
  @type execution_id :: String.t()
  @type config :: Config.t()
  @type entity :: String.t()
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

  @endpoint "/api/v2/flows/{flow_id}/executions/{execution_id}"

  @doc """
  Delete a flow execution.

  ## see
  https://auth0.com/docs/api/management/v2/flows/delete-flows-executions-by-execution-id

  """
  @spec execute(flow_id, execution_id, config) :: response
  def execute(flow_id, execution_id, %Config{} = config) do
    path(flow_id, execution_id)
    |> Http.delete(config)
    |> case do
      {:ok, 204, _body} -> {:ok, ""}
      error -> error
    end
  end

  defp path(flow_id, execution_id) do
    @endpoint
    |> String.replace("{flow_id}", Util.encode_path_param(flow_id))
    |> String.replace("{execution_id}", Util.encode_path_param(execution_id))
  end
end
