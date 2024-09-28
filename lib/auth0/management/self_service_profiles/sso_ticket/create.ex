defmodule Auth0.Management.SelfServiceProfiles.SsoTicket.Create do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Util
  alias Auth0.Common.Management.Http

  @type id :: String.t()
  @type params :: map()
  @type config :: Config.t()
  @type entity :: map()
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

  @endpoint "/api/v2/self-service-profiles/{id}/sso-ticket"

  @doc """
  Creates an sso-access ticket to initiate the Self Service SSO Flow using a self-service profile.

  ## see
  https://auth0.com/docs/api/management/v2/self-service-profiles/post-sso-ticket

  """
  @spec execute(id, params, config) :: response
  def execute(id, %{} = params, %Config{} = config) do
    body = params |> Util.remove_nil()

    @endpoint
    |> String.replace("{id}", id)
    |> Http.post(body, config)
    |> case do
      {:ok, 201, body} -> {:ok, body |> Jason.decode!()}
      error -> error
    end
  end
end
