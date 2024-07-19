defmodule Auth0.Management.Hooks.Secrets.Get do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Management.Http

  @type endpoint :: String.t()
  @type id :: String.t()
  @type config :: Config.t()
  @type entity :: map
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

  @doc """
  Get hook secrets.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Hooks/get_secrets

  """
  @spec execute(endpoint, id, config) :: response
  def execute(endpoint, id, %Config{} = config) do
    endpoint
    |> String.replace("{id}", id)
    |> Http.get(config)
    |> case do
      {:ok, 200, body} -> {:ok, body |> Jason.decode!()}
      error -> error
    end
  end
end
