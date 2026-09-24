defmodule Auth0.Management.Flows.Delete do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Util
  alias Auth0.Common.Management.Http

  @type id :: String.t()
  @type config :: Config.t()
  @type entity :: String.t()
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

  @endpoint "/api/v2/flows/{id}"

  @doc """
  Delete a flow.

  ## see
  https://auth0.com/docs/api/management/v2/flows/delete-flows-by-id

  """
  @spec execute(id, config) :: response
  def execute(id, %Config{} = config) do
    path(id)
    |> Http.delete(config)
    |> case do
      {:ok, 204, _body} -> {:ok, ""}
      error -> error
    end
  end

  defp path(id) do
    @endpoint
    |> String.replace("{id}", Util.encode_path_param(id))
  end
end
