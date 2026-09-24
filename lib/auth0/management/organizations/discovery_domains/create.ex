defmodule Auth0.Management.Organizations.DiscoveryDomains.Create do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Util
  alias Auth0.Common.Management.Http

  @type id :: String.t()
  @type params :: map()
  @type config :: Config.t()
  @type entity :: map()
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

  @endpoint "/api/v2/organizations/{id}/discovery-domains"

  @doc """
  Create an organization discovery domain.

  Create a new discovery domain for an organization.

  ## see
  https://auth0.com/docs/api/management/v2/organizations/post-discovery-domains

  """
  @spec execute(id, params, config) :: response
  def execute(id, %{} = params, %Config{} = config) do
    path(id)
    |> Http.post(params, config)
    |> case do
      {:ok, 201, body} -> {:ok, body |> Jason.decode!()}
      error -> error
    end
  end

  defp path(id) do
    @endpoint
    |> String.replace("{id}", Util.encode_path_param(id))
  end
end
