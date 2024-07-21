defmodule Auth0.Management.Actions.Delete do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Util
  alias Auth0.Common.Management.Http

  @type id :: String.t()
  @type params :: map()
  @type config :: Config.t()
  @type entity :: String.t()
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

  @endpoint "/api/v2/actions/actions/{id}"

  @doc """
  Deletes an action and all of its associated versions. An action must be unbound from all triggers before it can be deleted.

  ## see
  https://auth0.com/docs/api/management/v2/actions/delete-action

  """
  @spec execute(id, params, config) :: response
  def execute(id, %{} = params, %Config{} = config) do
    params
    |> Util.convert_to_query()
    |> Util.append_query(@endpoint |> String.replace("{id}", id))
    |> Http.delete(config)
    |> case do
      {:ok, 204, _body} -> {:ok, ""}
      error -> error
    end
  end
end
