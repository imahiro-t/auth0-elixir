defmodule Auth0.Entity.JobsUsersExport do
  @moduledoc """
  Documentation for entity of JobsUsersExport.

  """

  alias Auth0.Common.Util

  defstruct status: nil,
            type: nil,
            created_at: nil,
            id: nil,
            connection_id: nil,
            connection: nil,
            format: nil,
            limit: nil,
            fields: nil

  @type t :: %__MODULE__{
          status: String.t(),
          type: String.t(),
          created_at: String.t(),
          id: String.t(),
          connection_id: String.t(),
          connection: String.t(),
          format: String.t(),
          limit: integer,
          fields: list(map)
        }

  @spec from(map) :: __MODULE__.t()
  def from(value) do
    value |> Util.to_struct(__MODULE__)
  end
end
