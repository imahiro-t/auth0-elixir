defmodule Auth0.Management.RiskAssessments do
  @moduledoc """
  Facade for the Auth0 Management API Risk Assessments endpoints.

  Most applications should call `Auth0.Api.Management` instead of this module.
  """

  alias Auth0.Config
  alias Auth0.Management.RiskAssessments.Create
  alias Auth0.Management.RiskAssessments.Get

  @type id :: String.t()
  @type config :: Config.t()
  @type error :: {:error, integer, term} | {:error, term}

  @doc """
  Create a risk assessment.

  ## see
  https://auth0.com/docs/api/management/v2/risk-assessments/post-risk-assessments
  """
  @spec create(map(), config) :: {:ok, map()} | error
  def create(%{} = params, %Config{} = config) do
    Create.execute(params, config)
  end

  @doc """
  Retrieve a risk assessment by its ID.

  ## see
  https://auth0.com/docs/api/management/v2/risk-assessments/get-risk-assessments-by-id
  """
  @spec get(id, config) :: {:ok, map()} | error
  def get(id, %Config{} = config) do
    Get.execute(id, config)
  end
end
