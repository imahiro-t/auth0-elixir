defmodule Auth0.Entity.Enrollments do
  @moduledoc false

  alias Auth0.Common.Util
  alias Auth0.Entity.Enrollment

  defstruct enrollments: []

  @type t :: %__MODULE__{
          enrollments: list(Enrollment.t())
        }

  @spec from(list) :: __MODULE__.t()
  def from(value) when value |> is_list do
    %{
      enrollments: value |> Enum.map(&Enrollment.from/1)
    }
    |> Util.to_struct(__MODULE__)
  end
end
