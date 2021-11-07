defmodule Auth0.Entity.LogStreams do
  @moduledoc """
  Documentation for entity of LogStreams.

  """

  alias Auth0.Common.Util
  alias Auth0.Entity.LogStream

  defstruct log_streams: []

  @type t :: %__MODULE__{
          log_streams: list(LogStream.t())
        }

  @spec from(list) :: __MODULE__.t()
  def from(value) when value |> is_list do
    %{
      log_streams: value |> Enum.map(&LogStream.from/1)
    }
    |> Util.to_struct(__MODULE__)
  end
end
