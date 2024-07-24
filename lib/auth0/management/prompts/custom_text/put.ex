defmodule Auth0.Management.Prompts.CustomText.Put do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Management.Http

  @type prompt :: String.t()
  @type language :: String.t()
  @type params :: map()
  @type config :: Config.t()
  @type entity :: String.t()
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

  @endpoint "/api/v2/prompts/{prompt}/custom-text/{language}"

  @doc """
  Set custom text for a specific prompt. Existing texts will be overwritten.

  ## see
  https://auth0.com/docs/api/management/v2/prompts/put-custom-text-by-language

  """
  @spec execute(prompt, language, params, config) :: response
  def execute(prompt, language, %{} = params, %Config{} = config) do
    body = params.value

    @endpoint
    |> String.replace("{prompt}", prompt)
    |> String.replace("{language}", language)
    |> Http.put(body, config)
    |> case do
      {:ok, 200, _body} -> {:ok, ""}
      error -> error
    end
  end
end
