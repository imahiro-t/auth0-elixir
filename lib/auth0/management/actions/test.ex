defmodule Auth0.Management.Actions.Test do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Util
  alias Auth0.Common.Management.Http
  alias Auth0.Entity.ActionTest

  defmodule Params do
    @moduledoc false
    defstruct payload: nil

    @type t :: %__MODULE__{
            payload: map
          }
  end

  @type endpoint :: String.t()
  @type id :: String.t()
  @type params :: Params.t() | map()
  @type config :: Config.t()
  @type entity :: ActionTest.t()
  @type response_body :: String.t()
  @type response :: {:ok, entity, response_body} | {:error, integer, term} | {:error, term}

  @doc """
  Test an Action.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Actions/post_test_action

  """
  @spec execute(endpoint, id, params, config) :: response
  def execute(endpoint, id, %Params{} = params, %Config{} = config) do
    execute(endpoint, id, params |> Util.to_map(), config)
  end

  def execute(endpoint, id, %{} = params, %Config{} = config) do
    body = params |> Util.remove_nil()

    endpoint
    |> String.replace("{id}", id)
    |> Http.post(body, config)
    |> case do
      {:ok, 200, body} -> {:ok, ActionTest.from(body |> Jason.decode!()), body}
      error -> error
    end
  end
end
