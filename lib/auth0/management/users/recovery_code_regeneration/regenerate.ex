defmodule Auth0.Management.Users.RecoveryCodeRegeneration.Regenerate do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Management.Http
  alias Auth0.Entity.RecoveryCodeRegeneration

  @type endpoint :: String.t()
  @type id :: String.t()
  @type config :: Config.t()
  @type entity :: RecoveryCodeRegeneration.t()
  @type response_body :: String.t()
  @type response :: {:ok, entity, response_body} | {:error, integer, term} | {:error, term}

  @doc """
  Generate New Multi-factor Authentication Recovery Code.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Users/post_recovery_code_regeneration

  """
  @spec execute(endpoint, id, config) :: response
  def execute(endpoint, id, %Config{} = config) do
    endpoint
    |> String.replace("{id}", id)
    |> Http.post(%{}, config)
    |> case do
      {:ok, 200, body} ->
        {:ok, RecoveryCodeRegeneration.from(body |> Jason.decode!()), body}

      error ->
        error
    end
  end
end
