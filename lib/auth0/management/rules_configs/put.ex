defmodule Auth0.Management.RulesConfigs.Put do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Util
  alias Auth0.Common.Management.Http

  @type key :: String.t()
  @type params :: map()
  @type config :: Config.t()
  @type entity :: list() | map()
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

  @endpoint "/api/v2/rules-configs/{key}"

  @doc """
  Sets a rules config variable.

  ## see
  https://auth0.com/docs/api/management/v2/rules-configs/put-rules-configs-by-key

  """
  @spec execute(key, params, config) :: response
  def execute(key, %{} = params, %Config{} = config) do
    body = params |> Util.remove_nil()

    @endpoint
    |> String.replace("{key}", key)
    |> Http.put(body, config)
    |> case do
      {:ok, 200, body} -> {:ok, body |> Jason.decode!()}
      error -> error
    end
  end
end
