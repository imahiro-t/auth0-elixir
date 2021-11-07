defmodule Auth0.Management.Prompts.Get do
  @moduledoc """
  Documentation for Auth0 Management Get prompts settings.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Prompts/get_prompts
  """

  alias Auth0.Config
  alias Auth0.Common.Management.Http
  alias Auth0.Entity.Prompt

  @type endpoint :: String.t()
  @type config :: Config.t()
  @type entity :: Prompt.t()
  @type response_body :: String.t()
  @type response :: {:ok, entity, response_body} | {:error, integer, term} | {:error, term}

  @doc """
  Get prompts settings.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Prompts/get_prompts

  """
  @spec execute(endpoint, config) :: response
  def execute(endpoint, %Config{} = config) do
    endpoint
    |> Http.get(config)
    |> case do
      {:ok, 200, body} -> {:ok, Prompt.from(body |> Jason.decode!()), body}
      error -> error
    end
  end
end
