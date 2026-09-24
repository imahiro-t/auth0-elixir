defmodule Auth0.Management.Actions.Modules.Versions.Get do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Util
  alias Auth0.Common.Management.Http

  @type id :: String.t()
  @type version_id :: String.t()
  @type config :: Config.t()
  @type entity :: map()
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

  @endpoint "/api/v2/actions/modules/{id}/versions/{versionId}"

  @doc """
  Get a specific version of an Actions Module.

  Retrieve the details of a specific, immutable version of an Actions Module.

  **Early Access**: this endpoint is marked as Early Access (`x-release-lifecycle: EA`) in the Auth0 Management API specification and may not be available on every tenant.

  ## see
  https://auth0.com/docs/api/management/v2/actions/get-action-module-version

  """
  @spec execute(id, version_id, config) :: response
  def execute(id, version_id, %Config{} = config) do
    Util.build_path(@endpoint, id: id, versionId: version_id)
    |> Http.get(config)
    |> case do
      {:ok, 200, body} -> {:ok, body |> Jason.decode!()}
      error -> error
    end
  end
end
