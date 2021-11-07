defmodule Auth0.Management.Logs do
  @moduledoc """
  Documentation for Auth0 Management API of Logs.

  ## endpoint
  - /api/v2/logs
  - /api/v2/logs/{id}
  """

  alias Auth0.Config
  alias Auth0.Entity
  alias Auth0.Management.Logs.List
  alias Auth0.Management.Logs.Get

  @type id :: String.t()
  @type config :: Config.t()
  @type response_body :: String.t()
  @type error :: {:error, integer, term} | {:error, term}

  @endpoint "/api/v2/logs"
  @endpoint_by_id "/api/v2/logs/{id}"

  @doc """
  Search log events.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Logs/get_logs

  """
  @spec list(List.Params.t(), config) :: {:ok, Entity.Logs.t(), response_body} | error
  def list(%List.Params{} = params, %Config{} = config) do
    List.execute(@endpoint, params, config)
  end

  @doc """
  Get a log event by id.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Logs/get_logs_by_id

  """
  @spec get(id, config) :: {:ok, Entity.Log.t(), response_body} | error
  def get(id, %Config{} = config) do
    Get.execute(@endpoint_by_id, id, config)
  end
end
