defmodule Auth0.Entity.SigningKeys do
  @moduledoc """
  Documentation for entity of SigningKeys.

  """

  alias Auth0.Common.Util
  alias Auth0.Entity.SigningKey

  defstruct signing_keys: []

  @type t :: %__MODULE__{
          signing_keys: list(SigningKey.t())
        }

  @spec from(list) :: __MODULE__.t()
  def from(value) when value |> is_list do
    %{
      signing_keys: value |> Enum.map(&SigningKey.from/1)
    }
    |> Util.to_struct(__MODULE__)
  end
end
