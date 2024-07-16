defmodule Auth0.Management.Users.Sessions.List do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Util
  alias Auth0.Common.Management.Http
  alias Auth0.Entity.Sessions

  defmodule Params do
    @moduledoc false
    defstruct from: nil,
              take: nil,
              include_totals: nil

    @type t :: %__MODULE__{
            from: String.t(),
            take: integer,
            include_totals: boolean
          }
  end

  @type endpoint :: String.t()
  @type user_id :: String.t()
  @type params :: Params.t() | map
  @type config :: Config.t()
  @type entity :: Sessions.t()
  @type response_body :: String.t()
  @type response :: {:ok, entity, response_body} | {:error, integer, term} | {:error, term}

  @doc """
  Retrieve details for a user's sessions.

  ## see
  https://auth0.com/docs/api/management/v2/users/get-sessions-for-user

  """
  @spec execute(endpoint, user_id, params, config) :: response
  def execute(endpoint, user_id, %Params{} = params, %Config{} = config) do
    execute(endpoint, user_id, params |> Util.to_map(), config)
  end

  def execute(endpoint, user_id, %{} = params, %Config{} = config) do
    params
    |> Util.convert_to_query()
    |> Util.append_query(endpoint |> String.replace("{user_id}", user_id))
    |> Http.get(config)
    |> case do
      {:ok, 200, body} -> {:ok, Sessions.from(body |> Jason.decode!()), body}
      error -> error
    end
  end
end
