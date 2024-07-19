defmodule Auth0.Management.RulesConfigs.Put do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Util
  alias Auth0.Common.Management.Http

  defmodule Params do
    @moduledoc false
    defstruct value: nil

    @type t :: %__MODULE__{
            value: String.t()
          }
  end

  @type endpoint :: String.t()
  @type key :: String.t()
  @type params :: Params.t() | map
  @type config :: Config.t()
  @type entity :: list() | map()
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

  @doc """
  Set rules config for a given key.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Rules_Configs/put_rules_configs_by_key

  """
  @spec execute(endpoint, key, params, config) :: response
  def execute(endpoint, key, %Params{} = params, %Config{} = config) do
    execute(endpoint, key, params |> Util.to_map(), config)
  end

  def execute(endpoint, key, %{} = params, %Config{} = config) do
    body = params |> Util.remove_nil()

    endpoint
    |> String.replace("{key}", key)
    |> Http.put(body, config)
    |> case do
      {:ok, 200, body} -> {:ok, body |> Jason.decode!()}
      error -> error
    end
  end
end
