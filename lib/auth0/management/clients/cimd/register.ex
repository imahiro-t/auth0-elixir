defmodule Auth0.Management.Clients.Cimd.Register do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Management.Http

  @type params :: map()
  @type config :: Config.t()
  @type entity :: map()
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

  @endpoint "/api/v2/clients/cimd/register"

  @doc """
  Register or update a CIMD client via metadata URI.

  Idempotent registration for Client ID Metadata Document (CIMD) clients. Uses external_client_id as the unique identifier for upsert operations.

  ## see
  https://auth0.com/docs/api/management/v2/clients/post-clients-cimd-register

  """
  @spec execute(params, config) :: response
  def execute(%{} = params, %Config{} = config) do
    @endpoint
    |> Http.post(params, config)
    |> case do
      {:ok, 200, body} -> {:ok, body |> Jason.decode!()}
      {:ok, 201, body} -> {:ok, body |> Jason.decode!()}
      error -> error
    end
  end
end
