defmodule Auth0.Management.RulesConfigs do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Management.RulesConfigs.List
  alias Auth0.Management.RulesConfigs.Delete
  alias Auth0.Management.RulesConfigs.Put

  @type key :: String.t()
  @type config :: Config.t()
  @type error :: {:error, integer, term} | {:error, term}

  @doc """
  Retrieve rules config variable keys.

  ## see
  https://auth0.com/docs/api/management/v2/rules-configs/get-rules-configs

  """
  @spec list(config) ::
          {:ok, list() | map()} | error
  def list(%Config{} = config) do
    List.execute(config)
  end

  @doc """
  Delete a rules config variable identified by its key.

  ## see
  https://auth0.com/docs/api/management/v2/rules-configs/delete-rules-configs-by-key

  """
  @spec delete(key, config) :: {:ok, String.t()} | error
  def delete(key, %Config{} = config) do
    Delete.execute(key, config)
  end

  @doc """
  Sets a rules config variable.

  ## see
  https://auth0.com/docs/api/management/v2/rules-configs/put-rules-configs-by-key

  """
  @spec set(key, map(), config) ::
          {:ok, list() | map()} | error
  def set(key, %{} = params, %Config{} = config) do
    Put.execute(key, params, config)
  end
end
