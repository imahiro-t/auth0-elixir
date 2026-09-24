defmodule Auth0.Management.RiskAssessments.Settings.NewDevice.Get do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Management.Http

  @type config :: Config.t()
  @type entity :: map()
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

  @endpoint "/api/v2/risk-assessments/settings/new-device"

  @doc """
  Get new device assessor.

  Gets the risk assessment settings for the new device assessor

  ## see
  https://auth0.com/docs/api/management/v2/risk-assessments/get-new-device

  """
  @spec execute(config) :: response
  def execute(%Config{} = config) do
    @endpoint
    |> Http.get(config)
    |> case do
      {:ok, 200, body} -> {:ok, body |> Jason.decode!()}
      error -> error
    end
  end
end
