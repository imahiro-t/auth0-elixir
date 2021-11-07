defmodule Auth0.Management.Organizations.Name.Get do
  @moduledoc """
  Documentation for Auth0 Management Get organization.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Organizations/get_organizations_by_id
  """

  alias Auth0.Config
  alias Auth0.Common.Management.Http
  alias Auth0.Entity.Organization

  @type endpoint :: String.t()
  @type name :: String.t()
  @type config :: Config.t()
  @type entity :: Organization.t()
  @type response_body :: String.t()
  @type response :: {:ok, entity, response_body} | {:error, integer, term} | {:error, term}

  @doc """
  Get organization.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Organizations/get_organizations_by_id

  """
  @spec execute(endpoint, name, config) :: response
  def execute(endpoint, name, %Config{} = config) do
    endpoint
    |> String.replace("{name}", name)
    |> Http.get(config)
    |> case do
      {:ok, 200, body} -> {:ok, Organization.from(body |> Jason.decode!()), body}
      error -> error
    end
  end
end
