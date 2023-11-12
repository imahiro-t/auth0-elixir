defmodule Auth0.Entity.Roles do
  @moduledoc false

  alias Auth0.Common.Util
  alias Auth0.Entity.Role

  defstruct total: 0,
            start: 0,
            limit: 0,
            roles: []

  @type t :: %__MODULE__{
          total: integer,
          start: integer,
          limit: integer,
          roles: list(Role.t())
        }

  @spec from(list) :: __MODULE__.t()
  def from(value) when value |> is_list do
    %{
      total: value |> length,
      start: 0,
      limit: value |> length,
      roles: value |> Enum.map(&Role.from/1)
    }
    |> Util.to_struct(__MODULE__)
  end

  @spec from(map) :: __MODULE__.t()
  def from(value) when value |> is_map do
    roles = value |> Util.to_struct(__MODULE__)

    if roles.roles |> is_list do
      %{roles | roles: roles.roles |> Enum.map(&Role.from/1)}
    else
      roles
    end
  end
end
