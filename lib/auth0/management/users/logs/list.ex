defmodule Auth0.Management.Users.Logs.List do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Util
  alias Auth0.Common.Management.Http

  @type id :: String.t()
  @type params :: map()
  @type config :: Config.t()
  @type entity :: list(map()) | map()
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

  @endpoint "/api/v2/users/{id}/logs"

  @doc """
  Retrieve log events for a specific user.

  ## see
  https://auth0.com/docs/api/management/v2/users/get-logs-by-user

  """
  @spec execute(id, params, config) :: response
  def execute(id, %{} = params, %Config{} = config) do
    params
    |> Util.convert_to_query()
    |> Util.append_query(@endpoint |> String.replace("{id}", id))
    |> Http.get(config)
    |> case do
      {:ok, 200, body} -> {:ok, body |> Jason.decode!()}
      error -> error
    end
  end
end
