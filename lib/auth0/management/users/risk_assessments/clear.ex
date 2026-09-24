defmodule Auth0.Management.Users.RiskAssessments.Clear do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Util
  alias Auth0.Common.Management.Http

  @type id :: String.t()
  @type params :: map()
  @type config :: Config.t()
  @type entity :: String.t()
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

  @endpoint "/api/v2/users/{id}/risk-assessments/clear"

  @doc """
  Clear risk assessment assessors for a specific user.

  ## see
  https://auth0.com/docs/api/management/v2/users/post-clear-assessors

  """
  @spec execute(id, params, config) :: response
  def execute(id, %{} = params, %Config{} = config) do
    Util.build_path(@endpoint, id: id)
    |> Http.post(params, config)
    |> case do
      {:ok, 204, _body} -> {:ok, ""}
      error -> error
    end
  end
end
