defmodule Auth0.Entity.DeviceCredentials do
  @moduledoc false

  alias Auth0.Common.Util
  alias Auth0.Entity.DeviceCredential

  defstruct total: nil,
            start: nil,
            limit: nil,
            device_credentials: []

  @type t :: %__MODULE__{
          total: integer,
          start: integer,
          limit: integer,
          device_credentials: list(DeviceCredential.t())
        }

  @spec from(list) :: __MODULE__.t()
  def from(value) when value |> is_list do
    %{
      total: value |> length,
      start: 0,
      limit: value |> length,
      device_credentials: value |> Enum.map(&DeviceCredential.from/1)
    }
    |> Util.to_struct(__MODULE__)
  end

  @spec from(map) :: __MODULE__.t()
  def from(value) when value |> is_map do
    device_credentials = value |> Util.to_struct(__MODULE__)

    if device_credentials.device_credentials |> is_list do
      %{
        device_credentials
        | device_credentials:
            device_credentials.device_credentials |> Enum.map(&DeviceCredential.from/1)
      }
    else
      device_credentials
    end
  end
end
