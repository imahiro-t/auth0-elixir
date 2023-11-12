defmodule Auth0.Management.AttackProtection.BreachedPasswordDetection.Get do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Management.Http
  alias Auth0.Entity.AttackProtectionBreachedPasswordDetection

  @type endpoint :: String.t()
  @type config :: Config.t()
  @type entity :: AttackProtectionBreachedPasswordDetection.t()
  @type response_body :: String.t()
  @type response :: {:ok, entity, response_body} | {:error, integer, term} | {:error, term}

  @doc """
  Get breached password detection settings.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Attack_Protection/get_breached_password_detection

  """
  @spec execute(endpoint, config) :: response
  def execute(endpoint, %Config{} = config) do
    Http.get(endpoint, config)
    |> case do
      {:ok, 200, body} ->
        {:ok, AttackProtectionBreachedPasswordDetection.from(body |> Jason.decode!()), body}

      error ->
        error
    end
  end
end
