defmodule Auth0.Management.Guardian.Factors.Email.Settings.Put do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Management.Http

  @type params :: map()
  @type config :: Config.t()
  @type entity :: map()
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

  @endpoint "/api/v2/guardian/factors/email/settings"

  @doc """
  Set the Email Factor Settings.

  TODO: Link this endpoint to relevant documentation when available.

  ## see
  https://auth0.com/docs/api/management/v2/guardian/set-email-factor-settings

  """
  @spec execute(params, config) :: response
  def execute(%{} = params, %Config{} = config) do
    @endpoint
    |> Http.put(params, config)
    |> case do
      {:ok, 200, body} -> {:ok, body |> Jason.decode!()}
      error -> error
    end
  end
end
