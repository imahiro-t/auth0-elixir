defmodule Auth0.Management.RulesConfigs.Delete do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Management.Http

  @type key :: String.t()
  @type config :: Config.t()
  @type entity :: String.t()
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

  @endpoint "/api/v2/rules-configs/{key}"

  @doc """
  Delete a rules config variable identified by its key.

  ## see
  https://auth0.com/docs/api/management/v2/rules-configs/delete-rules-configs-by-key

  """
  @spec execute(key, config) :: response
  def execute(key, %Config{} = config) do
    @endpoint
    |> String.replace("{key}", key)
    |> Http.delete(config)
    |> case do
      {:ok, 204, _body} -> {:ok, ""}
      error -> error
    end
  end
end
