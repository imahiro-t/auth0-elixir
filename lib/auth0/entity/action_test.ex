defmodule Auth0.Entity.ActionTest do
  @moduledoc false

  alias Auth0.Common.Util

  defstruct payload: nil

  @type t :: %__MODULE__{
          payload: map
        }

  @spec from(map) :: __MODULE__.t()
  def from(value) do
    value |> Util.to_struct(__MODULE__)
  end
end
