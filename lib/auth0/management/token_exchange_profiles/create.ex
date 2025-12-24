defmodule Auth0.Management.TokenExchangeProfiles.Create do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Management.Http

  @type params :: map()
  @type config :: Config.t()
  @type entity :: map()
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

  @endpoint "/api/v2/token-exchange-profiles"

  @doc """
  Create a token exchange profile.

  ## see
  https://auth0.com/docs/api/management/v2/token-exchange-profiles/post-token-exchange-profiles
  """
  @spec execute(params, config) :: response
  def execute(%{} = params, %Config{} = config) do
    @endpoint
    |> Http.post(params, config)
    |> case do
      {:ok, 201, body} -> {:ok, body |> Jason.decode!()}
      error -> error
    end
  end
end
