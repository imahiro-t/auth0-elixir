defmodule Auth0.Entity.Organizations do
  @moduledoc false

  alias Auth0.Common.Util
  alias Auth0.Entity.Organization

  defstruct total: 0,
            start: 0,
            limit: 0,
            organizations: []

  @type t :: %__MODULE__{
          total: integer,
          start: integer,
          limit: integer,
          organizations: list(Organization.t())
        }

  @spec from(list) :: __MODULE__.t()
  def from(value) when value |> is_list do
    %{
      total: value |> length,
      start: 0,
      limit: value |> length,
      organizations: value |> Enum.map(&Organization.from/1)
    }
    |> Util.to_struct(__MODULE__)
  end

  @spec from(map) :: __MODULE__.t()
  def from(value) when value |> is_map do
    organizations = value |> Util.to_struct(__MODULE__)

    if organizations.organizations |> is_list do
      %{
        organizations
        | organizations: organizations.organizations |> Enum.map(&Organization.from/1)
      }
    else
      organizations
    end
  end
end
