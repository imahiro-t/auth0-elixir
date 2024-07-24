defmodule Auth0.Management.Users.RecoveryCodeRegeneration.Regenerate do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Management.Http

  @type id :: String.t()
  @type config :: Config.t()
  @type entity :: map()
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

  @endpoint "/api/v2/users/{id}/recovery-code-regeneration"

  @doc """
  Remove an existing multi-factor authentication (MFA) recovery code and generate a new one. If a user cannot access the original device or account used for MFA enrollment, they can use a recovery code to authenticate.

  ## see
  https://auth0.com/docs/api/management/v2/users/post-recovery-code-regeneration

  """
  @spec execute(id, config) :: response
  def execute(id, %Config{} = config) do
    @endpoint
    |> String.replace("{id}", id)
    |> Http.post(%{}, config)
    |> case do
      {:ok, 200, body} ->
        {:ok, body |> Jason.decode!()}

      error ->
        error
    end
  end
end
