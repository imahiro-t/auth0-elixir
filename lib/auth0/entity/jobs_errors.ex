defmodule Auth0.Entity.JobsErrors do
  @moduledoc """
  Documentation for entity of JobsErrors.

  """

  alias Auth0.Common.Util
  alias Auth0.Entity.JobsError

  defstruct jobs_errors: []

  @type t :: %__MODULE__{
          jobs_errors: list(JobsError.t())
        }

  @spec from(list) :: __MODULE__.t()
  def from(value) when value |> is_list do
    %{
      jobs_errors: value |> Enum.map(&JobsError.from/1)
    }
    |> Util.to_struct(__MODULE__)
  end
end
