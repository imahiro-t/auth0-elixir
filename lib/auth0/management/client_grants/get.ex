defmodule Auth0.Management.ClientGrants.Get do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Util
  alias Auth0.Common.Management.Http

  @type id :: String.t()
  @type config :: Config.t()
  @type entity :: map()
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

  @endpoint "/api/v2/client-grants/{id}"

  @doc """
  Get client grant.

  Retrieve a single [client grant](https://auth0.com/docs/get-started/applications/application-access-to-apis-client-grants), including the scopes associated with the application/API pair.

  ## see
  https://auth0.com/docs/api/management/v2/client-grants/get-client-grant

  """
  @spec execute(id, config) :: response
  def execute(id, %Config{} = config) do
    path(id)
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
