defmodule Auth0.Entity.Invitation do
  @moduledoc """
  Documentation for entity of Invitation.

  """
  defmodule Inviter do
    @moduledoc """
    Documentation for entity of Invitation Inviter.

    """

    alias Auth0.Common.Util

    defstruct name: nil

    @type t :: %__MODULE__{
            name: String.t()
          }

    @spec from(map) :: __MODULE__.t()
    def from(value) do
      value |> Util.to_struct(__MODULE__)
    end
  end

  defmodule Invitee do
    @moduledoc """
    Documentation for entity of Invitation Invitee.

    """

    alias Auth0.Common.Util

    defstruct email: nil

    @type t :: %__MODULE__{
            email: String.t()
          }

    @spec from(map) :: __MODULE__.t()
    def from(value) do
      value |> Util.to_struct(__MODULE__)
    end
  end

  alias Auth0.Common.Util

  defstruct id: nil,
            organization_id: nil,
            inviter: nil,
            invitee: nil,
            invitation_url: nil,
            created_at: nil,
            expires_at: nil,
            client_id: nil,
            connection_id: nil,
            app_metadata: nil,
            user_metadata: nil,
            roles: nil,
            ticket_id: nil

  @type t :: %__MODULE__{
          id: String.t(),
          organization_id: String.t(),
          inviter: Inviter.t(),
          invitee: Invitee.t(),
          invitation_url: String.t(),
          created_at: String.t(),
          expires_at: String.t(),
          client_id: String.t(),
          connection_id: String.t(),
          app_metadata: map,
          user_metadata: map,
          roles: list(String.t()),
          ticket_id: String.t()
        }

  @spec from(map) :: __MODULE__.t()
  def from(value) do
    invitation = value |> Util.to_struct(__MODULE__)

    %{
      invitation
      | inviter:
          if(invitation.inviter |> is_map,
            do: invitation.inviter |> Inviter.from(),
            else: nil
          ),
        invitee:
          if(invitation.invitee |> is_map,
            do: invitation.invitee |> Invitee.from(),
            else: nil
          )
    }
  end
end
