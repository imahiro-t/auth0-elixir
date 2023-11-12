defmodule Auth0.Entity.ActionTriggerBinding do
  @moduledoc false

  alias Auth0.Common.Util
  alias Auth0.Entity.Action

  defstruct id: nil,
            trigger_id: nil,
            created_at: nil,
            updated_at: nil,
            display_name: nil,
            action: nil

  @type t :: %__MODULE__{
          id: String.t(),
          trigger_id: String.t(),
          created_at: String.t(),
          updated_at: String.t(),
          display_name: String.t(),
          action: Action.t()
        }

  @spec from(map) :: __MODULE__.t()
  def from(value) do
    trigger_binding = value |> Util.to_struct(__MODULE__)

    %{
      trigger_binding
      | action:
          if(trigger_binding.action |> is_map,
            do: trigger_binding.action |> Action.from(),
            else: nil
          )
    }
  end
end
