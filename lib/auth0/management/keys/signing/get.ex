defmodule Auth0.Management.Keys.Signing.Get do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Management.Http

  @type endpoint :: String.t()
  @type kid :: String.t()
  @type config :: Config.t()
  @type entity :: list() | map()
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

  @doc """
  Get an Application Signing Key by its key id.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Keys/get_signing_key

  """
  @spec execute(endpoint, kid, config) :: response
  def execute(endpoint, kid, %Config{} = config) do
    endpoint
    |> String.replace("{kid}", kid)
    |> Http.get(config)
    |> case do
      {:ok, 200, body} -> {:ok, body |> Jason.decode!()}
      error -> error
    end
  end
end
