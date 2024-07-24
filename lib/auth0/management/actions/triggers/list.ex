defmodule Auth0.Management.Actions.Triggers.List do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Management.Http

  @type config :: Config.t()
  @type entity :: map()
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

  @endpoint "/api/v2/actions/triggers"

  @doc """
  Retrieve the set of triggers currently available within actions. A trigger is an extensibility point to which actions can be bound.

  ## see
  https://auth0.com/docs/api/management/v2/actions/get-triggers

  """
  @spec execute(config) :: response
  def execute(%Config{} = config) do
    @endpoint
    |> Http.get(config)
    |> case do
      {:ok, 200, body} -> {:ok, body |> Jason.decode!()}
      error -> error
    end
  end
end
