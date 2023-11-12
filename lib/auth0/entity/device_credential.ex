defmodule Auth0.Entity.DeviceCredential do
  @moduledoc false

  alias Auth0.Common.Util

  defstruct id: nil,
            device_name: nil,
            device_id: nil,
            type: nil,
            user_id: nil,
            client_id: nil

  @type t :: %__MODULE__{
          id: String.t(),
          device_name: String.t(),
          device_id: String.t(),
          type: String.t(),
          user_id: String.t(),
          client_id: String.t()
        }

  @spec from(map) :: __MODULE__.t()
  def from(value) do
    value |> Util.to_struct(__MODULE__)
  end
end
