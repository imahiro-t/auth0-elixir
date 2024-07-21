defmodule Auth0.Management.Clients.Credential.Delete do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Management.Http

  @type client_id :: String.t()
  @type credential_id :: String.t()
  @type config :: Config.t()
  @type entity :: String.t()
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

  @endpoint "/api/v2/clients/{client_id}/credentials/{credential_id}"

  @doc """
  Delete a client credential you previously created. May be enabled or disabled.

  ## see
  https://auth0.com/docs/api/management/v2/clients/delete-credentials-by-credential-id

  """
  @spec execute(client_id, credential_id, config) :: response
  def execute(client_id, credential_id, %Config{} = config) do
    @endpoint
    |> String.replace("{client_id}", client_id)
    |> String.replace("{credential_id}", credential_id)
    |> Http.delete(config)
    |> case do
      {:ok, 204, _body} -> {:ok, ""}
      error -> error
    end
  end
end
