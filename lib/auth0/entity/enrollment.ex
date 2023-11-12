defmodule Auth0.Entity.Enrollment do
  @moduledoc false

  alias Auth0.Common.Util

  defstruct id: nil,
            status: nil,
            type: nil,
            name: nil,
            identifier: nil,
            phone_number: nil,
            auth_method: nil,
            enrolled_at: nil,
            last_auth: nil

  @type t :: %__MODULE__{
          id: String.t(),
          status: String.t(),
          type: String.t(),
          name: String.t(),
          identifier: String.t(),
          phone_number: String.t(),
          auth_method: String.t(),
          enrolled_at: String.t(),
          last_auth: String.t()
        }

  @spec from(map) :: __MODULE__.t()
  def from(value) do
    value |> Util.to_struct(__MODULE__)
  end
end
