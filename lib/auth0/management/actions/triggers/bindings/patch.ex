defmodule Auth0.Management.Actions.Triggers.Bindings.Patch do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Util
  alias Auth0.Common.Management.Http

  @type trigger_id :: String.t()
  @type params :: map()
  @type config :: Config.t()
  @type entity :: list() | map()
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

  @endpoint "/api/v2/actions/triggers/{triggerId}/bindings"

  @doc """
  Update the actions that are bound (i.e. attached) to a trigger. Once an action is created and deployed, it must be attached (i.e. bound) to a trigger so that it will be executed as part of a flow. The order in which the actions are provided will determine the order in which they are executed.

  ## see
  https://auth0.com/docs/api/management/v2/actions/patch-bindings

  """
  @spec execute(trigger_id, params, config) :: response
  def execute(trigger_id, %{} = params, %Config{} = config) do
    body = params |> Util.remove_nil()

    @endpoint
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
