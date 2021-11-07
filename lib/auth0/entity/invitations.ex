defmodule Auth0.Entity.Invitations do
  @moduledoc """
  Documentation for entity of Invitations.

  """

  alias Auth0.Common.Util
  alias Auth0.Entity.Invitation

  defstruct total: nil,
            start: nil,
            limit: nil,
            invitations: []

  @type t :: %__MODULE__{
          total: integer,
          start: integer,
          limit: integer,
          invitations: list(Invitation.t())
        }

  @spec from(list) :: __MODULE__.t()
  def from(value) when value |> is_list do
    %{
      total: value |> length,
      start: 0,
      limit: value |> length,
      invitations: value |> Enum.map(&Invitation.from/1)
    }
    |> Util.to_struct(__MODULE__)
  end

  @spec from(map) :: __MODULE__.t()
  def from(value) when value |> is_map do
    invitations = value |> Util.to_struct(__MODULE__)

    if invitations.invitations |> is_list do
      %{
        invitations
        | invitations: invitations.invitations |> Enum.map(&Invitation.from/1)
      }
    else
      invitations
    end
  end
end
