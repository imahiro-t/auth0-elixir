defmodule Auth0.Management.Stats.ActiveUsers.Count do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Management.Http

  @type config :: Config.t()
  @type entity :: integer
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

  @endpoint "/api/v2/stats/active-users"

  @doc """
  Retrieve the number of active users that logged in during the last 30 days.

  ## see
  https://auth0.com/docs/api/management/v2/stats/get-active-users

  """
  @spec execute(config) :: response
  def execute(%Config{} = config) do
    @endpoint
    |> Http.get(config)
    |> case do
      {:ok, 200, body} -> {:ok, body}
      error -> error
    end
  end
end
