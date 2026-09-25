defmodule Auth0.Management.Organizations.Clients.Create do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Util
  alias Auth0.Common.Management.Http

  @type id :: String.t()
  @type params :: map()
  @type config :: Config.t()
  @type entity :: list(map())
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

  @endpoint "/api/v2/organizations/{id}/clients"

  @doc """
  Associate clients with an organization.

  Associate one or more clients with an organization.

  **Early Access**: this endpoint is marked as Early Access (`x-release-lifecycle: EA`) in the Auth0 Management API specification and may not be available on every tenant.

  ## see
  https://auth0.com/docs/api/management/v2/organizations/post-organization-clients

  """
  @spec execute(id, params, config) :: response
  def execute(id, %{} = params, %Config{} = config) do
    Util.build_path(@endpoint, id: id)
    |> Http.post(params, config)
    |> case do
      {:ok, 201, body} -> {:ok, body |> Jason.decode!()}
      error -> error
    end
  end
end
