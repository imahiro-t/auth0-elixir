defmodule Auth0.Management.Branding.Phone.Templates.Delete do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Management.Http

  @type id :: String.t()
  @type config :: Config.t()
  @type entity :: map()
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

  @endpoint "/api/v2/branding/phone/templates/{id}"

  @doc """
  Delete a phone notification template

  ## see
  https://auth0.com/docs/api/management/v2/branding/delete-phone-template

  """
  @spec execute(id, config) :: response
  def execute(id, %Config{} = config) do
    @endpoint
    |> String.replace("{id}", id)
    |> Http.delete(config)
    |> case do
      {:ok, 204, body} -> {:ok, body |> Jason.decode!()}
      error -> error
    end
  end
end
