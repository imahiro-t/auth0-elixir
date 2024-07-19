defmodule Auth0.Management.Actions.Triggers.Bindings.Patch do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Util
  alias Auth0.Common.Management.Http

  defmodule Params do
    @moduledoc false
    defmodule Ref do
      @moduledoc false
      defstruct type: nil,
                value: nil

      @type t :: %__MODULE__{
              type: String.t(),
              value: String.t()
            }
    end

    defmodule Binding do
      @moduledoc false
      defstruct ref: nil,
                display_name: nil

      @type t :: %__MODULE__{
              ref: Ref.t(),
              display_name: String.t()
            }
    end

    defstruct bindings: []

    @type t :: %__MODULE__{
            bindings: list(Binding.t())
          }
  end

  @type endpoint :: String.t()
  @type trigger_id :: String.t()
  @type params :: Params.t() | map()
  @type config :: Config.t()
  @type entity :: list() | map()
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

  @doc """
  Update trigger bindings.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Actions/patch_bindings

  """
  @spec execute(endpoint, trigger_id, params, config) :: response
  def execute(endpoint, trigger_id, %Params{} = params, %Config{} = config) do
    execute(endpoint, trigger_id, params |> Util.to_map(), config)
  end

  def execute(endpoint, trigger_id, %{} = params, %Config{} = config) do
    body = params |> Util.remove_nil()

    endpoint
    |> String.replace("{triggerId}", trigger_id)
    |> Http.patch(body, config)
    |> case do
      {:ok, 200, body} ->
        {:ok, body |> Jason.decode!()}

      error ->
        error
    end
  end
end
