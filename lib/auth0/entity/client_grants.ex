defmodule Auth0.Entity.ClientGrants do
  @moduledoc false

  alias Auth0.Common.Util
  alias Auth0.Entity.ClientGrant

  defstruct total: nil,
            start: nil,
            limit: nil,
            client_grants: []

  @type t :: %__MODULE__{
          total: integer,
          start: integer,
          limit: integer,
          client_grants: list(ClientGrant.t())
        }

  @spec from(list) :: __MODULE__.t()
  def from(value) when value |> is_list do
    %{
      total: value |> length,
      start: 0,
      limit: value |> length,
      client_grants: value |> Enum.map(&ClientGrant.from/1)
    }
    |> Util.to_struct(__MODULE__)
  end

  @spec from(map) :: __MODULE__.t()
  def from(value) when value |> is_map do
    client_grants = value |> Util.to_struct(__MODULE__)

    if client_grants.client_grants |> is_list do
      %{
        client_grants
        | client_grants: client_grants.client_grants |> Enum.map(&ClientGrant.from/1)
      }
    else
      client_grants
    end
  end
end
