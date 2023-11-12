defmodule Auth0.Entity.CustomDomain do
  @moduledoc false
  defmodule Verification do
    @moduledoc false

    alias Auth0.Common.Util

    defstruct methods: nil

    @type t :: %__MODULE__{
            methods: list(map)
          }

    @spec from(map) :: __MODULE__.t()
    def from(value) do
      value |> Util.to_struct(__MODULE__)
    end
  end

  alias Auth0.Common.Util

  defstruct custom_domain_id: nil,
            domain: nil,
            primary: nil,
            status: nil,
            type: nil,
            cname_api_key: nil,
            origin_domain_name: nil,
            verification: nil,
            custom_client_ip_header: nil,
            tls_policy: nil

  @type t :: %__MODULE__{
          custom_domain_id: String.t(),
          domain: String.t(),
          primary: boolean,
          status: String.t(),
          type: String.t(),
          cname_api_key: String.t(),
          origin_domain_name: String.t(),
          verification: Verification.t(),
          custom_client_ip_header: String.t(),
          tls_policy: String.t()
        }

  @spec from(map) :: __MODULE__.t()
  def from(value) do
    custom_domain = value |> Util.to_struct(__MODULE__)

    %{
      custom_domain
      | verification:
          if(custom_domain.verification |> is_map,
            do: custom_domain.verification |> Verification.from(),
            else: nil
          )
    }
  end
end
