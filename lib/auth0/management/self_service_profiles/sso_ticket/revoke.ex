defmodule Auth0.Management.SelfServiceProfiles.SsoTicket.Revoke do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Util
  alias Auth0.Common.Management.Http

  @type profile_id :: String.t()
  @type id :: String.t()
  @type config :: Config.t()
  @type entity :: String.t()
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

  @endpoint "/api/v2/self-service-profiles/{profileId}/sso-ticket/{id}/revoke"

  @doc """
  Revoke a Self-Service Enterprise Configuration access ticket.

  Revokes a Self-Service Enterprise Configuration access ticket and invalidates associated sessions. The ticket will no longer be accepted to initiate a Self-Service Enterprise Configuration session. If any users have already started a session through this ticket, their session will be terminated. Clients should expect a `202 Accepted` response upon successful processing, indicating that the request has been acknowledged and that the revocation is underway but may not be fully completed at the ...

  ## see
  https://auth0.com/docs/api/management/v2/self-service-profiles/post-revoke

  """
  @spec execute(profile_id, id, config) :: response
  def execute(profile_id, id, %Config{} = config) do
    Util.build_path(@endpoint, profileId: profile_id, id: id)
    |> Http.post(%{}, config)
    |> case do
      {:ok, 202, _body} -> {:ok, ""}
      error -> error
    end
  end
end
