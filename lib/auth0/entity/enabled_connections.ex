defmodule Auth0.Entity.EnabledConnections do
  @moduledoc """
  Documentation for entity of EnabledConnections.

  """

  alias Auth0.Common.Util
  alias Auth0.Entity.EnabledConnection

  defstruct total: nil,
            start: nil,
            limit: nil,
            enabled_connections: []

  @type t :: %__MODULE__{
          total: integer,
          start: integer,
          limit: integer,
          enabled_connections: list(EnabledConnection.t())
        }

  @spec from(list) :: __MODULE__.t()
  def from(value) when value |> is_list do
    %{
      total: value |> length,
      start: 0,
      limit: value |> length,
      enabled_connections: value |> Enum.map(&EnabledConnection.from/1)
    }
    |> Util.to_struct(__MODULE__)
  end

  @spec from(map) :: __MODULE__.t()
  def from(value) when value |> is_map do
    enabled_connections = value |> Util.to_struct(__MODULE__)

    if enabled_connections.enabled_connections |> is_list do
      %{
        enabled_connections
        | enabled_connections:
            enabled_connections.enabled_connections |> Enum.map(&EnabledConnection.from/1)
      }
    else
      enabled_connections
    end
  end
end
