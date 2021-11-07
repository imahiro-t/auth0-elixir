defmodule Auth0.Management.Guardian.Factors.List do
  @moduledoc """
  Documentation for Auth0 Management Retrieve Factors and their Status.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Guardian/get_factors
  """

  alias Auth0.Config
  alias Auth0.Common.Management.Http
  alias Auth0.Entity.GuardianFactors

  @type endpoint :: String.t()
  @type config :: Config.t()
  @type entity :: GuardianFactors.t()
  @type response_body :: String.t()
  @type response :: {:ok, entity, response_body} | {:error, integer, term} | {:error, term}

  @doc """
  Retrieve Factors and their Status.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Guardian/get_factors

  """
  @spec execute(endpoint, config) :: response
  def execute(endpoint, %Config{} = config) do
    endpoint
    |> Http.get(config)
    |> case do
      {:ok, 200, body} -> {:ok, GuardianFactors.from(body |> Jason.decode!()), body}
      error -> error
    end
  end
end
