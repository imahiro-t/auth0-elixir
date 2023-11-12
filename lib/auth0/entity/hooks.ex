defmodule Auth0.Entity.Hooks do
  @moduledoc false

  alias Auth0.Common.Util
  alias Auth0.Entity.Hook

  defstruct total: 0,
            start: 0,
            limit: 0,
            hooks: []

  @type t :: %__MODULE__{
          total: integer,
          start: integer,
          limit: integer,
          hooks: list(Hook.t())
        }

  @spec from(list) :: __MODULE__.t()
  def from(value) when value |> is_list do
    %{
      total: value |> length,
      start: 0,
      limit: value |> length,
      hooks: value |> Enum.map(&Hook.from/1)
    }
    |> Util.to_struct(__MODULE__)
  end

  @spec from(map) :: __MODULE__.t()
  def from(value) when value |> is_map do
    hooks = value |> Util.to_struct(__MODULE__)

    if hooks.hooks |> is_list do
      %{hooks | hooks: hooks.hooks |> Enum.map(&Hook.from/1)}
    else
      hooks
    end
  end
end
