defmodule Auth0.Management.Prompts.Patch do
  @moduledoc """
  Documentation for Auth0 Management Update prompts settings.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Prompts/patch_prompts
  """

  alias Auth0.Config
  alias Auth0.Common.Util
  alias Auth0.Common.Management.Http
  alias Auth0.Entity.Prompt

  defmodule Params do
    defstruct universal_login_experience: nil,
              identifier_first: nil,
              webauthn_platform_first_factor: nil

    @type t :: %__MODULE__{
            universal_login_experience: String.t(),
            identifier_first: boolean,
            webauthn_platform_first_factor: boolean
          }
  end

  @type endpoint :: String.t()
  @type params :: Params.t()
  @type config :: Config.t()
  @type entity :: Prompt.t()
  @type response_body :: String.t()
  @type response :: {:ok, entity, response_body} | {:error, integer, term} | {:error, term}

  @doc """
  Update prompts settings.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Prompts/patch_prompts

  """
  @spec execute(endpoint, params, config) :: response
  def execute(endpoint, %Params{} = params, %Config{} = config) do
    body = params |> Util.to_map() |> Util.remove_nil()

    endpoint
    |> Http.patch(body, config)
    |> case do
      {:ok, 200, body} -> {:ok, Prompt.from(body |> Jason.decode!()), body}
      error -> error
    end
  end
end
