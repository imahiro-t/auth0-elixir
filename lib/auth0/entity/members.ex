defmodule Auth0.Entity.Members do
  @moduledoc """
  Documentation for entity of Members.

  """

  alias Auth0.Common.Util
  alias Auth0.Entity.Member

  defstruct total: 0,
            start: 0,
            limit: 0,
            members: []

  @type t :: %__MODULE__{
          total: integer,
          start: integer,
          limit: integer,
          members: list(Member.t())
        }

  @spec from(list) :: __MODULE__.t()
  def from(value) when value |> is_list do
    %{
      total: value |> length,
      start: 0,
      limit: value |> length,
      members: value |> Enum.map(&Member.from/1)
    }
    |> Util.to_struct(__MODULE__)
  end

  @spec from(map) :: __MODULE__.t()
  def from(value) when value |> is_map do
    members = value |> Util.to_struct(__MODULE__)

    if members.members |> is_list do
      %{
        members
        | members: members.members |> Enum.map(&Member.from/1)
      }
    else
      members
    end
  end
end
