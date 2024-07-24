defmodule Auth0.Management.Keys.Signing.Rotate do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Management.Http

  @type config :: Config.t()
  @type entity :: map()
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

  @endpoint "/api/v2/keys/signing/rotate"

  @doc """
  Rotate the application signing key of your tenant.

  ## see
  https://auth0.com/docs/api/management/v2/keys/post-signing-keys

  """
  @spec execute(config) :: response
  def execute(%Config{} = config) do
    @endpoint
    |> Http.post(%{}, config)
    |> case do
      {:ok, 201, body} -> {:ok, body |> Jason.decode!()}
      error -> error
    end
  end
end
