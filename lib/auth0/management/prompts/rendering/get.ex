defmodule Auth0.Management.Prompts.Rendering.Get do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Management.Http

  @type prompt :: String.t()
  @type screen :: String.t()
  @type config :: Config.t()
  @type entity :: map()
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

  @endpoint "/api/v2/prompts/{prompt}/screen/{screen}/rendering"

  @doc """
  Retrieve the rendering configuration for a single screen.

  ## see
  https://auth0.com/docs/api/management/v2/prompts/get-rendering-configuration
  """
  @spec execute(prompt, screen, config) :: response
  def execute(prompt, screen, %Config{} = config) do
    @endpoint
    |> String.replace("{prompt}", prompt)
    |> String.replace("{screen}", screen)
    |> Http.get(config)
    |> case do
      {:ok, 200, body} ->
        {:ok, body |> Jason.decode!()}

      error ->
        error
    end
  end
end
