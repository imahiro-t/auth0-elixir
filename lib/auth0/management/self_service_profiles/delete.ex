defmodule Auth0.Management.SelfServiceProfiles.Delete do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Management.Http

  @type id :: String.t()
  @type config :: Config.t()
  @type entity :: map()
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

  @endpoint "/api/v2/self-service-profiles/{id}"

  @doc """
  Deletes a self-service profile by Id.

  ## see
  https://auth0.com/docs/api/management/v2/self-service-profiles/delete-self-service-profiles-by-id

  """
  @spec execute(id, config) :: response
  def execute(id, %Config{} = config) do
    @endpoint
    |> String.replace("{id}", id)
    |> Http.delete(config)
    |> case do
      {:ok, 204, body} -> {:ok, body |> Jason.decode!()}
      error -> error
    end
  end
end
