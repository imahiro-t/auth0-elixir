defmodule Auth0.Management.AttackProtection.BruteForceProtection.Get do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Management.Http
  alias Auth0.Entity.AttackProtectionBruteForceProtection

  @type endpoint :: String.t()
  @type config :: Config.t()
  @type entity :: AttackProtectionBruteForceProtection.t()
  @type response_body :: String.t()
  @type response :: {:ok, entity, response_body} | {:error, integer, term} | {:error, term}

  @doc """
  Get the brute force configuration.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Attack_Protection/get_brute_force_protection

  """
  @spec execute(endpoint, config) :: response
  def execute(endpoint, %Config{} = config) do
    Http.get(endpoint, config)
    |> case do
      {:ok, 200, body} ->
        {:ok, AttackProtectionBruteForceProtection.from(body |> Jason.decode!()), body}

      error ->
        error
    end
  end
end
