defmodule Auth0.Entity.Session do
  @moduledoc false

  defmodule Authentication do
    @moduledoc false

    defmodule Method do
      @moduledoc false

      alias Auth0.Common.Util

      defstruct name: nil,
                timestamp: nil

      @type t :: %__MODULE__{
              name: String.t(),
              timestamp: String.t()
            }

      @spec from(map) :: __MODULE__.t()
      def from(value) do
        value |> Util.to_struct(__MODULE__)
      end
    end

    alias Auth0.Common.Util

    defstruct methods: nil

    @type t :: %__MODULE__{
            methods: list(Method.t())
          }

    @spec from(map) :: __MODULE__.t()
    def from(value) do
      value |> Util.to_struct(__MODULE__)
    end
  end

  defmodule Device do
    @moduledoc false

    alias Auth0.Common.Util

    defstruct initial_asn: nil,
              initial_ip: nil,
              initial_user_agent: nil,
              last_asn: nil,
              last_ip: nil,
              last_user_agent: nil

    @type t :: %__MODULE__{
            initial_asn: String.t(),
            initial_ip: String.t(),
            initial_user_agent: String.t(),
            last_asn: String.t(),
            last_ip: String.t(),
            last_user_agent: String.t()
          }

    @spec from(map) :: __MODULE__.t()
    def from(value) do
      value |> Util.to_struct(__MODULE__)
    end
  end

  defmodule Client do
    @moduledoc false

    alias Auth0.Common.Util

    defstruct client_id: nil

    @type t :: %__MODULE__{
            client_id: String.t()
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
            updated_at: nil,
            authenticated_at: nil,
            authentication: nil,
            idle_expires_at: nil,
            expires_at: nil,
            device: nil,
            clients: nil

  @type t :: %__MODULE__{
          id: String.t(),
          user_id: String.t(),
          created_at: String.t(),
          updated_at: String.t(),
          authenticated_at: String.t(),
          authentication: Authentication.t(),
          idle_expires_at: String.t(),
          expires_at: String.t(),
          device: Device.t(),
          clients: list(Client.t())
        }

  @spec from(map) :: __MODULE__.t()
  def from(value) do
    value |> Util.to_struct(__MODULE__)
  end
end
