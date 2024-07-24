defmodule Auth0.Management.Prompts.CustomText.Get do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Management.Http

  @type prompt :: String.t()
  @type language :: String.t()
  @type config :: Config.t()
  @type entity :: map()
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

  @endpoint "/api/v2/prompts/{prompt}/custom-text/{language}"

  @doc """
  Retrieve custom text for a specific prompt and language.

  ## see
  https://auth0.com/docs/api/management/v2/prompts/get-custom-text-by-language

  """
  @spec execute(prompt, language, config) :: response
  def execute(prompt, language, %Config{} = config) do
    @endpoint
    |> String.replace("{prompt}", prompt)
    |> String.replace("{language}", language)
    |> Http.get(config)
    |> case do
      {:ok, 200, body} -> {:ok, body |> Jason.decode!()}
      error -> error
    end
  end
end
