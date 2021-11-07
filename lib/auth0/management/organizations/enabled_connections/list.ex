defmodule Auth0.Management.Organizations.EnabledConnections.List do
  @moduledoc """
  Documentation for Auth0 Management Get connections enabled for an organization.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Organizations/get_enabled_connections
  """

  alias Auth0.Config
  alias Auth0.Common.Util
  alias Auth0.Common.Management.Http
  alias Auth0.Entity.EnabledConnections

  defmodule Params do
    defstruct page: nil,
              per_page: nil,
              include_totals: nil,
              from: nil,
              take: nil

    @type t :: %__MODULE__{
            page: integer,
            per_page: integer,
            include_totals: boolean,
            from: String.t(),
            take: integer
          }
  end

  @type endpoint :: String.t()
  @type id :: String.t()
  @type params :: Params.t()
  @type config :: Config.t()
  @type entity :: EnabledConnections.t()
  @type response_body :: String.t()
  @type response :: {:ok, entity, response_body} | {:error, integer, term} | {:error, term}

  @doc """
  Get connections enabled for an organization.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Organizations/get_enabled_connections

  """
  @spec execute(endpoint, id, params, config) :: response
  def execute(endpoint, id, %Params{} = params, %Config{} = config) do
    params
    |> Util.to_map()
    |> Util.convert_to_query()
    |> Util.append_query(endpoint |> String.replace("{id}", id))
    |> Http.get(config)
    |> case do
      {:ok, 200, body} -> {:ok, EnabledConnections.from(body |> Jason.decode!()), body}
      error -> error
    end
  end
end
