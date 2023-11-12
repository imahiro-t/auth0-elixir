defmodule Auth0.Entity.LogStream do
  @moduledoc false

  alias Auth0.Common.Util

  defstruct id: nil,
            name: nil,
            status: nil,
            type: nil,
            sink: nil

  @type t :: %__MODULE__{
          id: String.t(),
          name: String.t(),
          status: String.t(),
          type: String.t(),
          sink: map
        }

  @spec from(map) :: __MODULE__.t()
  def from(value) do
    value |> Util.to_struct(__MODULE__)
  end
end
