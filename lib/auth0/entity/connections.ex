defmodule Auth0.Entity.Connections do
  @moduledoc """
  Documentation for entity of Connections.

  """

  alias Auth0.Common.Util
  alias Auth0.Entity.Connection

  defstruct total: nil,
            start: nil,
            limit: nil,
            connections: []

  @type t :: %__MODULE__{
          total: integer,
          start: integer,
          limit: integer,
          connections: list(Connection.t())
        }

  @spec from(list) :: __MODULE__.t()
  def from(value) when value |> is_list do
    %{
      total: value |> length,
      start: 0,
      limit: value |> length,
      connections: value |> Enum.map(&Connection.from/1)
    }
    |> Util.to_struct(__MODULE__)
  end

  @spec from(map) :: __MODULE__.t()
  def from(value) when value |> is_map do
    connections = value |> Util.to_struct(__MODULE__)

    if connections.connections |> is_list do
      %{
        connections
        | connections: connections.connections |> Enum.map(&Connection.from/1)
      }
    else
      connections
    end
  end
end
