defmodule Auth0.Management.Prompts.Renderings.BulkUpdate do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Management.Http

  @type params :: map()
  @type config :: Config.t()
  @type entity :: map()
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

  @endpoint "/api/v2/prompts/rendering"

  @doc """
  Update render settings for multiple screens.

  Learn more about [configuring render settings](https://auth0.com/docs/customize/login-pages/advanced-customizations/getting-started/configure-acul-screens) for advanced customization.

  ## see
  https://auth0.com/docs/api/management/v2/prompts/patch-bulk-rendering

  """
  @spec execute(params, config) :: response
  def execute(%{} = params, %Config{} = config) do
    @endpoint
    |> Http.patch(params, config)
    |> case do
      {:ok, 200, body} -> {:ok, body |> Jason.decode!()}
      error -> error
    end
  end
end
