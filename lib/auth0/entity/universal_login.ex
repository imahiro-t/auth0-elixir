defmodule Auth0.Entity.UniversalLogin do
  @moduledoc """
  Documentation for entity of UniversalLogin.

  """

  alias Auth0.Common.Util

  defstruct body: nil

  @type t :: %__MODULE__{
          body: String.t()
        }

  @spec from(map) :: __MODULE__.t()
  def from(value) do
    value |> Util.to_struct(__MODULE__)
  end
end
