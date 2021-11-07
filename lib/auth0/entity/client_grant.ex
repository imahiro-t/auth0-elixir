defmodule Auth0.Entity.ClientGrant do
  @moduledoc """
  Documentation for entity of ClientGrant.

  """

  alias Auth0.Common.Util

  defstruct id: nil,
            client_id: nil,
            audience: nil,
            scope: nil

  @type t :: %__MODULE__{
          id: String.t(),
          client_id: String.t(),
          audience: String.t(),
          scope: list(String.t())
        }

  @spec from(map) :: __MODULE__.t()
  def from(value) do
    value |> Util.to_struct(__MODULE__)
  end
end
