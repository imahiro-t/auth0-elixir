defmodule Auth0.Management.Rules.List do
  @moduledoc """
  Documentation for Auth0 Management Get rules.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Rules/get_rules
  """

  alias Auth0.Config
  alias Auth0.Common.Util
  alias Auth0.Common.Management.Http
  alias Auth0.Entity.Rules

  defmodule Params do
    defstruct page: nil,
              per_page: nil,
              include_totals: nil,
              fields: nil,
              include_fields: nil,
              enabled: nil

    @type t :: %__MODULE__{
            page: integer,
            per_page: integer,
            include_totals: boolean,
            fields: String.t(),
            include_fields: boolean,
            enabled: boolean
          }
  end

  @type endpoint :: String.t()
  @type params :: Params.t()
  @type config :: Config.t()
  @type entity :: Rules.t()
  @type response_body :: String.t()
  @type response :: {:ok, entity, response_body} | {:error, integer, term} | {:error, term}

  @doc """
  Get rules.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Rules/get_rules

  """
  @spec execute(endpoint, params, config) :: response
  def execute(endpoint, %Params{} = params, %Config{} = config) do
    params
    |> Util.to_map()
    |> Util.convert_to_query()
    |> Util.append_query(endpoint)
    |> Http.get(config)
    |> case do
      {:ok, 200, body} -> {:ok, Rules.from(body |> Jason.decode!()), body}
      error -> error
    end
  end
end
