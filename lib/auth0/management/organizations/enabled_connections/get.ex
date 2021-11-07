defmodule Auth0.Management.Organizations.EnabledConnections.Get do
  @moduledoc """
  Documentation for Auth0 Management Get an invitation to organization.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Organizations/get_invitations_by_invitation_id
  """

  alias Auth0.Config
  alias Auth0.Common.Management.Http
  alias Auth0.Entity.EnabledConnection

  @type endpoint :: String.t()
  @type id :: String.t()
  @type connection_id :: String.t()
  @type config :: Config.t()
  @type entity :: EnabledConnection.t()
  @type response_body :: String.t()
  @type response :: {:ok, entity, response_body} | {:error, integer, term} | {:error, term}

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
      {:ok, 200, body} -> {:ok, EnabledConnection.from(body |> Jason.decode!()), body}
      error -> error
    end
  end
end
