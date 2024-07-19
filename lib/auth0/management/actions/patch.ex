defmodule Auth0.Management.Actions.Patch do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Util
  alias Auth0.Common.Management.Http

  defmodule Params do
    @moduledoc false
    defmodule Dependency do
      @moduledoc false
      defstruct name: nil,
                version: nil

      @type t :: %__MODULE__{
              name: String.t(),
              version: String.t()
            }
    end

    defmodule Secret do
      @moduledoc false
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
  @type entity :: list() | map()
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

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
      {:ok, 200, body} -> {:ok, body |> Jason.decode!()}
      error -> error
    end
  end
end
