defmodule Auth0.Management.CustomDomains.Verify do
  @moduledoc """
  Documentation for Auth0 Management Verify a custom domain.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Custom_Domains/post_verify
  """

  alias Auth0.Config
  alias Auth0.Common.Management.Http
  alias Auth0.Entity.CustomDomain

  @type endpoint :: String.t()
  @type id :: String.t()
  @type config :: Config.t()
  @type entity :: CustomDomain.t()
  @type response_body :: String.t()
  @type response :: {:ok, entity, response_body} | {:error, integer, term} | {:error, term}

  @doc """
  Verify a custom domain.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Custom_Domains/post_verify

  """
  @spec execute(endpoint, id, config) :: response
  def execute(endpoint, id, %Config{} = config) do
    endpoint
    |> String.replace("{id}", id)
    |> Http.post(%{}, config)
    |> case do
      {:ok, 200, body} -> {:ok, CustomDomain.from(body |> Jason.decode!()), body}
      error -> error
    end
  end
end
