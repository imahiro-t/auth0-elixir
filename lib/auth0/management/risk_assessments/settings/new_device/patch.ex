defmodule Auth0.Management.RiskAssessments.Settings.NewDevice.Patch do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Management.Http

  @type params :: map()
  @type config :: Config.t()
  @type entity :: map()
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

  @endpoint "/api/v2/risk-assessments/settings/new-device"

  @doc """
  Update new device assessor.

  Updates the risk assessment settings for the new device assessor

  ## see
  https://auth0.com/docs/api/management/v2/risk-assessments/patch-new-device

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
