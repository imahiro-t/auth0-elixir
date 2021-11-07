defmodule Auth0.Management.Roles.List do
  @moduledoc """
  Documentation for Auth0 Management Get roles.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Roles/get_roles
  """

  alias Auth0.Config
  alias Auth0.Common.Util
  alias Auth0.Common.Management.Http
  alias Auth0.Entity.Roles

  defmodule Params do
    defstruct page: nil,
              per_page: nil,
              include_totals: nil,
              name_filter: nil

    @type t :: %__MODULE__{
            page: integer,
            per_page: integer,
            include_totals: boolean,
            name_filter: String.t()
          }
  end

  @type endpoint :: String.t()
  @type params :: Params.t()
  @type config :: Config.t()
  @type entity :: Roles.t()
  @type response_body :: String.t()
  @type response :: {:ok, entity, response_body} | {:error, integer, term} | {:error, term}

  @doc """
  Get roles.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Roles/get_roles

  """
  @spec execute(endpoint, params, config) :: response
  def execute(endpoint, %Params{} = params, %Config{} = config) do
    params
    |> Util.to_map()
    |> Util.convert_to_query()
    |> Util.append_query(endpoint)
    |> Http.get(config)
    |> case do
      {:ok, 200, body} -> {:ok, Roles.from(body |> Jason.decode!()), body}
      error -> error
    end
  end
end
