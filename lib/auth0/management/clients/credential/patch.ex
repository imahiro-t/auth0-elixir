defmodule Auth0.Management.Clients.Credential.Patch do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Util
  alias Auth0.Common.Management.Http

  @type client_id :: String.t()
  @type credential_id :: String.t()
  @type params :: map()
  @type config :: Config.t()
  @type entity :: map()
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

  @endpoint "/api/v2/clients/{client_id}/credentials/{credential_id}"

  @doc """
  Change a client credential you previously created. May be enabled or disabled.

  ## see
  https://auth0.com/docs/api/management/v2/clients/patch-credentials-by-credential-id

  """
  @spec execute(client_id, credential_id, params, config) :: response
  def execute(client_id, credential_id, %{} = params, %Config{} = config) do
    body = params |> Util.remove_nil()

    @endpoint
    |> String.replace("{client_id}", client_id)
    |> String.replace("{credential_id}", credential_id)
    |> Http.patch(body, config)
    |> case do
      {:ok, 201, body} -> {:ok, body |> Jason.decode!()}
      error -> error
    end
  end
end
