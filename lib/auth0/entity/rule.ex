defmodule Auth0.Entity.Rule do
  @moduledoc """
  Documentation for entity of Rule.

  """

  alias Auth0.Common.Util

  defstruct name: nil,
            id: nil,
            enabled: nil,
            script: nil,
            order: nil,
            stage: nil

  @type t :: %__MODULE__{
          name: String.t(),
          id: String.t(),
          enabled: boolean,
          script: String.t(),
          order: integer,
          stage: String.t()
        }

  @spec from(map) :: __MODULE__.t()
  def from(value) do
    value |> Util.to_struct(__MODULE__)
  end
end
