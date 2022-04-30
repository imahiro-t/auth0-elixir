defmodule Auth0.Management.Prompts.CustomText.Put do
  @moduledoc """
  Documentation for Auth0 Management Set custom text for a specific prompt.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Prompts/patch_prompts
  """

  alias Auth0.Config
  alias Auth0.Common.Util
  alias Auth0.Common.Management.Http
  alias Auth0.Entity.CustomText

  defmodule Params do
    defstruct value: nil

    @type t :: %__MODULE__{
            value: map
          }
  end

  @type endpoint :: String.t()
  @type prompt :: String.t()
  @type language :: String.t()
  @type params :: Params.t() | map
  @type config :: Config.t()
  @type entity :: CustomText.t()
  @type response_body :: String.t()
  @type response :: {:ok, entity, response_body} | {:error, integer, term} | {:error, term}

  @doc """
  Set custom text for a specific prompt.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Prompts/patch_prompts

  """
  @spec execute(endpoint, prompt, language, params, config) :: response
  def execute(endpoint, prompt, language, %Params{} = params, %Config{} = config) do
    execute(endpoint, prompt, language, params |> Util.to_map(), config)
  end

  def execute(endpoint, prompt, language, %{} = params, %Config{} = config) do
    body = params.value

    endpoint
    |> String.replace("{prompt}", prompt)
    |> String.replace("{language}", language)
    |> Http.put(body, config)
    |> case do
      {:ok, 200, body} -> {:ok, CustomText.from(body |> Jason.decode!()), body}
      error -> error
    end
  end
end
