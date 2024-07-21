defmodule Auth0.Management.Roles.Delete do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Management.Http

  @type id :: String.t()
  @type config :: Config.t()
  @type entity :: String.t()
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

  @endpoint "/api/v2/roles/{id}"

  @doc """
  Delete a specific user role from your tenant. Once deleted, it is removed from any user who was previously assigned that role. This action cannot be undone.

  ## see
  https://auth0.com/docs/api/management/v2/roles/delete-roles-by-id

  """
  @spec execute(id, config) :: response
  def execute(id, %Config{} = config) do
    @endpoint
    |> String.replace("{id}", id)
    |> Http.delete(config)
    |> case do
      {:ok, 200, _body} -> {:ok, ""}
      {:ok, 204, _body} -> {:ok, ""}
      error -> error
    end
  end
end
