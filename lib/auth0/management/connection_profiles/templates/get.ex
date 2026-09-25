defmodule Auth0.Management.ConnectionProfiles.Templates.Get do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Util
  alias Auth0.Common.Management.Http

  @type id :: String.t()
  @type config :: Config.t()
  @type entity :: map()
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

  @endpoint "/api/v2/connection-profiles/templates/{id}"

  @doc """
  Get Connection Profile Template.

  Retrieve a Connection Profile Template.

  ## see
  https://auth0.com/docs/api/management/v2/connection-profiles/get-connection-profile-template

  """
  @spec execute(id, config) :: response
  def execute(id, %Config{} = config) do
    Util.build_path(@endpoint, id: id)
    |> Http.get(config)
    |> case do
      {:ok, 200, body} -> {:ok, body |> Jason.decode!()}
      error -> error
    end
  end
end
