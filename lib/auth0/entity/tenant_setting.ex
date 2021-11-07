defmodule Auth0.Entity.TenantSetting do
  @moduledoc """
  Documentation for entity of TenantSetting.

  """

  defmodule ChangePassword do
    @moduledoc """
    Documentation for entity of TenantSetting ChangePassword.

    """

    alias Auth0.Common.Util

    defstruct enabled: nil,
              html: nil

    @type t :: %__MODULE__{
            enabled: boolean,
            html: String.t()
          }

    @spec from(map) :: __MODULE__.t()
    def from(value) do
      value |> Util.to_struct(__MODULE__)
    end
  end

  defmodule GuardianMfaPage do
    @moduledoc """
    Documentation for entity of TenantSetting GuardianMfaPage.

    """

    alias Auth0.Common.Util

    defstruct enabled: nil,
              html: nil

    @type t :: %__MODULE__{
            enabled: boolean,
            html: String.t()
          }

    @spec from(map) :: __MODULE__.t()
    def from(value) do
      value |> Util.to_struct(__MODULE__)
    end
  end

  defmodule ErrorPage do
    @moduledoc """
    Documentation for entity of TenantSetting ErrorPage.

    """

    alias Auth0.Common.Util

    defstruct html: nil,
              show_log_link: nil,
              url: nil

    @type t :: %__MODULE__{
            html: String.t(),
            show_log_link: boolean,
            url: String.t()
          }

    @spec from(map) :: __MODULE__.t()
    def from(value) do
      value |> Util.to_struct(__MODULE__)
    end
  end

  defmodule DeviceFlow do
    @moduledoc """
    Documentation for entity of TenantSetting DeviceFlow.

    """

    alias Auth0.Common.Util

    defstruct charset: nil,
              mask: nil

    @type t :: %__MODULE__{
            charset: String.t(),
            mask: String.t()
          }

    @spec from(map) :: __MODULE__.t()
    def from(value) do
      value |> Util.to_struct(__MODULE__)
    end
  end

  defmodule Flags do
    @moduledoc """
    Documentation for entity of TenantSetting Flags.

    """

    alias Auth0.Common.Util

    defstruct change_pwd_flow_v1: nil,
              enable_apis_section: nil,
              disable_impersonation: nil,
              enable_client_connections: nil,
              enable_pipeline2: nil,
              allow_legacy_delegation_grant_types: nil,
              allow_legacy_ro_grant_types: nil,
              allow_legacy_tokeninfo_endpoint: nil,
              enable_legacy_profile: nil,
              enable_idtoken_api2: nil,
              enable_public_signup_user_exists_error: nil,
              enable_sso: nil,
              allow_changing_enable_sso: nil,
              disable_clickjack_protection_headers: nil,
              no_disclose_enterprise_connections: nil,
              enforce_client_authentication_on_passwordless_start: nil,
              enable_adfs_waad_email_verification: nil,
              revoke_refresh_token_grant: nil,
              dashboard_log_streams_next: nil,
              dashboard_insights_view: nil

    @type t :: %__MODULE__{
            change_pwd_flow_v1: boolean,
            enable_apis_section: boolean,
            disable_impersonation: boolean,
            enable_client_connections: boolean,
            enable_pipeline2: boolean,
            allow_legacy_delegation_grant_types: boolean,
            allow_legacy_ro_grant_types: boolean,
            allow_legacy_tokeninfo_endpoint: boolean,
            enable_legacy_profile: boolean,
            enable_idtoken_api2: boolean,
            enable_public_signup_user_exists_error: boolean,
            enable_sso: boolean,
            allow_changing_enable_sso: boolean,
            disable_clickjack_protection_headers: boolean,
            no_disclose_enterprise_connections: boolean,
            enforce_client_authentication_on_passwordless_start: boolean,
            enable_adfs_waad_email_verification: boolean,
            revoke_refresh_token_grant: boolean,
            dashboard_log_streams_next: boolean,
            dashboard_insights_view: boolean
          }

    @spec from(map) :: __MODULE__.t()
    def from(value) do
      value |> Util.to_struct(__MODULE__)
    end
  end

  defmodule SessionCookie do
    @moduledoc """
    Documentation for entity of TenantSetting SessionCookie.

    """

    alias Auth0.Common.Util

    defstruct mode: nil

    @type t :: %__MODULE__{
            mode: String.t()
          }

    @spec from(map) :: __MODULE__.t()
    def from(value) do
      value |> Util.to_struct(__MODULE__)
    end
  end

  alias Auth0.Common.Util

  defstruct change_password: nil,
            guardian_mfa_page: nil,
            default_audience: nil,
            default_directory: nil,
            error_page: nil,
            device_flow: nil,
            flags: nil,
            friendly_name: nil,
            picture_url: nil,
            support_email: nil,
            support_url: nil,
            allowed_logout_urls: nil,
            session_lifetime: nil,
            idle_session_lifetime: nil,
            sandbox_version: nil,
            sandbox_versions_available: nil,
            default_redirection_uri: nil,
            enabled_locales: nil,
            session_cookie: nil

  @type t :: %__MODULE__{
          change_password: ChangePassword.t(),
          guardian_mfa_page: GuardianMfaPage.t(),
          default_audience: String.t(),
          default_directory: String.t(),
          error_page: ErrorPage.t(),
          device_flow: DeviceFlow.t(),
          flags: Flags.t(),
          friendly_name: String.t(),
          picture_url: String.t(),
          support_email: String.t(),
          support_url: String.t(),
          allowed_logout_urls: list(String.t()),
          session_lifetime: integer,
          idle_session_lifetime: integer,
          sandbox_version: String.t(),
          sandbox_versions_available: list(String.t()),
          default_redirection_uri: String.t(),
          enabled_locales: list(String.t()),
          session_cookie: SessionCookie.t()
        }

  @spec from(map) :: __MODULE__.t()
  def from(value) do
    tenant_setting = value |> Util.to_struct(__MODULE__)

    %{
      tenant_setting
      | change_password:
          if(tenant_setting.change_password |> is_map,
            do: tenant_setting.change_password |> ChangePassword.from(),
            else: nil
          ),
        guardian_mfa_page:
          if(tenant_setting.guardian_mfa_page |> is_map,
            do: tenant_setting.guardian_mfa_page |> GuardianMfaPage.from(),
            else: nil
          ),
        error_page:
          if(tenant_setting.error_page |> is_map,
            do: tenant_setting.error_page |> ErrorPage.from(),
            else: nil
          ),
        device_flow:
          if(tenant_setting.device_flow |> is_map,
            do: tenant_setting.device_flow |> DeviceFlow.from(),
            else: nil
          ),
        flags:
          if(tenant_setting.flags |> is_map,
            do: tenant_setting.flags |> Flags.from(),
            else: nil
          ),
        session_cookie:
          if(tenant_setting.session_cookie |> is_map,
            do: tenant_setting.session_cookie |> SessionCookie.from(),
            else: nil
          )
    }
  end
end
