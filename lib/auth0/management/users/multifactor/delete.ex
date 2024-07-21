defmodule Auth0.Management.Users.Multifactor.Delete do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Management.Http

  @type id :: String.t()
  @type params :: map()
  @type config :: Config.t()
  @type entity :: String.t()
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

  @endpoint "/api/v2/users/{id}/multifactor/{provider}"

  @doc """
  Remove a multifactor authentication configuration from a user's account. This forces the user to manually reconfigure the multi-factor provider.

  ## see
  https://auth0.com/docs/api/management/v2/users/delete-multifactor-by-provider

  """
  @spec execute(id, params, config) :: response
  def execute(id, %{} = params, %Config{} = config) do
    @endpoint
    |> String.replace("{id}", id)
    |> String.replace("{provider}", params.provider)
    |> Http.delete(config)
    |> case do
      {:ok, 204, _body} -> {:ok, ""}
      error -> error
    end
  end
end
