defmodule Auth0.Entity.Grants do
  @moduledoc """
  Documentation for entity of Grants.

  """

  alias Auth0.Common.Util
  alias Auth0.Entity.Grant

  defstruct total: nil,
            start: nil,
            limit: nil,
            grants: []

  @type t :: %__MODULE__{
          total: integer,
          start: integer,
          limit: integer,
          grants: list(Grant.t())
        }

  @spec from(list) :: __MODULE__.t()
  def from(value) when value |> is_list do
    %{
      total: value |> length,
      start: 0,
      limit: value |> length,
      grants: value |> Enum.map(&Grant.from/1)
    }
    |> Util.to_struct(__MODULE__)
  end

  @spec from(map) :: __MODULE__.t()
  def from(value) when value |> is_map do
    grants = value |> Util.to_struct(__MODULE__)

    if grants.grants |> is_list do
      %{
        grants
        | grants: grants.grants |> Enum.map(&Grant.from/1)
      }
    else
      grants
    end
  end
end
