defmodule Auth0.Management.Prompts.Partials.Put do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Management.Http

  @type prompt :: String.t()
  @type params :: map()
  @type config :: Config.t()
  @type entity :: String.t()
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

  @endpoint "/api/v2/prompts/{prompt}/partials"

  @doc """
  Set template partials for a prompt

  ## see
  https://auth0.com/docs/api/management/v2/prompts/put-partials

  """
  @spec execute(prompt, params, config) :: response
  def execute(prompt, %{} = params, %Config{} = config) do
    body = params.value

    @endpoint
    |> String.replace("{prompt}", prompt)
    |> Http.put(body, config)
    |> case do
      {:ok, 200, _body} -> {:ok, ""}
      error -> error
    end
  end
end
