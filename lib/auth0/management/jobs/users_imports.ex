defmodule Auth0.Management.Jobs.UsersImport do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Util
  alias Auth0.Common.Management.Http

  defmodule Params do
    @moduledoc false
    defstruct users: nil,
              connection_id: nil,
              upsert: nil,
              external_id: nil,
              send_completion_email: nil

    @type t :: %__MODULE__{
            users: String.t(),
            connection_id: String.t(),
            upsert: boolean,
            external_id: String.t(),
            send_completion_email: boolean
          }
  end

  @type endpoint :: String.t()
  @type params :: Params.t() | map
  @type config :: Config.t()
  @type entity :: list() | map()
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

  @doc """
  Create import users job.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Jobs/post_users_imports

  """
  @spec execute(endpoint, params, config) :: response
  def execute(endpoint, %Params{} = params, %Config{} = config) do
    execute(endpoint, params |> Util.to_map(), config)
  end

  def execute(endpoint, %{} = params, %Config{} = config) do
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

    Http.multipart_post(endpoint, multipart, config)
    |> case do
      ## documented
      {:ok, 201, body} -> {:ok, body |> Jason.decode!()}
      ## actual
      {:ok, 202, body} -> {:ok, body |> Jason.decode!()}
      error -> error
    end
  end
end
