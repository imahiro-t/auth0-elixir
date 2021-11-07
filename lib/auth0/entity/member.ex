defmodule Auth0.Entity.Member do
  @moduledoc """
  Documentation for entity of Member.

  """

  alias Auth0.Common.Util

  defstruct user_id: nil,
            picture: nil,
            name: nil,
            email: nil

  @type t :: %__MODULE__{
          user_id: String.t(),
          picture: String.t(),
          name: String.t(),
          email: String.t()
        }

  @spec from(map) :: __MODULE__.t()
  def from(value) do
    value |> Util.to_struct(__MODULE__)
  end
end
