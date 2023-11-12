defmodule Auth0.Entity.Role do
  @moduledoc false

  alias Auth0.Common.Util

  defstruct id: nil,
            name: nil,
            description: nil

  @type t :: %__MODULE__{
          id: String.t(),
          name: String.t(),
          description: String.t()
        }

  @spec from(map) :: __MODULE__.t()
  def from(value) do
    value |> Util.to_struct(__MODULE__)
  end
end
