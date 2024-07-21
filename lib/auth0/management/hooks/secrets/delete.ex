defmodule Auth0.Management.Hooks.Secrets.Delete do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Management.Http

  @type id :: String.t()
  @type params :: map()
  @type config :: Config.t()
  @type entity :: String.t()
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

  @endpoint "/api/v2/hooks/{id}/secrets"

  @doc """
  Delete one or more existing secrets for a given hook. Accepts an array of secret names to delete.

  ## see
  https://auth0.com/docs/api/management/v2/hooks/delete-secrets

  """
  @spec execute(id, params, config) :: response
  def execute(id, %{} = params, %Config{} = config) do
    body = params.value

    @endpoint
    |> String.replace("{id}", id)
    |> Http.delete(body, config)
    |> case do
      {:ok, 204, _body} -> {:ok, ""}
      error -> error
    end
  end
end
