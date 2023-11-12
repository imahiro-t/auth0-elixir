defmodule Auth0.Entity.Identities do
  @moduledoc false

  alias Auth0.Common.Util
  alias Auth0.Entity.Identity

  defstruct identities: []

  @type t :: %__MODULE__{
          identities: list(Identity.t())
        }

  @spec from(list) :: __MODULE__.t()
  def from(value) when value |> is_list do
    %{
      identities: value |> Enum.map(&Identity.from/1)
    }
    |> Util.to_struct(__MODULE__)
  end
end
