defmodule Auth0.Management.CustomDomains.Test do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Util
  alias Auth0.Common.Management.Http

  @type id :: String.t()
  @type config :: Config.t()
  @type entity :: map()
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

  @endpoint "/api/v2/custom-domains/{id}/test"

  @doc """
  Test a custom domain.

  Run the test process on a custom domain.

  ## see
  https://auth0.com/docs/api/management/v2/custom-domains/post-test-domain

  """
  @spec execute(id, config) :: response
  def execute(id, %Config{} = config) do
    path(id)
    |> Http.post(%{}, config)
    |> case do
      {:ok, 200, body} -> {:ok, body |> Jason.decode!()}
      error -> error
    end
  end

  defp path(id) do
    @endpoint
    |> String.replace("{id}", Util.encode_path_param(id))
  end
end
