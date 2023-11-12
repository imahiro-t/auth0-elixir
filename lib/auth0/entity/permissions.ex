defmodule Auth0.Entity.Permissions do
  @moduledoc false

  alias Auth0.Common.Util
  alias Auth0.Entity.Permission

  defstruct total: 0,
            start: 0,
            limit: 0,
            permissions: []

  @type t :: %__MODULE__{
          total: integer,
          start: integer,
          limit: integer,
          permissions: list(Permission.t())
        }

  @spec from(list) :: __MODULE__.t()
  def from(value) when value |> is_list do
    %{
      total: value |> length,
      start: 0,
      limit: value |> length,
      permissions: value |> Enum.map(&Permission.from/1)
    }
    |> Util.to_struct(__MODULE__)
  end

  @spec from(map) :: __MODULE__.t()
  def from(value) when value |> is_map do
    permissions = value |> Util.to_struct(__MODULE__)

    if permissions.permissions |> is_list do
      %{
        permissions
        | permissions: permissions.permissions |> Enum.map(&Permission.from/1)
      }
    else
      permissions
    end
  end
end
