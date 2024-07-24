defmodule Auth0.Management.Sessions do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Management.Sessions.Get
  alias Auth0.Management.Sessions.Delete

  @type id :: String.t()
  @type config :: Config.t()
  @type error :: {:error, integer, term} | {:error, term}

  @doc """
  Retrieve session information.

  ## see
  https://auth0.com/docs/api/management/v2/sessions/get-session

  """
  @spec get(id, config) ::
          {:ok, map()} | error
  def get(id, %Config{} = config) do
    Get.execute(id, config)
  end

  @doc """
  Delete a session by ID.

  ## see
  https://auth0.com/docs/api/management/v2/sessions/delete-session

  """
  @spec delete(id, config) :: {:ok, String.t()} | error
  def delete(id, %Config{} = config) do
    Delete.execute(id, config)
  end
end
