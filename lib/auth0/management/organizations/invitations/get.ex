defmodule Auth0.Management.Organizations.Invitations.Get do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Util
  alias Auth0.Common.Management.Http

  @type id :: String.t()
  @type invitation_id :: String.t()
  @type params :: map()
  @type config :: Config.t()
  @type entity :: list() | map()
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

  @endpoint "/api/v2/organizations/{id}/invitations/{invitation_id}"

  @doc """
  Get a specific invitation to an Organization

  ## see
  https://auth0.com/docs/api/management/v2/organizations/get-invitations-by-invitation-id

  """
  @spec execute(id, invitation_id, params, config) :: response
  def execute(id, invitation_id, %{} = params, %Config{} = config) do
    params
    |> Util.convert_to_query()
    |> Util.append_query(
      @endpoint
      |> String.replace("{id}", id)
      |> String.replace("{invitation_id}", invitation_id)
    )
    |> Http.get(config)
    |> case do
      {:ok, 200, body} -> {:ok, body |> Jason.decode!()}
      error -> error
    end
  end
end
