defmodule Auth0.Entity.Connection do
  @moduledoc false

  alias Auth0.Common.Util

  defstruct name: nil,
            display_name: nil,
            options: nil,
            id: nil,
            strategy: nil,
            realms: nil,
            is_domain_connection: nil,
            metadata: nil,
            enabled_clients: nil

  @type t :: %__MODULE__{
          name: String.t(),
          display_name: String.t(),
          options: map,
          id: String.t(),
          strategy: String.t(),
          realms: list(String.t()),
          is_domain_connection: boolean,
          metadata: map,
          enabled_clients: list(String.t())
        }

  @spec from(map) :: __MODULE__.t()
  def from(value) do
    value |> Util.to_struct(__MODULE__)
  end
end
