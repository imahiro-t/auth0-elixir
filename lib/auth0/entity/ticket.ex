defmodule Auth0.Entity.Ticket do
  @moduledoc false

  alias Auth0.Common.Util

  defstruct ticket: nil

  @type t :: %__MODULE__{
          ticket: String.t()
        }

  @spec from(map) :: __MODULE__.t()
  def from(value) do
    value |> Util.to_struct(__MODULE__)
  end
end
