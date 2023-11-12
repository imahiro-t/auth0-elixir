defmodule Auth0.Entity.ActionTriggerBindings do
  @moduledoc false

  alias Auth0.Common.Util
  alias Auth0.Entity.ActionTriggerBinding

  defstruct total: nil,
            page: nil,
            per_page: nil,
            bindings: []

  @type t :: %__MODULE__{
          total: integer,
          page: integer,
          per_page: integer,
          bindings: list(ActionTriggerBinding.t())
        }

  @spec from(map) :: __MODULE__.t()
  def from(value) when value |> is_map do
    bindings = value |> Util.to_struct(__MODULE__)

    if bindings.bindings |> is_list do
      %{
        bindings
        | bindings: bindings.bindings |> Enum.map(&ActionTriggerBinding.from/1)
      }
    else
      bindings
    end
  end
end
