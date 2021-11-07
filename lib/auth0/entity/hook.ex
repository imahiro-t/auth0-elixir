defmodule Auth0.Entity.Hook do
  @moduledoc """
  Documentation for entity of Hook.

  """

  alias Auth0.Common.Util

  defstruct triggerId: nil,
            id: nil,
            name: nil,
            enabled: nil,
            script: nil,
            dependencies: nil

  @type t :: %__MODULE__{
          triggerId: String.t(),
          id: String.t(),
          name: String.t(),
          enabled: boolean,
          script: String.t(),
          dependencies: map
        }

  @spec from(map) :: __MODULE__.t()
  def from(value) do
    value |> Util.to_struct(__MODULE__)
  end
end
