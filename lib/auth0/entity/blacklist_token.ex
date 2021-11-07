defmodule Auth0.Entity.BlacklistToken do
  @moduledoc """
  Documentation for entity of BlacklistToken.

  """

  alias Auth0.Common.Util

  defstruct aud: nil,
            jti: nil

  @type t :: %__MODULE__{
          aud: String.t(),
          jti: String.t()
        }

  @spec from(map) :: __MODULE__.t()
  def from(value) do
    value |> Util.to_struct(__MODULE__)
  end
end
