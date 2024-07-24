defmodule Auth0.Management.Guardian.Factors.Put do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Util
  alias Auth0.Common.Management.Http

  @type name :: String.t()
  @type params :: map()
  @type config :: Config.t()
  @type entity :: map()
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

  @endpoint "/api/v2/guardian/factors/{name}"

  @doc """
  Update the status (i.e., enabled or disabled) of a specific multi-factor authentication factor.

  ## see
  https://auth0.com/docs/api/management/v2/guardian/put-factors-by-name

  """
  def execute(name, %{} = params, %Config{} = config) do
    body = params |> Util.remove_nil()

    @endpoint
    |> String.replace("{name}", name)
    |> Http.put(body, config)
    |> case do
      {:ok, 200, body} -> {:ok, body |> Jason.decode!()}
      error -> error
    end
  end
end
