defmodule Auth0.Management.Stats.ActiveUsers.Count do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Management.Http

  @type endpoint :: String.t()
  @type config :: Config.t()
  @type entity :: integer
  @type response_body :: String.t()
  @type response :: {:ok, entity, response_body} | {:error, integer, term} | {:error, term}

  @doc """
  Get active users count.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Stats/get_active_users

  """
  @spec execute(endpoint, config) :: response
  def execute(endpoint, %Config{} = config) do
    endpoint
    |> Http.get(config)
    |> case do
      {:ok, 200, body} -> {:ok, body, body}
      error -> error
    end
  end
end
