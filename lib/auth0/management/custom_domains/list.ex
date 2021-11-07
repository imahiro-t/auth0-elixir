defmodule Auth0.Management.CustomDomains.List do
  @moduledoc """
  Documentation for Auth0 Management Get custom domains configurations.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Custom_Domains/get_custom_domains
  """

  alias Auth0.Config
  alias Auth0.Common.Management.Http
  alias Auth0.Entity.CustomDomains

  @type endpoint :: String.t()
  @type config :: Config.t()
  @type entity :: CustomDomains.t()
  @type response_body :: String.t()
  @type response :: {:ok, entity, response_body} | {:error, integer, term} | {:error, term}

  @doc """
  Get custom domains configurations.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Custom_Domains/get_custom_domains

  """
  @spec execute(endpoint, config) :: response
  def execute(endpoint, %Config{} = config) do
    endpoint
    |> Http.get(config)
    |> case do
      {:ok, 200, body} -> {:ok, CustomDomains.from(body |> Jason.decode!()), body}
      error -> error
    end
  end
end
