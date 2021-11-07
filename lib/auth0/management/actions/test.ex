defmodule Auth0.Management.Actions.Test do
  @moduledoc """
  Documentation for Auth0 Management Test an Action.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Actions/post_test_action
  """

  alias Auth0.Config
  alias Auth0.Common.Util
  alias Auth0.Common.Management.Http
  alias Auth0.Entity.ActionTest

  defmodule Params do
    defstruct payload: nil

    @type t :: %__MODULE__{
            payload: map
          }
  end

  @type endpoint :: String.t()
  @type id :: String.t()
  @type params :: Params.t()
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
    body = params |> Util.to_map() |> Util.remove_nil()

    endpoint
    |> String.replace("{id}", id)
    |> Http.post(body, config)
    |> case do
      {:ok, 200, body} -> {:ok, ActionTest.from(body |> Jason.decode!()), body}
      error -> error
    end
  end
end
