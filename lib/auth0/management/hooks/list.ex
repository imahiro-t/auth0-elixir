defmodule Auth0.Management.Hooks.List do
  @moduledoc """
  Documentation for Auth0 Management Get hooks.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Hooks/get_hooks
  """

  alias Auth0.Config
  alias Auth0.Common.Util
  alias Auth0.Common.Management.Http
  alias Auth0.Entity.Hooks

  defmodule Params do
    defstruct page: nil,
              per_page: nil,
              include_totals: nil,
              fields: nil,
              enabled: nil,
              triggerId: nil

    @type t :: %__MODULE__{
            page: integer,
            per_page: integer,
            include_totals: boolean,
            fields: String.t(),
            enabled: boolean,
            triggerId: String.t()
          }
  end

  @type endpoint :: String.t()
  @type params :: Params.t() | map
  @type config :: Config.t()
  @type entity :: Hooks.t()
  @type response_body :: String.t()
  @type response :: {:ok, entity, response_body} | {:error, integer, term} | {:error, term}

  @doc """
  Get hooks.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Hooks/get_hooks

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
      {:ok, 200, body} -> {:ok, Hooks.from(body |> Jason.decode!()), body}
      error -> error
    end
  end
end
