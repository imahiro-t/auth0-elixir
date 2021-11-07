defmodule Auth0.Management.Users.Logs.List do
  @moduledoc """
  Documentation for Auth0 Management Get user's log event.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Users/get_logs_by_user
  """

  alias Auth0.Config
  alias Auth0.Common.Util
  alias Auth0.Common.Management.Http
  alias Auth0.Entity.Logs

  defmodule Params do
    defstruct page: nil,
              per_page: nil,
              sort: nil,
              include_totals: nil

    @type t :: %__MODULE__{
            page: integer,
            per_page: integer,
            sort: String.t(),
            include_totals: boolean
          }
  end

  @type endpoint :: String.t()
  @type id :: String.t()
  @type params :: Params.t()
  @type config :: Config.t()
  @type entity :: Logs.t()
  @type response_body :: String.t()
  @type response :: {:ok, entity, response_body} | {:error, integer, term} | {:error, term}

  @doc """
  Get user's log events.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Users/get_logs_by_user

  """
  @spec execute(endpoint, id, params, config) :: response
  def execute(endpoint, id, %Params{} = params, %Config{} = config) do
    params
    |> Util.to_map()
    |> Util.convert_to_query()
    |> Util.append_query(endpoint |> String.replace("{id}", id))
    |> Http.get(config)
    |> case do
      {:ok, 200, body} -> {:ok, Logs.from(body |> Jason.decode!()), body}
      error -> error
    end
  end
end
