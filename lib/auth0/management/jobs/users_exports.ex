defmodule Auth0.Management.Jobs.UsersExport do
  @moduledoc """
  Documentation for Auth0 Management Create export users job.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Jobs/post_users_exports
  """

  alias Auth0.Config
  alias Auth0.Common.Util
  alias Auth0.Common.Management.Http
  alias Auth0.Entity.JobsUsersExport

  defmodule Params do
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
  @type params :: Params.t()
  @type config :: Config.t()
  @type entity :: JobsUsersExport.t()
  @type response_body :: String.t()
  @type response :: {:ok, entity, response_body} | {:error, integer, term} | {:error, term}

  @doc """
  Create export users job.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Jobs/post_users_exports

  """
  @spec execute(endpoint, params, config) :: response
  def execute(endpoint, %Params{} = params, %Config{} = config) do
    body = params |> Util.to_map() |> Util.remove_nil()

    Http.post(endpoint, body, config)
    |> case do
      ## actual
      {:ok, 200, body} -> {:ok, JobsUsersExport.from(body |> Jason.decode!()), body}
      ## documented
      {:ok, 201, body} -> {:ok, JobsUsersExport.from(body |> Jason.decode!()), body}
      error -> error
    end
  end
end
