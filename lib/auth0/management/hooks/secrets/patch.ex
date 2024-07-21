defmodule Auth0.Management.Hooks.Secrets.Patch do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Management.Http

  @type id :: String.t()
  @type params :: map()
  @type config :: Config.t()
  @type entity :: map
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

  @endpoint "/api/v2/hooks/{id}"

  @doc """
  Update an existing hook.

  ## see
  https://auth0.com/docs/api/management/v2/hooks/patch-hooks-by-id

  """
  @spec execute(id, params, config) :: response
  def execute(id, %{} = params, %Config{} = config) do
    body = params.value

    @endpoint
    |> String.replace("{id}", id)
    |> Http.patch(body, config)
    |> case do
      {:ok, 201, body} -> {:ok, body |> Jason.decode!()}
      error -> error
    end
  end
end
