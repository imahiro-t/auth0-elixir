defmodule Auth0.Management.Tenants.Settings.Patch do
  @moduledoc """
  Documentation for Auth0 Management Update tenant settings.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Tenants/patch_settings
  """

  alias Auth0.Config
  alias Auth0.Common.Util
  alias Auth0.Common.Management.Http
  alias Auth0.Entity.TenantSetting

  defmodule Params do
    defmodule ChangePassword do
      defstruct enabled: nil,
                html: nil

      @type t :: %__MODULE__{
              enabled: boolean,
              html: String.t()
            }
    end

    defmodule GuardianMfaPage do
      defstruct enabled: nil,
                html: nil

      @type t :: %__MODULE__{
              enabled: boolean,
              html: String.t()
            }
    end

    defmodule ErrorPage do
      defstruct html: nil,
                show_log_link: nil,
                url: nil

      @type t :: %__MODULE__{
              html: String.t(),
              show_log_link: boolean,
              url: String.t()
            }
    end

    defmodule DeviceFlow do
      defstruct charset: nil,
                mask: nil

      @type t :: %__MODULE__{
              charset: String.t(),
              mask: String.t()
            }
    end

    defmodule Flags do
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
    end

    defmodule SessionCookie do
      defstruct mode: nil

      @type t :: %__MODULE__{
              mode: String.t()
            }
    end

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
            default_redirection_uri: String.t(),
            enabled_locales: list(String.t()),
            session_cookie: SessionCookie.t()
          }
  end

  @type endpoint :: String.t()
  @type params :: Params.t() | map
  @type config :: Config.t()
  @type entity :: TenantSetting.t()
  @type response_body :: String.t()
  @type response :: {:ok, entity, response_body} | {:error, integer, term} | {:error, term}

  @doc """
  Update tenant settings.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Tenants/patch_settings

  """
  @spec execute(endpoint, params, config) :: response
  def execute(endpoint, %Params{} = params, %Config{} = config) do
    execute(endpoint, params |> Util.to_map(), config)
  end

  def execute(endpoint, %{} = params, %Config{} = config) do
    body = params |> Util.remove_nil()

    endpoint
    |> Http.patch(body, config)
    |> case do
      {:ok, 200, body} -> {:ok, TenantSetting.from(body |> Jason.decode!()), body}
      error -> error
    end
  end
end
