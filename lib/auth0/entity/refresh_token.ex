defmodule Auth0.Entity.RefreshToken do
  @moduledoc false

  defmodule ResourceServer do
    @moduledoc false

    alias Auth0.Common.Util

    defstruct audience: nil,
              scopes: nil

    @type t :: %__MODULE__{
            audience: String.t(),
            scopes: String.t()
          }

    @spec from(map) :: __MODULE__.t()
    def from(value) do
      value |> Util.to_struct(__MODULE__)
    end
  end

  alias Auth0.Common.Util

  defstruct id: nil,
            user_id: nil,
            created_at: nil,
            idle_expires_at: nil,
            expires_at: nil,
            client_id: nil,
            session_id: nil,
            rotating: nil,
            resource_servers: nil

  @type t :: %__MODULE__{
          id: String.t(),
          user_id: String.t(),
          created_at: String.t(),
          idle_expires_at: String.t(),
          expires_at: String.t(),
          client_id: String.t(),
          session_id: String.t(),
          rotating: boolean,
          resource_servers: list(ResourceServer.t())
        }

  @spec from(map) :: __MODULE__.t()
  def from(value) do
    value |> Util.to_struct(__MODULE__)
  end
end
