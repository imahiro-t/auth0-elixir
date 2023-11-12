defmodule Auth0.Management.Guardian.Enrollments.Get do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Management.Http
  alias Auth0.Entity.GuardianEnrollment

  @type endpoint :: String.t()
  @type id :: String.t()
  @type config :: Config.t()
  @type entity :: GuardianEnrollment.t()
  @type response_body :: String.t()
  @type response :: {:ok, entity, response_body} | {:error, integer, term} | {:error, term}

  @doc """
  Retrieve a multi-factor authentication enrollment.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Guardian/get_enrollments_by_id

  """
  @spec execute(endpoint, id, config) :: response
  def execute(endpoint, id, %Config{} = config) do
    endpoint
    |> String.replace("{id}", id)
    |> Http.get(config)
    |> case do
      {:ok, 200, body} -> {:ok, GuardianEnrollment.from(body |> Jason.decode!()), body}
      error -> error
    end
  end
end
