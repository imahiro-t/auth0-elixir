defmodule Auth0.Management.Actions.Execution do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Management.Http

  @type id :: String.t()
  @type config :: Config.t()
  @type entity :: list() | map()
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

  @endpoint "/api/v2/actions/executions/{id}"

  @doc """
  Retrieve information about a specific execution of a trigger. Relevant execution IDs will be included in tenant logs generated as part of that authentication flow. Executions will only be stored for 10 days after their creation.

  ## see
  https://auth0.com/docs/api/management/v2/actions/get-execution

  """
  @spec execute(id, config) :: response
  def execute(id, %Config{} = config) do
    @endpoint
    |> String.replace("{id}", id)
    |> Http.get(config)
    |> case do
      {:ok, 200, body} -> {:ok, body |> Jason.decode!()}
      error -> error
    end
  end
end
