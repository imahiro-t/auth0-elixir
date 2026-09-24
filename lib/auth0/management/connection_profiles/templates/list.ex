defmodule Auth0.Management.ConnectionProfiles.Templates.List do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Management.Http

  @type config :: Config.t()
  @type entity :: map()
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

  @endpoint "/api/v2/connection-profiles/templates"

  @doc """
  Get Connection Profile Templates.

  Retrieve a list of Connection Profile Templates.

  ## see
  https://auth0.com/docs/api/management/v2/connection-profiles/get-connection-profile-templates

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
