defmodule Auth0.Management.Users.Permissions.Assign do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Util
  alias Auth0.Common.Management.Http

  @type id :: String.t()
  @type params :: map()
  @type config :: Config.t()
  @type entity :: String.t()
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

  @endpoint "/api/v2/users/{id}/permissions"

  @doc """
  Assign permissions to a user.

  ## see
  https://auth0.com/docs/api/management/v2/users/post-permissions

  """
  @spec execute(id, params, config) :: response
  def execute(id, %{} = params, %Config{} = config) do
    body =
      params
      |> Util.remove_nil()
      |> case do
        map = %{permissions: permissions} when permissions |> is_list ->
          %{
            map
            | permissions: permissions |> Enum.map(&(&1 |> Util.to_map() |> Util.remove_nil()))
          }

        map ->
          map
      end

    @endpoint
    |> String.replace("{id}", id)
    |> Http.post(body, config)
    |> case do
      {:ok, 201, _body} -> {:ok, ""}
      error -> error
    end
  end
end
