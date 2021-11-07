defmodule Auth0.Entity.EmailProvider do
  @moduledoc """
  Documentation for entity of EmailProvider.

  """

  defmodule Credentials do
    @moduledoc """
    Documentation for entity of EmailProvider Credentials.

    """

    alias Auth0.Common.Util

    defstruct api_user: nil,
              region: nil,
              smtp_host: nil,
              smtp_port: nil,
              smtp_user: nil

    @type t :: %__MODULE__{
            api_user: String.t(),
            region: String.t(),
            smtp_host: String.t(),
            smtp_port: integer,
            smtp_user: String.t()
          }

    @spec from(map) :: __MODULE__.t()
    def from(value) do
      value |> Util.to_struct(__MODULE__)
    end
  end

  alias Auth0.Common.Util

  defstruct name: nil,
            enabled: nil,
            default_from_address: nil,
            credentials: nil,
            settings: nil

  @type t :: %__MODULE__{
          name: String.t(),
          enabled: boolean,
          default_from_address: String.t(),
          credentials: Credentials.t(),
          settings: map
        }

  @spec from(map) :: __MODULE__.t()
  def from(value) do
    email_provider = value |> Util.to_struct(__MODULE__)

    %{
      email_provider
      | credentials:
          if(email_provider.credentials |> is_map,
            do: email_provider.credentials |> Credentials.from(),
            else: nil
          )
    }
  end
end
