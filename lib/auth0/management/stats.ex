defmodule Auth0.Management.Stats do
  alias Auth0.Config
  alias Auth0.Management.Stats.ActiveUsers
  alias Auth0.Management.Stats.Daily

  @type config :: Config.t()
  @type error :: {:error, integer, term} | {:error, term}

  @doc """
  Retrieve the number of active users that logged in during the last 30 days.

  ## see
  https://auth0.com/docs/api/management/v2/stats/get-active-users

  """
  @spec count_active_users(config) :: {:ok, integer} | error
  def count_active_users(%Config{} = config) do
    ActiveUsers.Count.execute(config)
  end

  @doc """
  Retrieve the number of logins, signups and breached-password detections (subscription required) that occurred each day within a specified date range.

  ## see
  https://auth0.com/docs/api/management/v2/stats/get-daily

  """
  @spec list_daily(config) :: {:ok, list(map())} | error
  def list_daily(%Config{} = config) do
    Daily.List.execute(config)
  end
end
