defmodule Auth0.Management.ResourceServers.Patch do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Util
  alias Auth0.Common.Management.Http
  alias Auth0.Entity.ResourceServer

  defmodule Params do
    @moduledoc false
    defstruct name: nil,
              scopes: nil,
              signing_alg: nil,
              signing_secret: nil,
              allow_offline_access: nil,
              skip_consent_for_verifiable_first_party_clients: nil,
              token_lifetime: nil,
              token_lifetime_for_web: nil,
              enforce_policies: nil,
              client: nil

    @type t :: %__MODULE__{
            name: String.t(),
            scopes: list(String.t()),
            signing_alg: String.t(),
            signing_secret: String.t(),
            allow_offline_access: boolean,
            skip_consent_for_verifiable_first_party_clients: boolean,
            token_lifetime: integer,
            token_lifetime_for_web: integer,
            enforce_policies: boolean,
            client: map
          }
  end

  @type endpoint :: String.t()
  @type id :: String.t()
  @type params :: Params.t() | map
  @type config :: Config.t()
  @type entity :: ResourceServer.t()
  @type response_body :: String.t()
  @type response :: {:ok, entity, response_body} | {:error, integer, term} | {:error, term}

  @doc """
  Update a resource server.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Resource_Servers/get_resource_servers_by_id

  """
  @spec execute(endpoint, id, params, config) :: response
  def execute(endpoint, id, %Params{} = params, %Config{} = config) do
    execute(endpoint, id, params |> Util.to_map(), config)
  end

  def execute(endpoint, id, %{} = params, %Config{} = config) do
    body = params |> Util.remove_nil()

    endpoint
    |> String.replace("{id}", id)
    |> Http.patch(body, config)
    |> case do
      {:ok, 201, body} -> {:ok, ResourceServer.from(body |> Jason.decode!()), body}
      error -> error
    end
  end
end
