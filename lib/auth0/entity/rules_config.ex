defmodule Auth0.Entity.RulesConfig do
  @moduledoc """
  Documentation for entity of RulesConfig.

  """

  alias Auth0.Common.Util

  defstruct key: nil,
            value: nil

  @type t :: %__MODULE__{
          key: String.t(),
          value: String.t()
        }

  @spec from(map) :: __MODULE__.t()
  def from(value) do
    value |> Util.to_struct(__MODULE__)
  end
end
