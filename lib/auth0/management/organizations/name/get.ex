defmodule Auth0.Management.Organizations.Name.Get do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Management.Http

  @type name :: String.t()
  @type config :: Config.t()
  @type entity :: map()
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

  @endpoint "/api/v2/organizations/name/{name}"

  @doc """
  Retrieve details about a single Organization specified by name.

  ## see
  https://auth0.com/docs/api/management/v2/organizations/get-name-by-name

  """
  @spec execute(name, config) :: response
  def execute(name, %Config{} = config) do
    @endpoint
    |> String.replace("{name}", name)
    |> Http.get(config)
    |> case do
      {:ok, 200, body} -> {:ok, body |> Jason.decode!()}
      error -> error
    end
  end
end
