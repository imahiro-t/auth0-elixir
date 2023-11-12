defmodule Auth0.Entity.Jobs do
  @moduledoc false

  defmodule Summary do
    @moduledoc false
    alias Auth0.Common.Util

    defstruct failed: nil,
              updated: nil,
              inserted: nil,
              total: nil

    @type t :: %__MODULE__{
            failed: integer,
            updated: integer,
            inserted: integer,
            total: integer
          }

    @spec from(map) :: __MODULE__.t()
    def from(value) do
      value |> Util.to_struct(__MODULE__)
    end
  end

  alias Auth0.Common.Util

  defstruct status: nil,
            type: nil,
            created_at: nil,
            id: nil,
            connection_id: nil,
            connection: nil,
            location: nil,
            percentage_done: nil,
            time_left_seconds: nil,
            format: nil,
            summary: nil

  @type t :: %__MODULE__{
          status: String.t(),
          type: String.t(),
          created_at: String.t(),
          id: String.t(),
          connection_id: String.t(),
          connection: String.t(),
          location: String.t(),
          percentage_done: integer,
          time_left_seconds: integer,
          format: String.t(),
          summary: Summary.t()
        }

  @spec from(map) :: __MODULE__.t()
  def from(value) do
    jobs = value |> Util.to_struct(__MODULE__)

    if jobs.summary |> is_map do
      %{jobs | summary: jobs.summary |> Summary.from()}
    else
      jobs
    end
  end
end
