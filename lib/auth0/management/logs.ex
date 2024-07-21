defmodule Auth0.Management.Logs do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Management.Logs.List
  alias Auth0.Management.Logs.Get

  @type id :: String.t()
  @type config :: Config.t()
  @type error :: {:error, integer, term} | {:error, term}

  @doc """
  Retrieve log entries that match the specified search criteria (or all log entries if no criteria specified).

  ## see
  https://auth0.com/docs/api/management/v2/logs/get-logs

  """
  @spec list(map(), config) ::
          {:ok, list() | map()} | error
  def list(%{} = params, %Config{} = config) do
    List.execute(params, config)
  end

  @doc """
  Retrieve an individual log event.

  ## see
  https://auth0.com/docs/api/management/v2/logs/get-logs-by-id

  """
  @spec get(id, config) ::
          {:ok, list() | map()} | error
  def get(id, %Config{} = config) do
    Get.execute(id, config)
  end
end
