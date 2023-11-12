defmodule Auth0.Management.Connections.Status.Check do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Management.Http

  @type endpoint :: String.t()
  @type id :: String.t()
  @type config :: Config.t()
  @type entity :: boolean
  @type response_body :: String.t()
  @type response :: {:ok, entity, response_body} | {:error, integer, term} | {:error, term}

  @doc """
  Check connection status.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Connections/get_status

  """
  @spec execute(endpoint, id, config) :: response
  def execute(endpoint, id, %Config{} = config) do
    endpoint
    |> String.replace("{id}", id)
    |> Http.get(config)
    |> case do
      {:ok, 200, body} -> {:ok, true, body}
      {:error, 404, body} -> {:ok, false, body}
      error -> error
    end
  end
end
