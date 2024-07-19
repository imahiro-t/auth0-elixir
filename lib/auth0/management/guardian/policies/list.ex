defmodule Auth0.Management.Guardian.Policies.List do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Management.Http

  @type endpoint :: String.t()
  @type config :: Config.t()
  @type entity :: list(map)
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

  @doc """
  Get the Multi-factor Authentication policies.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Guardian/get_policies

  """
  @spec execute(endpoint, config) :: response
  def execute(endpoint, %Config{} = config) do
    endpoint
    |> Http.get(config)
    |> case do
      {:ok, 200, body} -> {:ok, body |> Jason.decode!()}
      error -> error
    end
  end
end
