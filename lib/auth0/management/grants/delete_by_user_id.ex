defmodule Auth0.Management.Grants.DeleteByUserId do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Util
  alias Auth0.Common.Management.Http

  @type params :: map()
  @type config :: Config.t()
  @type entity :: String.t()
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

  @endpoint "/api/v2/grants"

  @doc """
  Delete a grant associated with your account.

  ## see
  https://auth0.com/docs/api/management/v2/grants/delete-grants-by-user-id

  """
  @spec execute(params, config) :: response
  def execute(%{} = params, %Config{} = config) do
    params
    |> Util.convert_to_query()
    |> Util.append_query(@endpoint)
    |> Http.delete(config)
    |> case do
      {:ok, 204, _body} -> {:ok, ""}
      error -> error
    end
  end
end
