defmodule Auth0.Entity.DailyStats do
  @moduledoc false

  alias Auth0.Common.Util
  alias Auth0.Entity.DailyStat

  defstruct daily_stats: []

  @type t :: %__MODULE__{
          daily_stats: list(DailyStat.t())
        }

  @spec from(list) :: __MODULE__.t()
  def from(value) when value |> is_list do
    %{
      daily_stats: value |> Enum.map(&DailyStat.from/1)
    }
    |> Util.to_struct(__MODULE__)
  end
end
