defmodule Auth0.Management.Actions.Patch do
  @moduledoc """
  Documentation for Auth0 Management Update an action.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Actions/patch_action
  """

  alias Auth0.Config
  alias Auth0.Common.Util
  alias Auth0.Common.Management.Http
  alias Auth0.Entity.Action

  defmodule Params do
    defmodule Dependency do
      defstruct name: nil,
                version: nil

      @type t :: %__MODULE__{
              name: String.t(),
              version: String.t()
            }
    end

    defmodule Secret do
      defstruct name: nil,
                updated_at: nil

      @type t :: %__MODULE__{
              name: String.t(),
              updated_at: String.t()
            }
    end

    defstruct name: nil,
              code: nil,
              dependencies: nil,
              runtime: nil,
              secrets: nil

    @type t :: %__MODULE__{
            name: String.t(),
            code: String.t(),
            dependencies: list(Dependency.t()),
            runtime: String.t(),
            secrets: list(Secret.t())
          }
  end

  @type endpoint :: String.t()
  @type id :: String.t()
  @type params :: Params.t() | map()
  @type config :: Config.t()
  @type entity :: Action.t()
  @type response_body :: String.t()
  @type response :: {:ok, entity, response_body} | {:error, integer, term} | {:error, term}

  @doc """
  Update an action.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Actions/patch_action

  """
  @spec execute(endpoint, id, params, config) :: response
  def execute(endpoint, id, %Params{} = params, %Config{} = config) do
    execute(endpoint, id, params |> Util.to_map(), config)
  end

  def execute(endpoint, id, %{} = params, %Config{} = config) do
    body = params |> Util.remove_nil()

    endpoint
    |> String.replace("{id}", id)
    |> Http.patch(body, config)
    |> case do
      {:ok, 200, body} -> {:ok, Action.from(body |> Jason.decode!()), body}
      error -> error
    end
  end
end
