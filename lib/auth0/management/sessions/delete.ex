defmodule Auth0.Management.Sessions.Delete do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Management.Http

  @type endpoint :: String.t()
  @type id :: String.t()
  @type config :: Config.t()
  @type entity :: String.t()
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

  @doc """
  Delete a session by ID.

  ## see
  https://auth0.com/docs/api/management/v2/sessions/delete-session

  """
  @spec execute(endpoint, id, config) :: response
  def execute(endpoint, id, %Config{} = config) do
    endpoint
    |> String.replace("{id}", id)
    |> Http.delete(config)
    |> case do
      {:ok, 202, _body} -> {:ok, ""}
      error -> error
    end
  end
end
