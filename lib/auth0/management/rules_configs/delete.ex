defmodule Auth0.Management.RulesConfigs.Delete do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Management.Http

  @type endpoint :: String.t()
  @type key :: String.t()
  @type config :: Config.t()
  @type entity :: String.t()
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

  @doc """
  Delete rules config for a given key.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Rules_Configs/delete_rules_configs_by_key

  """
  @spec execute(endpoint, key, config) :: response
  def execute(endpoint, key, %Config{} = config) do
    endpoint
    |> String.replace("{key}", key)
    |> Http.delete(config)
    |> case do
      {:ok, 204, _body} -> {:ok, ""}
      error -> error
    end
  end
end
