defmodule Auth0.Entity.JobsError do
  @moduledoc false

  alias Auth0.Common.Util

  defstruct user: nil,
            errors: nil

  @type t :: %__MODULE__{
          user: map,
          errors: list(map)
        }

  @spec from(map) :: __MODULE__.t()
  def from(value) do
    value |> Util.to_struct(__MODULE__)
  end
end
