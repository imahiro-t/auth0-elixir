defmodule Auth0.Management.Prompts.Rendering.Patch do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Management.Http

  @type prompt :: String.t()
  @type screen :: String.t()
  @type params :: map()
  @type config :: Config.t()
  @type entity :: map()
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

  @endpoint "/api/v2/prompts/{prompt}/screen/{screen}/rendering"

  @doc """
  Configures ACUL settings on a single screen.

  ## see
  https://auth0.com/docs/api/management/v2/prompts/patch-rendering-configuration
  """
  @spec execute(prompt, screen, params, config) :: response
  def execute(prompt, screen, %{} = params, %Config{} = config) do
    @endpoint
    |> String.replace("{prompt}", prompt)
    |> String.replace("{screen}", screen)
    |> Http.patch(params, config)
    |> case do
      {:ok, 200, body} ->
        {:ok, body |> Jason.decode!()}

      error ->
        error
    end
  end
end
