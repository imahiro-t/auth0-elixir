defmodule Auth0.Management.Organizations.ClientGrants.Delete do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Util
  alias Auth0.Common.Management.Http

  @type id :: String.t()
  @type grant_id :: String.t()
  @type config :: Config.t()
  @type entity :: String.t()
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

  @endpoint "/api/v2/organizations/{id}/client-grants/{grant_id}"

  @doc """
  Remove a client grant from an organization.

  ## see
  https://auth0.com/docs/api/management/v2/organizations/delete-client-grants-by-grant-id

  """
  @spec execute(id, grant_id, config) :: response
  def execute(id, grant_id, %Config{} = config) do
    Util.build_path(@endpoint, id: id, grant_id: grant_id)
    |> Http.delete(config)
    |> case do
      {:ok, 204, _body} -> {:ok, ""}
      error -> error
    end
  end
end
