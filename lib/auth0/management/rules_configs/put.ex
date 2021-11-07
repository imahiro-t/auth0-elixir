defmodule Auth0.Management.RulesConfigs.Put do
  @moduledoc """
  Documentation for Auth0 Management Set rules config for a given key.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Rules_Configs/put_rules_configs_by_key
  """

  alias Auth0.Config
  alias Auth0.Common.Util
  alias Auth0.Common.Management.Http
  alias Auth0.Entity.RulesConfig

  defmodule Params do
    defstruct value: nil

    @type t :: %__MODULE__{
            value: String.t()
          }
  end

  @type endpoint :: String.t()
  @type key :: String.t()
  @type params :: Params.t()
  @type config :: Config.t()
  @type entity :: RulesConfig.t()
  @type response_body :: String.t()
  @type response :: {:ok, entity, response_body} | {:error, integer, term} | {:error, term}

  @doc """
  Set rules config for a given key.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Rules_Configs/put_rules_configs_by_key

  """
  @spec execute(endpoint, key, params, config) :: response
  def execute(endpoint, key, %Params{} = params, %Config{} = config) do
    body = params |> Util.to_map() |> Util.remove_nil()

    endpoint
    |> String.replace("{key}", key)
    |> Http.put(body, config)
    |> case do
      {:ok, 200, body} -> {:ok, RulesConfig.from(body |> Jason.decode!()), body}
      error -> error
    end
  end
end
