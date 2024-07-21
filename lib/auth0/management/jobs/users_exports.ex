defmodule Auth0.Management.Jobs.UsersExport do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Util
  alias Auth0.Common.Management.Http

  @type params :: map()
  @type config :: Config.t()
  @type entity :: list() | map()
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

  @endpoint "/api/v2/jobs/users-exports"

  @doc """
  Export all users to a file via a long-running job.

  ## see
  https://auth0.com/docs/api/management/v2/jobs/post-users-exports

  """
  @spec execute(params, config) :: response
  def execute(%{} = params, %Config{} = config) do
    body = params |> Util.remove_nil()

    Http.post(@endpoint, body, config)
    |> case do
      {:ok, 200, body} -> {:ok, body |> Jason.decode!()}
      error -> error
    end
  end
end
