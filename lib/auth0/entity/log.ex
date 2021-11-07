defmodule Auth0.Entity.Log do
  @moduledoc """
  Documentation for entity of Log.

  """

  defmodule LocationInfo do
    @moduledoc """
    Documentation for entity of Log LocationInfo.

    """

    alias Auth0.Common.Util

    defstruct country_code3: nil,
              country_code: nil,
              country_name: nil,
              city_name: nil,
              latitude: nil,
              longitude: nil,
              time_zone: nil,
              continent_code: nil

    @type t :: %__MODULE__{
            country_code3: String.t(),
            country_code: String.t(),
            country_name: String.t(),
            city_name: String.t(),
            latitude: String.t(),
            longitude: String.t(),
            time_zone: String.t(),
            continent_code: String.t()
          }

    @spec from(map) :: __MODULE__.t()
    def from(value) do
      value |> Util.to_struct(__MODULE__)
    end
  end

  alias Auth0.Common.Util

  defstruct date: nil,
            type: nil,
            description: nil,
            connection: nil,
            connection_id: nil,
            client_id: nil,
            client_name: nil,
            ip: nil,
            hostname: nil,
            user_id: nil,
            user_name: nil,
            audience: nil,
            scope: nil,
            strategy: nil,
            strategy_type: nil,
            log_id: nil,
            isMobile: false,
            details: nil,
            user_agent: nil,
            location_info: nil

  @type t :: %__MODULE__{
          date: String.t(),
          type: String.t(),
          description: String.t(),
          connection: String.t(),
          connection_id: String.t(),
          client_id: String.t(),
          client_name: String.t(),
          ip: String.t(),
          hostname: String.t(),
          user_id: String.t(),
          user_name: String.t(),
          audience: String.t(),
          scope: String.t(),
          strategy: String.t(),
          strategy_type: String.t(),
          log_id: String.t(),
          isMobile: boolean,
          details: map,
          user_agent: String.t(),
          location_info: LocationInfo.t()
        }

  @spec from(map) :: __MODULE__.t()
  def from(value) do
    log = value |> Util.to_struct(__MODULE__)

    if log.location_info |> is_map do
      %{log | location_info: log.location_info |> LocationInfo.from()}
    else
      log
    end
  end
end
