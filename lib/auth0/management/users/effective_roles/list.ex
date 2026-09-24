defmodule Auth0.Management.Users.EffectiveRoles.List do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Util
  alias Auth0.Common.Management.Http

  @type id :: String.t()
  @type params :: map()
  @type config :: Config.t()
  @type entity :: map()
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

  @endpoint "/api/v2/users/{id}/effective-roles"

  @doc """
  List the roles for a user with sources: directly assigned or through group membership.

  Retrieve detailed list of effective roles for a user, including roles assigned directly and through group memberships.

  ## see
  https://auth0.com/docs/api/management/v2/users/get-user-effective-roles

  """
  @spec execute(id, params, config) :: response
  def execute(id, %{} = params, %Config{} = config) do
    params
    |> Util.convert_to_query()
    |> Util.append_query(Util.build_path(@endpoint, id: id))
    |> Http.get(config)
    |> case do
      {:ok, 200, body} -> {:ok, body |> Jason.decode!()}
      error -> error
    end
  end
end
