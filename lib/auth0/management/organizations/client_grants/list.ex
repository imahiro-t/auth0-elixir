defmodule Auth0.Management.Organizations.ClientGrants.List do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Util
  alias Auth0.Common.Management.Http

  @type id :: String.t()
  @type params :: map()
  @type config :: Config.t()
  @type entity :: map() | list(map())
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

  @endpoint "/api/v2/organizations/{id}/client-grants"

  @doc """
  Get client grants associated to an organization.

  ## see
  https://auth0.com/docs/api/management/v2/organizations/get-organization-client-grants

  """
  @spec execute(id, params, config) :: response
  def execute(id, %{} = params, %Config{} = config) do
    params
    |> Util.convert_to_query()
    |> Util.append_query(path(id))
    |> Http.get(config)
    |> case do
      {:ok, 200, body} -> {:ok, body |> Jason.decode!()}
      error -> error
    end
  end

  defp path(id) do
    @endpoint
    |> String.replace("{id}", Util.encode_path_param(id))
  end
end
