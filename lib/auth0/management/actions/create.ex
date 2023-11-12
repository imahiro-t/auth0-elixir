defmodule Auth0.Management.Actions.Create do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Util
  alias Auth0.Common.Management.Http
  alias Auth0.Entity.Action

  defmodule Params do
    @moduledoc false
    defmodule SupportedTrigger do
      @moduledoc false
      defstruct id: nil,
                version: nil

      @type t :: %__MODULE__{
              id: String.t(),
              version: String.t()
            }
    end

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
              supported_triggers: nil,
              code: nil,
              dependencies: nil,
              runtime: nil,
              secrets: nil

    @type t :: %__MODULE__{
            name: String.t(),
            supported_triggers: list(SupportedTrigger.t()),
            code: String.t(),
            dependencies: list(Dependency.t()),
            runtime: String.t(),
            secrets: list(Secret.t())
          }
  end

  @type endpoint :: String.t()
  @type params :: Params.t() | map()
  @type config :: Config.t()
  @type entity :: Action.t()
  @type response_body :: String.t()
  @type response :: {:ok, entity, response_body} | {:error, integer, term} | {:error, term}

  @doc """
  Create an action.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Actions/post_action

  """
  @spec execute(endpoint, params, config) :: response
  def execute(endpoint, %Params{} = params, %Config{} = config) do
    execute(endpoint, params |> Util.to_map(), config)
  end

  def execute(endpoint, %{} = params, %Config{} = config) do
    body = params |> Util.remove_nil()

    Http.post(endpoint, body, config)
    |> case do
      {:ok, 201, body} -> {:ok, Action.from(body |> Jason.decode!()), body}
      error -> error
    end
  end
end
