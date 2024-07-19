defmodule Auth0.Management.Actions.Triggers.Bindings.List do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Util
  alias Auth0.Common.Management.Http

  defmodule Params do
    @moduledoc false
    defstruct page: nil,
              per_page: nil

    @type t :: %__MODULE__{
            page: integer,
            per_page: integer
          }
  end

  @type endpoint :: String.t()
  @type trigger_id :: String.t()
  @type params :: Params.t() | map()
  @type config :: Config.t()
  @type entity :: list() | map()
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

  @doc """
  Get trigger bindingsGet trigger bindings.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Actions/get_bindings

  """
  @spec execute(endpoint, trigger_id, params, config) :: response
  def execute(endpoint, trigger_id, %Params{} = params, %Config{} = config) do
    execute(endpoint, trigger_id, params |> Util.to_map(), config)
  end

  def execute(endpoint, trigger_id, %{} = params, %Config{} = config) do
    params
    |> Util.convert_to_query()
    |> Util.append_query(endpoint |> String.replace("{triggerId}", trigger_id))
    |> Http.get(config)
    |> case do
      {:ok, 200, body} ->
        {:ok, body |> Jason.decode!()}

      error ->
        error
    end
  end
end
