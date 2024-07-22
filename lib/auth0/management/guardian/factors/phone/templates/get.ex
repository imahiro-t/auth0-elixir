defmodule Auth0.Management.Guardian.Factors.Phone.Templates.Get do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Management.Http

  @type config :: Config.t()
  @type entity :: list() | map()
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

  @endpoint "/api/v2/guardian/factors/phone/templates"

  @doc """
  Retrieve details of the multi-factor authentication enrollment and verification templates for phone-type factors available in your tenant.

  ## see
  https://auth0.com/docs/api/management/v2/guardian/get-factor-phone-templates

  """
  @spec execute(config) :: response
  def execute(%Config{} = config) do
    @endpoint
    |> Http.get(config)
    |> case do
      {:ok, 200, body} ->
        {:ok, body |> Jason.decode!()}

      error ->
        error
    end
  end
end
