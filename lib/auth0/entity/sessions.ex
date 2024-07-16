defmodule Auth0.Entity.Sessions do
  @moduledoc false

  alias Auth0.Common.Util
  alias Auth0.Entity.Session

  defstruct total: 0,
            next: nil,
            sessions: []

  @type t :: %__MODULE__{
          total: integer,
          next: String.t(),
          sessions: list(Session.t())
        }

  @spec from(map) :: __MODULE__.t()
  def from(value) when value |> is_map do
    sessions = value |> Util.to_struct(__MODULE__)

    if sessions.sessions |> is_list do
      %{
        sessions
        | sessions: sessions.sessions |> Enum.map(&Session.from/1)
      }
    else
      sessions
    end
  end
end
