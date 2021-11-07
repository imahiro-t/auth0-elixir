defmodule Auth0.Management.Actions.Triggers.Bindings.Patch do
  @moduledoc """
  Documentation for Auth0 Management Update trigger bindings.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Actions/patch_bindings
  """

  alias Auth0.Config
  alias Auth0.Common.Util
  alias Auth0.Common.Management.Http
  alias Auth0.Entity.ActionTriggerBindings

  defmodule Params do
    defmodule Ref do
      defstruct type: nil,
                value: nil

      @type t :: %__MODULE__{
              type: String.t(),
              value: String.t()
            }
    end

    defmodule Binding do
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
  @type params :: Params.t()
  @type config :: Config.t()
  @type entity :: ActionTriggerBindings.t()
  @type response_body :: String.t()
  @type response :: {:ok, entity, response_body} | {:error, integer, term} | {:error, term}

  @doc """
  Update trigger bindings.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Actions/patch_bindings

  """
  @spec execute(endpoint, trigger_id, params, config) :: response
  def execute(endpoint, trigger_id, %Params{} = params, %Config{} = config) do
    body = params |> Util.to_map() |> Util.remove_nil()

    endpoint
    |> String.replace("{triggerId}", trigger_id)
    |> Http.patch(body, config)
    |> case do
      {:ok, 200, body} ->
        {:ok, ActionTriggerBindings.from(body |> Jason.decode!()), body}

      error ->
        error
    end
  end
end
