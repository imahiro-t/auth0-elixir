defmodule Auth0.Entity.CustomText do
  @moduledoc """
  Documentation for entity of CustomText.

  """

  defstruct value: nil

  @type t :: %__MODULE__{
          value: map
        }

  @spec from(map) :: __MODULE__.t()
  def from(value) do
    %__MODULE__{value: value}
  end
end
