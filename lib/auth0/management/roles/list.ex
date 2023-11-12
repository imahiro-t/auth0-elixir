defmodule Auth0.Management.Roles.List do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Util
  alias Auth0.Common.Management.Http
  alias Auth0.Entity.Roles

  defmodule Params do
    @moduledoc false
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
  @type params :: Params.t() | map
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
    execute(endpoint, params |> Util.to_map(), config)
  end

  def execute(endpoint, %{} = params, %Config{} = config) do
    params
    |> Util.convert_to_query()
    |> Util.append_query(endpoint)
    |> Http.get(config)
    |> case do
      {:ok, 200, body} -> {:ok, Roles.from(body |> Jason.decode!()), body}
      error -> error
    end
  end
end
