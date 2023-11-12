defmodule Auth0.Management.Organizations.Invitations.Create do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Util
  alias Auth0.Common.Management.Http
  alias Auth0.Entity.Invitation

  defmodule Params do
    @moduledoc false
    defmodule Inviter do
      @moduledoc false
      defstruct name: nil

      @type t :: %__MODULE__{
              name: String.t()
            }
    end

    defmodule Invitee do
      @moduledoc false
      defstruct email: nil

      @type t :: %__MODULE__{
              email: String.t()
            }
    end

    defstruct inviter: nil,
              invitee: nil,
              client_id: nil,
              connection_id: nil,
              app_metadata: nil,
              user_metadata: nil,
              ttl_sec: nil,
              roles: nil,
              send_invitation_email: nil

    @type t :: %__MODULE__{
            inviter: Inviter.t(),
            invitee: Invitee.t(),
            client_id: String.t(),
            connection_id: String.t(),
            app_metadata: map,
            user_metadata: map,
            ttl_sec: integer,
            roles: list(String.t()),
            send_invitation_email: boolean
          }
  end

  @type endpoint :: String.t()
  @type id :: String.t()
  @type params :: Params.t() | map
  @type config :: Config.t()
  @type entity :: Invitation.t()
  @type response_body :: String.t()
  @type response :: {:ok, entity, response_body} | {:error, integer, term} | {:error, term}

  @doc """
  Create invitations to organization.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Organizations/post_invitations

  """
  @spec execute(endpoint, id, params, config) :: response
  def execute(endpoint, id, %Params{} = params, %Config{} = config) do
    execute(endpoint, id, params |> Util.to_map(), config)
  end

  def execute(endpoint, id, %{} = params, %Config{} = config) do
    body = params |> Util.remove_nil()

    endpoint
    |> String.replace("{id}", id)
    |> Http.post(body, config)
    |> case do
      {:ok, 200, body} -> {:ok, Invitation.from(body |> Jason.decode!()), body}
      error -> error
    end
  end
end
