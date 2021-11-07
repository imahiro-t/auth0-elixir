defmodule Auth0.Entity.BlacklistTokens do
  @moduledoc """
  Documentation for entity of BlacklistTokens.

  """

  alias Auth0.Common.Util
  alias Auth0.Entity.BlacklistToken

  defstruct blacklist_tokens: []

  @type t :: %__MODULE__{
          blacklist_tokens: list(BlacklistToken.t())
        }

  @spec from(list) :: __MODULE__.t()
  def from(value) when value |> is_list do
    %{
      blacklist_tokens: value |> Enum.map(&BlacklistToken.from/1)
    }
    |> Util.to_struct(__MODULE__)
  end
end
