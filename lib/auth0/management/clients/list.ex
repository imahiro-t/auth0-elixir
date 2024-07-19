defmodule Auth0.Management.Clients.List do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Util
  alias Auth0.Common.Management.Http

  defmodule Params do
    @moduledoc false
    defstruct page: nil,
              per_page: nil,
              include_totals: nil,
              fields: nil,
              include_fields: nil,
              is_global: nil,
              is_first_party: nil,
              app_type: nil

    @type t :: %__MODULE__{
            page: integer,
            per_page: integer,
            include_totals: boolean,
            fields: String.t(),
            include_fields: boolean,
            is_global: boolean,
            is_first_party: boolean,
            app_type: String.t()
          }
  end

  @type endpoint :: String.t()
  @type params :: Params.t() | map()
  @type config :: Config.t()
  @type entity :: list() | map()
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

  @doc """
  Get clients.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Clients/get_clients

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
      {:ok, 200, body} -> {:ok, body |> Jason.decode!()}
      error -> error
    end
  end
end
