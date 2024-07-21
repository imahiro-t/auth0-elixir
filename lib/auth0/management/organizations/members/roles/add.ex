defmodule Auth0.Management.Organizations.Members.Roles.Add do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Util
  alias Auth0.Common.Management.Http

  @type id :: String.t()
  @type user_id :: String.t()
  @type params :: map()
  @type config :: Config.t()
  @type entity :: String.t()
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

  @endpoint "/api/v2/organizations/{id}/members/{user_id}/roles"

  @doc """
  Assign one or more roles to a user to determine their access for a specific Organization.

  ## see
  https://auth0.com/docs/api/management/v2/organizations/post-organization-member-roles

  """
  @spec execute(id, user_id, params, config) :: response
  def execute(id, user_id, %{} = params, %Config{} = config) do
    body = params |> Util.remove_nil()

    @endpoint
    |> String.replace("{id}", id)
    |> String.replace("{user_id}", user_id)
    |> Http.post(body, config)
    |> case do
      {:ok, 204, _body} -> {:ok, ""}
      error -> error
    end
  end
end
