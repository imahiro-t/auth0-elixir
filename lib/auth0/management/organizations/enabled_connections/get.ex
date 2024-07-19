defmodule Auth0.Management.Organizations.EnabledConnections.Get do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Management.Http

  @type endpoint :: String.t()
  @type id :: String.t()
  @type connection_id :: String.t()
  @type config :: Config.t()
  @type entity :: list() | map()
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

  @doc """
  Get an invitation to organization.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Organizations/get_invitations_by_invitation_id

  """
  @spec execute(endpoint, id, connection_id, config) :: response
  def execute(endpoint, id, connection_id, %Config{} = config) do
    endpoint
    |> String.replace("{id}", id)
    |> String.replace("{connectionId}", connection_id)
    |> Http.get(config)
    |> case do
      {:ok, 200, body} -> {:ok, body |> Jason.decode!()}
      error -> error
    end
  end
end
