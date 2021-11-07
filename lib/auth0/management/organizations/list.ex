defmodule Auth0.Management.Organizations.List do
  @moduledoc """
  Documentation for Auth0 Management Get organizations.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Organizations/get_organizations
  """

  alias Auth0.Config
  alias Auth0.Common.Util
  alias Auth0.Common.Management.Http
  alias Auth0.Entity.Organizations

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
  @type params :: Params.t()
  @type config :: Config.t()
  @type entity :: Organizations.t()
  @type response_body :: String.t()
  @type response :: {:ok, entity, response_body} | {:error, integer, term} | {:error, term}

  @doc """
  Get organizations.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Organizations/get_organizations

  """
  @spec execute(endpoint, params, config) :: response
  def execute(endpoint, %Params{} = params, %Config{} = config) do
    params
    |> Util.to_map()
    |> Util.convert_to_query()
    |> Util.append_query(endpoint)
    |> Http.get(config)
    |> case do
      {:ok, 200, body} -> {:ok, Organizations.from(body |> Jason.decode!()), body}
      error -> error
    end
  end
end
