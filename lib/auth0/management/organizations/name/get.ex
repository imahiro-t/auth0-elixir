defmodule Auth0.Management.Organizations.Name.Get do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Management.Http

  @type endpoint :: String.t()
  @type name :: String.t()
  @type config :: Config.t()
  @type entity :: list() | map()
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

  @doc """
  Get organization.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Organizations/get_organizations_by_id

  """
  @spec execute(endpoint, name, config) :: response
  def execute(endpoint, name, %Config{} = config) do
    endpoint
    |> String.replace("{name}", name)
    |> Http.get(config)
    |> case do
      {:ok, 200, body} -> {:ok, body |> Jason.decode!()}
      error -> error
    end
  end
end
