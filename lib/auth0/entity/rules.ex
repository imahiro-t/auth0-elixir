defmodule Auth0.Entity.Rules do
  @moduledoc """
  Documentation for entity of Rules.

  """

  alias Auth0.Common.Util
  alias Auth0.Entity.Rule

  defstruct total: 0,
            start: 0,
            limit: 0,
            rules: []

  @type t :: %__MODULE__{
          total: integer,
          start: integer,
          limit: integer,
          rules: list(Rule.t())
        }

  @spec from(list) :: __MODULE__.t()
  def from(value) when value |> is_list do
    %{
      total: value |> length,
      start: 0,
      limit: value |> length,
      rules: value |> Enum.map(&Rule.from/1)
    }
    |> Util.to_struct(__MODULE__)
  end

  @spec from(map) :: __MODULE__.t()
  def from(value) when value |> is_map do
    rules = value |> Util.to_struct(__MODULE__)

    if rules.rules |> is_list do
      %{rules | rules: rules.rules |> Enum.map(&Rule.from/1)}
    else
      rules
    end
  end
end
