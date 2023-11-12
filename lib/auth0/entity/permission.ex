defmodule Auth0.Entity.Permission do
  @moduledoc false

  alias Auth0.Common.Util

  defstruct resource_server_identifier: nil,
            permission_name: nil,
            resource_server_name: nil,
            description: nil

  @type t :: %__MODULE__{
          resource_server_identifier: String.t(),
          permission_name: String.t(),
          resource_server_name: String.t(),
          description: String.t()
        }

  @spec from(map) :: __MODULE__.t()
  def from(value) do
    value |> Util.to_struct(__MODULE__)
  end
end
