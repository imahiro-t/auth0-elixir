defmodule Auth0.Management.VerifiableCredentials.Delete do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Management.Http

  @type id :: String.t()
  @type config :: Config.t()
  @type entity :: String.t()
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

  @endpoint "/api/v2/verifiable-credentials/verification/templates/{id}"

  @doc """
  Delete a verifiable credential verification template.

  ## see
  https://auth0.com/docs/api/management/v2/verifiable-credentials/delete-vc-templates-by-id
  """
  @spec execute(id, config) :: response
  def execute(id, %Config{} = config) do
    @endpoint
    |> String.replace("{id}", id)
    |> Http.delete(config)
    |> case do
      {:ok, 204, _body} -> {:ok, ""}
      error -> error
    end
  end
end
