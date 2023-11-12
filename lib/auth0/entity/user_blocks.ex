defmodule Auth0.Entity.UserBlocks do
  @moduledoc false
  defmodule BlockedFor do
    @moduledoc false

    alias Auth0.Common.Util

    defstruct identifier: nil,
              connection: nil,
              ip: nil

    @type t :: %__MODULE__{
            identifier: String.t(),
            connection: String.t(),
            ip: String.t()
          }

    @spec from(map) :: __MODULE__.t()
    def from(value) do
      value |> Util.to_struct(__MODULE__)
    end
  end

  alias Auth0.Common.Util

  defstruct blocked_for: nil

  @type t :: %__MODULE__{
          blocked_for: list(BlockedFor.t())
        }

  @spec from(map) :: __MODULE__.t()
  def from(value) do
    user_blocks = value |> Util.to_struct(__MODULE__)

    %{
      user_blocks
      | blocked_for:
          if(user_blocks.blocked_for |> is_list,
            do: user_blocks.blocked_for |> Enum.map(&BlockedFor.from/1),
            else: nil
          )
    }
  end
end
