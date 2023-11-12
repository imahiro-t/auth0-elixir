defmodule Auth0.Entity.ResourceServers do
  @moduledoc false

  alias Auth0.Common.Util
  alias Auth0.Entity.ResourceServer

  defstruct total: 0,
            start: 0,
            limit: 0,
            resource_servers: []

  @type t :: %__MODULE__{
          total: integer,
          start: integer,
          limit: integer,
          resource_servers: list(ResourceServer.t())
        }

  @spec from(list) :: __MODULE__.t()
  def from(value) when value |> is_list do
    %{
      total: value |> length,
      start: 0,
      limit: value |> length,
      resource_servers: value |> Enum.map(&ResourceServer.from/1)
    }
    |> Util.to_struct(__MODULE__)
  end

  @spec from(map) :: __MODULE__.t()
  def from(value) when value |> is_map do
    resource_servers = value |> Util.to_struct(__MODULE__)

    if resource_servers.resource_servers |> is_list do
      %{
        resource_servers
        | resource_servers: resource_servers.resource_servers |> Enum.map(&ResourceServer.from/1)
      }
    else
      resource_servers
    end
  end
end
