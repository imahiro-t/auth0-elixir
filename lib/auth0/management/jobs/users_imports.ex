defmodule Auth0.Management.Jobs.UsersImport do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Util
  alias Auth0.Common.Management.Http

  @type params :: map()
  @type config :: Config.t()
  @type entity :: list() | map()
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

  @endpoint "/api/v2/jobs/users-imports"

  @doc """
  Import users from a formatted file into a connection via a long-running job.

  ## see
  https://auth0.com/docs/api/management/v2/jobs/post-users-imports

  """
  @spec execute(params, config) :: response
  def execute(%{} = params, %Config{} = config) do
    multipart =
      {:multipart,
       [
         {"file", params.users, {"form-data", [name: "users", filename: "users.json"]}, []}
       ] ++
         (params
          |> Util.remove_nil()
          |> Enum.reject(fn {key, _value} -> key == :users end)
          |> Enum.map(fn {key, value} ->
            {key |> to_string, value |> to_string,
             [
               "content-type": "text/plain",
               "content-disposition": "form-data; name=\"#{key |> to_string}\""
             ]}
          end))}

    Http.multipart_post(@endpoint, multipart, config)
    |> case do
      {:ok, 202, body} -> {:ok, body |> Jason.decode!()}
      error -> error
    end
  end
end
