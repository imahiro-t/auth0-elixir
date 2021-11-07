defmodule Auth0.Entity.Grant do
  @moduledoc """
  Documentation for entity of Grant.

  """

  alias Auth0.Common.Util

  defstruct id: nil,
            clientID: nil,
            user_id: nil,
            audience: nil,
            scope: nil

  @type t :: %__MODULE__{
          id: String.t(),
          clientID: String.t(),
          user_id: String.t(),
          audience: String.t(),
          scope: list(String.t())
        }

  @spec from(map) :: __MODULE__.t()
  def from(value) do
    value |> Util.to_struct(__MODULE__)
  end
end
