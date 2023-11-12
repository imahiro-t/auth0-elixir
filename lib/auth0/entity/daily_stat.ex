defmodule Auth0.Entity.DailyStat do
  @moduledoc false

  alias Auth0.Common.Util

  defstruct date: nil,
            logins: nil,
            signups: nil,
            leaked_passwords: nil,
            updated_at: nil,
            created_at: nil

  @type t :: %__MODULE__{
          date: String.t(),
          logins: integer,
          signups: integer,
          leaked_passwords: integer,
          updated_at: String.t(),
          created_at: String.t()
        }

  @spec from(map) :: __MODULE__.t()
  def from(value) do
    value |> Util.to_struct(__MODULE__)
  end
end
