defmodule Auth0.Management.Users.List do
  @moduledoc """
  Documentation for Auth0 Management List or Search Users.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Users/get_users
  """

  alias Auth0.Config
  alias Auth0.Common.Util
  alias Auth0.Common.Management.Http
  alias Auth0.Entity.Users

  defmodule Params do
    defstruct page: nil,
              per_page: nil,
              include_totals: nil,
              sort: nil,
              connection: nil,
              fields: nil,
              include_fields: nil,
              q: nil,
              search_engine: nil

    @type t :: %__MODULE__{
            page: integer,
            per_page: integer,
            include_totals: boolean,
            sort: String.t(),
            connection: String.t(),
            fields: String.t(),
            include_fields: boolean,
            q: String.t(),
            search_engine: String.t()
          }
  end

  @type endpoint :: String.t()
  @type params :: Params.t() | map
  @type config :: Config.t()
  @type entity :: Users.t()
  @type response_body :: String.t()
  @type response :: {:ok, entity, response_body} | {:error, integer, term} | {:error, term}

  @doc """
  List or Search Users.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Users/get_users

  """
  @spec execute(endpoint, params, config) :: response
  def execute(endpoint, %Params{} = params, %Config{} = config) do
    execute(endpoint, params |> Util.to_map(), config)
  end

  def execute(endpoint, %{} = params, %Config{} = config) do
    params
    |> Util.convert_to_query()
    |> Util.append_query(endpoint)
    |> Http.get(config)
    |> case do
      {:ok, 200, body} -> {:ok, Users.from(body |> Jason.decode!()), body}
      error -> error
    end
  end
end
