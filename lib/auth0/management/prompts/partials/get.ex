defmodule Auth0.Management.Prompts.Partials.Get do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Management.Http

  @type prompt :: String.t()
  @type config :: Config.t()
  @type entity :: list() | map()
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

  @endpoint "/api/v2/prompts/{prompt}/partials"

  @doc """
  Get template partials for a prompt

  ## see
  https://auth0.com/docs/api/management/v2/prompts/get-partials

  """
  @spec execute(prompt, config) :: response
  def execute(prompt, %Config{} = config) do
    @endpoint
    |> String.replace("{prompt}", prompt)
    |> Http.get(config)
    |> case do
      {:ok, 200, body} -> {:ok, body |> Jason.decode!()}
      error -> error
    end
  end
end
