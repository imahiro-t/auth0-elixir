defmodule Auth0.Management.Organizations.DiscoveryDomains.Delete do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Util
  alias Auth0.Common.Management.Http

  @type id :: String.t()
  @type discovery_domain_id :: String.t()
  @type config :: Config.t()
  @type entity :: String.t()
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

  @endpoint "/api/v2/organizations/{id}/discovery-domains/{discovery_domain_id}"

  @doc """
  Delete an organization discovery domain.

  Remove a discovery domain from an organization. This action cannot be undone.

  ## see
  https://auth0.com/docs/api/management/v2/organizations/delete-discovery-domains-by-discovery-domain-id

  """
  @spec execute(id, discovery_domain_id, config) :: response
  def execute(id, discovery_domain_id, %Config{} = config) do
    path(id, discovery_domain_id)
    |> Http.delete(config)
    |> case do
      {:ok, 204, _body} -> {:ok, ""}
      error -> error
    end
  end

  defp path(id, discovery_domain_id) do
    @endpoint
    |> String.replace("{id}", Util.encode_path_param(id))
    |> String.replace("{discovery_domain_id}", Util.encode_path_param(discovery_domain_id))
  end
end
