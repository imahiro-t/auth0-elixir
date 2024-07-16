defmodule Auth0.Management.Sessions do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Entity
  alias Auth0.Management.Sessions.Get
  alias Auth0.Management.Sessions.Delete

  @type id :: String.t()
  @type config :: Config.t()
  @type response_body :: String.t()
  @type error :: {:error, integer, term} | {:error, term}

  @endpoint_by_id "/api/v2/sessions/{id}"

  @doc """
  Retrieve session information.

  ## see
  https://auth0.com/docs/api/management/v2/sessions/get-session

  """
  @spec get(id, config) ::
          {:ok, Entity.Session.t(), response_body} | error
  def get(id, %Config{} = config) do
    Get.execute(@endpoint_by_id, id, config)
  end

  @doc """
  Delete a session by ID.

  ## see
  https://auth0.com/docs/api/management/v2/sessions/delete-session

  """
  @spec delete(id, config) :: {:ok, String.t(), response_body} | error
  def delete(id, %Config{} = config) do
    Delete.execute(@endpoint_by_id, id, config)
  end
end
