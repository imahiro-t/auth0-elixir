defmodule Auth0.Management.Clients.Credential.List do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Management.Http

  @type endpoint :: String.t()
  @type client_id :: String.t()
  @type config :: Config.t()
  @type entity :: list(map())
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

  @doc """
  Get client credentials.

  ## see
  https://auth0.com/docs/api/management/v2/clients/get-credentials

  """
  @spec execute(endpoint, client_id, config) :: response
  def execute(endpoint, client_id, %Config{} = config) do
    endpoint
    |> String.replace("{client_id}", client_id)
    |> Http.get(config)
    |> case do
      {:ok, 200, body} -> {:ok, body |> Jason.decode!()}
      error -> error
    end
  end
end
