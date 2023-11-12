defmodule Auth0.Entity.Clients do
  @moduledoc false

  alias Auth0.Common.Util
  alias Auth0.Entity.Client

  defstruct total: nil,
            start: nil,
            limit: nil,
            clients: []

  @type t :: %__MODULE__{
          total: integer,
          start: integer,
          limit: integer,
          clients: list(Client.t())
        }

  @spec from(list) :: __MODULE__.t()
  def from(value) when value |> is_list do
    %{
      total: value |> length,
      start: 0,
      limit: value |> length,
      clients: value |> Enum.map(&Client.from/1)
    }
    |> Util.to_struct(__MODULE__)
  end

  @spec from(map) :: __MODULE__.t()
  def from(value) when value |> is_map do
    clients = value |> Util.to_struct(__MODULE__)

    if clients.clients |> is_list do
      %{
        clients
        | clients: clients.clients |> Enum.map(&Client.from/1)
      }
    else
      clients
    end
  end
end
