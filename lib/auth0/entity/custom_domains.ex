defmodule Auth0.Entity.CustomDomains do
  @moduledoc """
  Documentation for entity of CustomDomains.

  """

  alias Auth0.Common.Util
  alias Auth0.Entity.CustomDomain

  defstruct custom_domains: []

  @type t :: %__MODULE__{
          custom_domains: list(CustomDomain.t())
        }

  @spec from(list) :: __MODULE__.t()
  def from(value) when value |> is_list do
    %{
      custom_domains: value |> Enum.map(&CustomDomain.from/1)
    }
    |> Util.to_struct(__MODULE__)
  end
end
