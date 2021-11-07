defmodule Auth0.Entity.Logs do
  @moduledoc """
  Documentation for entity of Logs.

  """

  alias Auth0.Common.Util
  alias Auth0.Entity.Log

  defstruct length: 0,
            total: 0,
            start: 0,
            limit: 0,
            logs: []

  @type t :: %__MODULE__{
          length: integer,
          total: integer,
          start: integer,
          limit: integer,
          logs: list(Log.t())
        }

  @spec from(list) :: __MODULE__.t()
  def from(value) when value |> is_list do
    %{
      length: value |> length,
      total: value |> length,
      start: 0,
      limit: value |> length,
      logs: value |> Enum.map(&Log.from/1)
    }
    |> Util.to_struct(__MODULE__)
  end

  @spec from(map) :: __MODULE__.t()
  def from(value) when value |> is_map do
    logs = value |> Util.to_struct(__MODULE__)

    if logs.logs |> is_list do
      %{logs | logs: logs.logs |> Enum.map(&Log.from/1)}
    else
      logs
    end
  end
end
