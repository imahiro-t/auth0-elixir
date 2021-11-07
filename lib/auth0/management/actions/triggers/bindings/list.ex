defmodule Auth0.Management.Actions.Triggers.Bindings.List do
  @moduledoc """
  Documentation for Auth0 Management Get trigger bindingsGet trigger bindings.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Actions/get_bindings
  """

  alias Auth0.Config
  alias Auth0.Common.Util
  alias Auth0.Common.Management.Http
  alias Auth0.Entity.ActionTriggerBindings

  defmodule Params do
    defstruct page: nil,
              per_page: nil

    @type t :: %__MODULE__{
            page: integer,
            per_page: integer
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
  Get trigger bindingsGet trigger bindings.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Actions/get_bindings

  """
  @spec execute(endpoint, trigger_id, params, config) :: response
  def execute(endpoint, trigger_id, %Params{} = params, %Config{} = config) do
    params
    |> Util.to_map()
    |> Util.convert_to_query()
    |> Util.append_query(endpoint |> String.replace("{triggerId}", trigger_id))
    |> Http.get(config)
    |> case do
      {:ok, 200, body} ->
        {:ok, ActionTriggerBindings.from(body |> Jason.decode!()), body}

      error ->
        error
    end
  end
end
