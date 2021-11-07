defmodule Auth0.Entity.EnabledConnection do
  @moduledoc """
  Documentation for entity of EnabledConnection.

  """

  alias Auth0.Common.Util
  alias Auth0.Entity.Connection

  defstruct connection_id: nil,
            assign_membership_on_login: nil,
            connection: nil

  @type t :: %__MODULE__{
          connection_id: String.t(),
          assign_membership_on_login: boolean,
          connection: Connection.t()
        }

  @spec from(map) :: __MODULE__.t()
  def from(value) do
    enabled_connection = value |> Util.to_struct(__MODULE__)

    %{
      enabled_connection
      | connection:
          if(enabled_connection.connection |> is_map,
            do: enabled_connection.connection |> Connection.from(),
            else: nil
          )
    }
  end
end
