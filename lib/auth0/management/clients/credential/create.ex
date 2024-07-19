defmodule Auth0.Management.Clients.Credential.Create do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Util
  alias Auth0.Common.Management.Http

  @type endpoint :: String.t()
  @type client_id :: String.t()
  @type params :: map()
  @type config :: Config.t()
  @type entity :: map()
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

  @doc """
  Create a client credential.

  ## see
  https://auth0.com/docs/api/management/v2/clients/post-credentials

  """
  @spec execute(endpoint, client_id, params, config) :: response
  def execute(endpoint, client_id, %{} = params, %Config{} = config) do
    body = params |> Util.remove_nil()

    endpoint
    |> String.replace("{client_id}", client_id)
    |> Http.post(body, config)
    |> case do
      {:ok, 201, body} -> {:ok, body |> Jason.decode!()}
      error -> error
    end
  end
end
