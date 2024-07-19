defmodule Auth0.Management.Guardian.Policies.Put do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Util
  alias Auth0.Common.Management.Http

  @type endpoint :: String.t()
  @type params :: map
  @type config :: Config.t()
  @type entity :: list(map)
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

  @doc """
  Set the Multi-factor Authentication policies.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Guardian/put_policies

  """
  @spec execute(endpoint, params, config) :: response
  def execute(endpoint, %{} = params, %Config{} = config) do
    body = params |> Util.remove_nil()

    endpoint
    |> Http.put(body, config)
    |> case do
      {:ok, 200, body} -> {:ok, body |> Jason.decode!()}
      error -> error
    end
  end
end
