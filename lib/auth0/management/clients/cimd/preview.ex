defmodule Auth0.Management.Clients.Cimd.Preview do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Management.Http

  @type params :: map()
  @type config :: Config.t()
  @type entity :: map()
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

  @endpoint "/api/v2/clients/cimd/preview"

  @doc """
  Preview and validate Client ID Metadata Document.

  Fetches and validates a Client ID Metadata Document without creating a client. Returns the raw metadata and how it would be mapped to Auth0 client fields. This endpoint is useful for testing metadata URIs before creating CIMD clients.

  ## see
  https://auth0.com/docs/api/management/v2/clients/post-clients-cimd-preview

  """
  @spec execute(params, config) :: response
  def execute(%{} = params, %Config{} = config) do
    @endpoint
    |> Http.post(params, config)
    |> case do
      {:ok, 200, body} -> {:ok, body |> Jason.decode!()}
      error -> error
    end
  end
end
