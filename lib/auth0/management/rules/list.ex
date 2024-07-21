defmodule Auth0.Management.Rules.List do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Util
  alias Auth0.Common.Management.Http

  @type params :: map()
  @type config :: Config.t()
  @type entity :: list() | map()
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

  @endpoint "/api/v2/rules"

  @doc """
  Retrieve a filtered list of rules. Accepts a list of fields to include or exclude.

  ## see
  https://auth0.com/docs/api/management/v2/rules/get-rules

  """
  @spec execute(params, config) :: response
  def execute(%{} = params, %Config{} = config) do
    params
    |> Util.convert_to_query()
    |> Util.append_query(@endpoint)
    |> Http.get(config)
    |> case do
      {:ok, 200, body} -> {:ok, body |> Jason.decode!()}
      error -> error
    end
  end
end
