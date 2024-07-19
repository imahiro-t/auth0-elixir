defmodule Auth0.Management.RulesConfigs do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Management.RulesConfigs.List
  alias Auth0.Management.RulesConfigs.Delete
  alias Auth0.Management.RulesConfigs.Put

  @type key :: String.t()
  @type config :: Config.t()
  @type error :: {:error, integer, term} | {:error, term}

  @endpoint "/api/v2/rules-configs"
  @endpoint_by_key "/api/v2/rules-configs/{key}"

  @doc """
  Retrieve config variable keys for rules (get_rules-configs).

  ## see
  https://auth0.com/docs/api/management/v2/#!/Rules_Configs/get_rules_configs

  """
  @spec list(config) ::
          {:ok, list() | map()} | error
  def list(%Config{} = config) do
    List.execute(@endpoint, config)
  end

  @doc """
  Delete rules config for a given key.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Rules_Configs/delete_rules_configs_by_key

  """
  @spec delete(key, config) :: {:ok, String.t()} | error
  def delete(key, %Config{} = config) do
    Delete.execute(@endpoint_by_key, key, config)
  end

  @doc """
  Set rules config for a given key.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Rules_Configs/put_rules_configs_by_key

  """
  @spec set(key, Put.Params.t() | map, config) ::
          {:ok, list() | map()} | error
  def set(key, %{} = params, %Config{} = config) do
    Put.execute(@endpoint_by_key, key, params, config)
  end
end
