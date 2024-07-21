defmodule Auth0.Management.Clients.Credential.List do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Management.Http

  @type client_id :: String.t()
  @type config :: Config.t()
  @type entity :: list(map())
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

  @endpoint "/api/v2/clients/{client_id}/credentials"

  @doc """
  Get the details of a client credential.

  ## see
  https://auth0.com/docs/api/management/v2/clients/get-credentials

  """
  @spec execute(client_id, config) :: response
  def execute(client_id, %Config{} = config) do
    @endpoint
    |> String.replace("{client_id}", client_id)
    |> Http.get(config)
    |> case do
      {:ok, 200, body} -> {:ok, body |> Jason.decode!()}
      error -> error
    end
  end
end
