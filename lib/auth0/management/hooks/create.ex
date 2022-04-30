defmodule Auth0.Management.Hooks.Create do
  @moduledoc """
  Documentation for Auth0 Management Create a hook.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Hooks/post_hooks
  """

  alias Auth0.Config
  alias Auth0.Common.Util
  alias Auth0.Common.Management.Http
  alias Auth0.Entity.Hook

  defmodule Params do
    defstruct name: nil,
              enabled: nil,
              script: nil,
              dependencies: nil,
              triggerId: nil

    @type t :: %__MODULE__{
            name: String.t(),
            enabled: boolean,
            script: String.t(),
            dependencies: map,
            triggerId: String.t()
          }
  end

  @type endpoint :: String.t()
  @type params :: Params.t() | map
  @type config :: Config.t()
  @type entity :: Hook.t()
  @type response_body :: String.t()
  @type response :: {:ok, entity, response_body} | {:error, integer, term} | {:error, term}

  @doc """
  Create a hook.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Hooks/post_hooks

  """
  @spec execute(endpoint, params, config) :: response
  def execute(endpoint, %Params{} = params, %Config{} = config) do
    execute(endpoint, params |> Util.to_map(), config)
  end

  def execute(endpoint, %{} = params, %Config{} = config) do
    body = params |> Util.remove_nil()

    Http.post(endpoint, body, config)
    |> case do
      {:ok, 201, body} -> {:ok, Hook.from(body |> Jason.decode!()), body}
      error -> error
    end
  end
end
