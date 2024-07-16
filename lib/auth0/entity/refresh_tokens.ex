defmodule Auth0.Entity.RefreshTokens do
  @moduledoc false

  alias Auth0.Common.Util
  alias Auth0.Entity.RefreshToken

  defstruct total: 0,
            next: nil,
            tokens: []

  @type t :: %__MODULE__{
          total: integer,
          next: String.t(),
          tokens: list(RefreshToken.t())
        }

  @spec from(map) :: __MODULE__.t()
  def from(value) when value |> is_map do
    refresh_tokens = value |> Util.to_struct(__MODULE__)

    if refresh_tokens.tokens |> is_list do
      %{
        refresh_tokens
        | tokens: refresh_tokens.tokens |> Enum.map(&RefreshToken.from/1)
      }
    else
      refresh_tokens
    end
  end
end
