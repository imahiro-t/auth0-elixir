defmodule Auth0.Entity.ActionStatus do
  @moduledoc false

  alias Auth0.Common.Util

  defstruct status: nil

  @type t :: %__MODULE__{
          status: String.t()
        }

  @spec from(map) :: __MODULE__.t()
  def from(value) do
    value |> Util.to_struct(__MODULE__)
  end
end
