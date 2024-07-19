defmodule Auth0.Management.Prompts.CustomText.Get do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Management.Http

  @type endpoint :: String.t()
  @type prompt :: String.t()
  @type language :: String.t()
  @type config :: Config.t()
  @type entity :: list() | map()
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

  @doc """
  Get custom text for a prompt.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Prompts/get_custom_text_by_language

  """
  @spec execute(endpoint, prompt, language, config) :: response
  def execute(endpoint, prompt, language, %Config{} = config) do
    endpoint
    |> String.replace("{prompt}", prompt)
    |> String.replace("{language}", language)
    |> Http.get(config)
    |> case do
      {:ok, 200, body} -> {:ok, body |> Jason.decode!()}
      error -> error
    end
  end
end
