defmodule Auth0.Entity.AttackProtectionBreachedPasswordDetection do
  @moduledoc """
  Documentation for entity of AttackProtectionBreachedPasswordDetection.

  """

  alias Auth0.Common.Util

  defstruct enabled: nil,
            shields: nil,
            admin_notification_frequency: nil,
            method: nil

  @type t :: %__MODULE__{
          enabled: boolean,
          shields: list(String.t()),
          admin_notification_frequency: list(String.t()),
          method: String.t()
        }

  @spec from(map) :: __MODULE__.t()
  def from(value) do
    value |> Util.to_struct(__MODULE__)
  end
end
