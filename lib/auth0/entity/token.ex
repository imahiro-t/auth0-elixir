defmodule Auth0.Entity.Token do
  @moduledoc false
  alias Auth0.Common.Util

  defstruct access_token: nil,
            refresh_token: nil,
            id_token: nil,
            token_type: nil,
            expires_in: nil,
            scope: nil

  @type t :: %__MODULE__{
          access_token: String.t(),
          refresh_token: String.t(),
          id_token: String.t(),
          token_type: String.t(),
          expires_in: integer,
          scope: String.t()
        }

  @spec from(map) :: __MODULE__.t()
  def from(value) do
    value |> Util.to_struct(__MODULE__)
  end
end
