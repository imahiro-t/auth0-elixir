defmodule Auth0.Entity.GuardianFactors do
  @moduledoc false

  alias Auth0.Common.Util
  alias Auth0.Entity.GuardianFactor

  defstruct factors: []

  @type t :: %__MODULE__{
          factors: list(GuardianFactor.t())
        }

  @spec from(list) :: __MODULE__.t()
  def from(value) when value |> is_list do
    %{
      log_streams: value |> Enum.map(&GuardianFactor.from/1)
    }
    |> Util.to_struct(__MODULE__)
  end
end
