defmodule Auth0.Management.Prompts.Get do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Management.Http

  @type config :: Config.t()
  @type entity :: map()
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

  @endpoint "/api/v2/prompts"

  @doc """
  Retrieve details of the Universal Login configuration of your tenant. This includes the Identifier First Authentication and WebAuthn with Device Biometrics for MFA features.

  ## see
  https://auth0.com/docs/api/management/v2/prompts/get-prompts

  """
  @spec execute(config) :: response
  def execute(%Config{} = config) do
    @endpoint
    |> Http.get(config)
    |> case do
      {:ok, 200, body} -> {:ok, body |> Jason.decode!()}
      error -> error
    end
  end
end
