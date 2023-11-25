defmodule Auth0.Management.Clients.Credential.Get do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Management.Http

  @type endpoint :: String.t()
  @type client_id :: String.t()
  @type credential_id :: String.t()
  @type config :: Config.t()
  @type entity :: map()
  @type response_body :: String.t()
  @type response :: {:ok, entity, response_body} | {:error, integer, term} | {:error, term}

  @doc """
  Get client credential.

  ## see
  https://auth0.com/docs/api/management/v2/clients/get-credentials-by-credential-id

  """
  @spec execute(endpoint, client_id, credential_id, config) :: response
  def execute(endpoint, client_id, credential_id, %Config{} = config) do
    endpoint
    |> String.replace("{client_id}", client_id)
    |> String.replace("{credential_id}", credential_id)
    |> Http.get(config)
    |> case do
      {:ok, 200, body} -> {:ok, body |> Jason.decode!(), body}
      error -> error
    end
  end
end
