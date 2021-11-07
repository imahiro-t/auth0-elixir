defmodule Auth0.Entity.Client do
  @moduledoc """
  Documentation for entity of Client.

  """

  defmodule JwtConfiguration do
    @moduledoc """
    Documentation for entity of Client JwtConfiguration.

    """

    alias Auth0.Common.Util

    defstruct lifetime_in_seconds: nil,
              secret_encoded: nil,
              scopes: nil,
              alg: nil

    @type t :: %__MODULE__{
            lifetime_in_seconds: integer,
            secret_encoded: boolean,
            scopes: map,
            alg: String.t()
          }

    @spec from(map) :: __MODULE__.t()
    def from(value) do
      value |> Util.to_struct(__MODULE__)
    end
  end

  defmodule EncryptionKey do
    @moduledoc """
    Documentation for entity of Client EncryptionKey.

    """

    alias Auth0.Common.Util

    defstruct pub: nil,
              cert: nil,
              subject: nil

    @type t :: %__MODULE__{
            pub: String.t(),
            cert: String.t(),
            subject: String.t()
          }

    @spec from(map) :: __MODULE__.t()
    def from(value) do
      value |> Util.to_struct(__MODULE__)
    end
  end

  defmodule Addons do
    @moduledoc """
    Documentation for entity of Client Addons.

    """

    alias Auth0.Common.Util

    defstruct aws: nil,
              azure_blob: nil,
              azure_sb: nil,
              rms: nil,
              mscrm: nil,
              slack: nil,
              sentry: nil,
              box: nil,
              cloudbees: nil,
              concur: nil,
              dropbox: nil,
              echosign: nil,
              egnyte: nil,
              firebase: nil,
              newrelic: nil,
              office365: nil,
              salesforce: nil,
              salesforce_api: nil,
              salesforce_sandbox_api: nil,
              samlp: nil,
              layer: nil,
              sap_api: nil,
              sharepoint: nil,
              springcm: nil,
              wams: nil,
              wsfed: nil,
              zendesk: nil,
              zoom: nil,
              sso_integration: nil

    @type t :: %__MODULE__{
            aws: map,
            azure_blob: map,
            azure_sb: map,
            rms: map,
            mscrm: map,
            slack: map,
            sentry: map,
            box: map,
            cloudbees: map,
            concur: map,
            dropbox: map,
            echosign: map,
            egnyte: map,
            firebase: map,
            newrelic: map,
            office365: map,
            salesforce: map,
            salesforce_api: map,
            salesforce_sandbox_api: map,
            samlp: map,
            layer: map,
            sap_api: map,
            sharepoint: map,
            springcm: map,
            wams: map,
            wsfed: map,
            zendesk: map,
            zoom: map,
            sso_integration: map
          }

    @spec from(map) :: __MODULE__.t()
    def from(value) do
      value |> Util.to_struct(__MODULE__)
    end
  end

  defmodule Mobile do
    @moduledoc """
    Documentation for entity of Client Mobile.

    """

    defmodule Android do
      @moduledoc """
      Documentation for entity of Client Mobile Android.

      """

      alias Auth0.Common.Util

      defstruct app_package_name: nil,
                sha256_cert_fingerprints: nil

      @type t :: %__MODULE__{
              app_package_name: String.t(),
              sha256_cert_fingerprints: list(String.t())
            }

      @spec from(map) :: __MODULE__.t()
      def from(value) do
        value |> Util.to_struct(__MODULE__)
      end
    end

    defmodule Ios do
      @moduledoc """
      Documentation for entity of Client Mobile Ios.

      """

      alias Auth0.Common.Util

      defstruct team_id: nil,
                app_bundle_identifier: nil

      @type t :: %__MODULE__{
              team_id: String.t(),
              app_bundle_identifier: list(String.t())
            }

      @spec from(map) :: __MODULE__.t()
      def from(value) do
        value |> Util.to_struct(__MODULE__)
      end
    end

    alias Auth0.Common.Util

    defstruct android: nil,
              ios: nil

    @type t :: %__MODULE__{
            android: Android.t(),
            ios: Ios.t()
          }

    @spec from(map) :: __MODULE__.t()
    def from(value) do
      mobile = value |> Util.to_struct(__MODULE__)

      %{
        mobile
        | android:
            if(mobile.android |> is_map,
              do: mobile.android |> Android.from(),
              else: nil
            ),
          ios:
            if(mobile.ios |> is_map,
              do: mobile.ios |> Ios.from(),
              else: nil
            )
      }
    end
  end

  defmodule NativeSocialLogin do
    @moduledoc """
    Documentation for entity of Client NativeSocialLogin.

    """

    alias Auth0.Common.Util

    defstruct apple: nil,
              facebook: nil

    @type t :: %__MODULE__{
            apple: map,
            facebook: map
          }

    @spec from(map) :: __MODULE__.t()
    def from(value) do
      value |> Util.to_struct(__MODULE__)
    end
  end

  defmodule RefreshToken do
    @moduledoc """
    Documentation for entity of Client RefreshToken.

    """

    alias Auth0.Common.Util

    defstruct rotation_type: nil,
              expiration_type: nil,
              leeway: nil,
              token_lifetime: nil,
              infinite_token_lifetime: nil,
              idle_token_lifetime: nil,
              infinite_idle_token_lifetime: nil

    @type t :: %__MODULE__{
            rotation_type: String.t(),
            expiration_type: String.t(),
            leeway: integer,
            token_lifetime: integer,
            infinite_token_lifetime: false,
            idle_token_lifetime: integer,
            infinite_idle_token_lifetime: integer
          }

    @spec from(map) :: __MODULE__.t()
    def from(value) do
      value |> Util.to_struct(__MODULE__)
    end
  end

  alias Auth0.Common.Util

  defstruct client_id: nil,
            tenant: nil,
            name: nil,
            description: nil,
            global: nil,
            client_secret: nil,
            app_type: nil,
            logo_uri: nil,
            is_first_party: nil,
            oidc_conformant: nil,
            callbacks: nil,
            allowed_origins: nil,
            web_origins: nil,
            client_aliases: nil,
            allowed_clients: nil,
            allowed_logout_urls: nil,
            grant_types: nil,
            jwt_configuration: nil,
            signing_keys: nil,
            encryption_key: nil,
            sso: nil,
            sso_disabled: nil,
            cross_origin_auth: nil,
            cross_origin_loc: nil,
            custom_login_page_on: nil,
            custom_login_page: nil,
            custom_login_page_preview: nil,
            form_template: nil,
            addons: nil,
            token_endpoint_auth_method: nil,
            client_metadata: nil,
            mobile: nil,
            initiate_login_uri: nil,
            native_social_login: nil,
            refresh_token: nil,
            organization_usage: nil,
            organization_require_behavior: nil

  @type t :: %__MODULE__{
          client_id: String.t(),
          tenant: String.t(),
          name: String.t(),
          description: String.t(),
          global: boolean,
          client_secret: String.t(),
          app_type: String.t(),
          logo_uri: String.t(),
          is_first_party: boolean,
          oidc_conformant: boolean,
          callbacks: list(String.t()),
          allowed_origins: list(String.t()),
          web_origins: list(String.t()),
          client_aliases: list(String.t()),
          allowed_clients: list(String.t()),
          allowed_logout_urls: list(String.t()),
          grant_types: list(String.t()),
          jwt_configuration: JwtConfiguration.t(),
          signing_keys: list(map),
          encryption_key: EncryptionKey.t(),
          sso: boolean,
          sso_disabled: boolean,
          cross_origin_auth: boolean,
          cross_origin_loc: String.t(),
          custom_login_page_on: boolean,
          custom_login_page: String.t(),
          custom_login_page_preview: String.t(),
          form_template: String.t(),
          addons: Addons.t(),
          token_endpoint_auth_method: String.t(),
          client_metadata: map,
          mobile: Mobile.t(),
          initiate_login_uri: String.t(),
          native_social_login: NativeSocialLogin.t(),
          refresh_token: RefreshToken.t(),
          organization_usage: String.t(),
          organization_require_behavior: String.t()
        }

  @spec from(map) :: __MODULE__.t()
  def from(value) do
    client = value |> Util.to_struct(__MODULE__)

    %{
      client
      | jwt_configuration:
          if(client.jwt_configuration |> is_map,
            do: client.jwt_configuration |> JwtConfiguration.from(),
            else: nil
          ),
        encryption_key:
          if(client.encryption_key |> is_map,
            do: client.encryption_key |> EncryptionKey.from(),
            else: nil
          ),
        addons:
          if(client.addons |> is_map,
            do: client.addons |> Addons.from(),
            else: nil
          ),
        mobile:
          if(client.mobile |> is_map,
            do: client.mobile |> Mobile.from(),
            else: nil
          ),
        native_social_login:
          if(client.native_social_login |> is_map,
            do: client.native_social_login |> NativeSocialLogin.from(),
            else: nil
          ),
        refresh_token:
          if(client.refresh_token |> is_map,
            do: client.refresh_token |> RefreshToken.from(),
            else: nil
          )
    }
  end
end
