defmodule Auth0.Management.Connections.DirectoryProvisioning.Synchronizations.Create do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Util
  alias Auth0.Common.Management.Http

  @type id :: String.t()
  @type config :: Config.t()
  @type entity :: map()
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

  @endpoint "/api/v2/connections/{id}/directory-provisioning/synchronizations"

  @doc """
  Request an on-demand synchronization of the directory.

  ## see
  https://auth0.com/docs/api/management/v2/connections/post-synchronizations

  """
  @spec execute(id, config) :: response
  def execute(id, %Config{} = config) do
    Util.build_path(@endpoint, id: id)
    |> Http.post(%{}, config)
    |> case do
      {:ok, 201, body} -> {:ok, body |> Jason.decode!()}
      error -> error
    end
  end
end
