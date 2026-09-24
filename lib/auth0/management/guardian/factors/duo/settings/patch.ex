defmodule Auth0.Management.Guardian.Factors.Duo.Settings.Patch do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Management.Http

  @type params :: map()
  @type config :: Config.t()
  @type entity :: map()
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

  @endpoint "/api/v2/guardian/factors/duo/settings"

  @doc """
  Update the DUO Configuration.

  ## see
  https://auth0.com/docs/api/management/v2/guardian/patch-factor-duo-settings

  """
  @spec execute(params, config) :: response
  def execute(%{} = params, %Config{} = config) do
    @endpoint
    |> Http.patch(params, config)
    |> case do
      {:ok, 200, body} -> {:ok, body |> Jason.decode!()}
      error -> error
    end
  end
end
