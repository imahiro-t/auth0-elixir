defmodule Auth0.Management.Clients.RotateSecret do
  @moduledoc """
  Documentation for Auth0 Management Rotate a client secret.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Clients/post_rotate_secret
  """

  alias Auth0.Config
  alias Auth0.Common.Management.Http
  alias Auth0.Entity.Client

  @type endpoint :: String.t()
  @type id :: String.t()
  @type config :: Config.t()
  @type entity :: Client.t()
  @type response_body :: String.t()
  @type response :: {:ok, entity, response_body} | {:error, integer, term} | {:error, term}

  @doc """
  Rotate a client secret.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Clients/post_rotate_secret

  """
  @spec execute(endpoint, id, config) :: response
  def execute(endpoint, id, %Config{} = config) do
    endpoint
    |> String.replace("{id}", id)
    |> Http.post(%{}, config)
    |> case do
      {:ok, 200, body} -> {:ok, Client.from(body |> Jason.decode!()), body}
      error -> error
    end
  end
end
