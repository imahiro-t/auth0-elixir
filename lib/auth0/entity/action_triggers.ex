defmodule Auth0.Entity.ActionTriggers do
  @moduledoc false

  defmodule Trigger do
    @moduledoc false

    alias Auth0.Common.Util

    defstruct id: nil,
              status: nil,
              runtimes: nil,
              default_runtime: nil,
              version: nil

    @type t :: %__MODULE__{
            id: String.t(),
            status: String.t(),
            runtimes: list(String.t()),
            default_runtime: String.t(),
            version: String.t()
          }

    @spec from(map) :: __MODULE__.t()
    def from(value) do
      value |> Util.to_struct(__MODULE__)
    end
  end

  alias Auth0.Common.Util

  defstruct triggers: nil

  @type t :: %__MODULE__{
          triggers: list(Trigger.t())
        }

  @spec from(map) :: __MODULE__.t()
  def from(value) do
    triggers = value |> Util.to_struct(__MODULE__)

    %{
      triggers
      | triggers:
          if(triggers.triggers |> is_list,
            do: triggers.triggers |> Enum.map(&Trigger.from/1),
            else: nil
          )
    }
  end
end
