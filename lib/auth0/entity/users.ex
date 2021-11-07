defmodule Auth0.Entity.Users do
  @moduledoc """
  Documentation for entity of Users.

  """

  alias Auth0.Common.Util
  alias Auth0.Entity.User

  defstruct length: 0,
            total: 0,
            start: 0,
            limit: 0,
            users: []

  @type t :: %__MODULE__{
          length: integer,
          total: integer,
          start: integer,
          limit: integer,
          users: list(User.t())
        }

  @spec from(list) :: __MODULE__.t()
  def from(value) when value |> is_list do
    %{
      length: value |> length,
      total: value |> length,
      start: 0,
      limit: value |> length,
      users: value |> Enum.map(&User.from/1)
    }
    |> Util.to_struct(__MODULE__)
  end

  @spec from(map) :: __MODULE__.t()
  def from(value) when value |> is_map do
    users = value |> Util.to_struct(__MODULE__)

    if users.users |> is_list do
      %{users | users: users.users |> Enum.map(&User.from/1)}
    else
      users
    end
  end
end
