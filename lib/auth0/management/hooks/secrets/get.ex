defmodule Auth0.Management.Hooks.Secrets.Get do
  @moduledoc """
  Documentation for Auth0 Management Get hook secrets.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Hooks/get_secrets
  """

  alias Auth0.Config
  alias Auth0.Common.Management.Http
  alias Auth0.Entity.HookSecret

  @type endpoint :: String.t()
  @type id :: String.t()
  @type config :: Config.t()
  @type entity :: HookSecret.t()
  @type response_body :: String.t()
  @type response :: {:ok, entity, response_body} | {:error, integer, term} | {:error, term}

  @doc """
  Get hook secrets.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Hooks/get_secrets

  """
  @spec execute(endpoint, id, config) :: response
  def execute(endpoint, id, %Config{} = config) do
    endpoint
    |> String.replace("{id}", id)
    |> Http.get(config)
    |> case do
      {:ok, 200, body} -> {:ok, HookSecret.from(body |> Jason.decode!()), body}
      error -> error
    end
  end
end
