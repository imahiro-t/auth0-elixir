defmodule Auth0.Management.Stats do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Entity
  alias Auth0.Management.Stats.ActiveUsers
  alias Auth0.Management.Stats.Daily

  @type config :: Config.t()
  @type response_body :: String.t()
  @type error :: {:error, integer, term} | {:error, term}

  @endpoint_active_users "/api/v2/stats/active-users"
  @endpoint_daily "/api/v2/stats/daily"

  @doc """
  Get active users count.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Stats/get_active_users

  """
  @spec count_active_users(config) :: {:ok, integer, response_body} | error
  def count_active_users(%Config{} = config) do
    ActiveUsers.Count.execute(@endpoint_active_users, config)
  end

  @doc """
  Get daily stats.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Stats/get_daily

  """
  @spec list_daily(config) :: {:ok, Entity.DailyStats.t(), response_body} | error
  def list_daily(%Config{} = config) do
    Daily.List.execute(@endpoint_daily, config)
  end
end
