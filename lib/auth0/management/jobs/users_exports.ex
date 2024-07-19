defmodule Auth0.Management.Jobs.UsersExport do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Util
  alias Auth0.Common.Management.Http

  defmodule Params do
    @moduledoc false
    defstruct connection_id: nil,
              format: nil,
              limit: nil,
              fields: nil

    @type t :: %__MODULE__{
            connection_id: String.t(),
            format: String.t(),
            limit: integer,
            fields: list(map)
          }
  end

  @type endpoint :: String.t()
  @type params :: Params.t() | map
  @type config :: Config.t()
  @type entity :: list() | map()
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

  @doc """
  Create export users job.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Jobs/post_users_exports

  """
  @spec execute(endpoint, params, config) :: response
  def execute(endpoint, %Params{} = params, %Config{} = config) do
    execute(endpoint, params |> Util.to_map(), config)
  end

  def execute(endpoint, %{} = params, %Config{} = config) do
    body = params |> Util.remove_nil()

    Http.post(endpoint, body, config)
    |> case do
      ## actual
      {:ok, 200, body} -> {:ok, body |> Jason.decode!()}
      ## documented
      {:ok, 201, body} -> {:ok, body |> Jason.decode!()}
      error -> error
    end
  end
end
