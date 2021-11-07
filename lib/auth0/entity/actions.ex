defmodule Auth0.Entity.Actions do
  @moduledoc """
  Documentation for entity of Actions.

  """

  alias Auth0.Common.Util
  alias Auth0.Entity.Action

  defstruct total: nil,
            page: nil,
            per_page: nil,
            actions: []

  @type t :: %__MODULE__{
          total: integer,
          page: integer,
          per_page: integer,
          actions: list(Action.t())
        }

  @spec from(map) :: __MODULE__.t()
  def from(value) when value |> is_map do
    actions = value |> Util.to_struct(__MODULE__)

    if actions.actions |> is_list do
      %{
        actions
        | actions: actions.actions |> Enum.map(&Action.from/1)
      }
    else
      actions
    end
  end
end
