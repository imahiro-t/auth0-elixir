defmodule Auth0.Management.TokenExchangeProfiles.Patch do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Management.Http

  @type id :: String.t()
  @type params :: map()
  @type config :: Config.t()
  @type entity :: map()
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

  @endpoint "/api/v2/token-exchange-profiles/{id}"

  @doc """
  Update a token exchange profile.

  ## see
  https://auth0.com/docs/api/management/v2/token-exchange-profiles/patch-token-exchange-profiles-by-id
  """
  @spec execute(id, params, config) :: response
  def execute(id, %{} = params, %Config{} = config) do
    @endpoint
    |> String.replace("{id}", id)
    |> Http.patch(params, config)
    |> case do
      {:ok, 200, body} -> {:ok, body |> Jason.decode!()}
      error -> error
    end
  end
end
