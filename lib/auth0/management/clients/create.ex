defmodule Auth0.Management.Clients.Create do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Util
  alias Auth0.Common.Management.Http

  defmodule Params do
    @moduledoc false
    defmodule JwtConfiguration do
      @moduledoc false
      defstruct lifetime_in_seconds: nil,
                scopes: nil,
                alg: nil

      @type t :: %__MODULE__{
              lifetime_in_seconds: integer,
              scopes: map,
              alg: String.t()
            }
    end

    defmodule EncryptionKey do
      @moduledoc false
      defstruct pub: nil,
                cert: nil,
                subject: nil

      @type t :: %__MODULE__{
              pub: String.t(),
              cert: String.t(),
              subject: String.t()
            }
    end

    defmodule Addons do
      @moduledoc false
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
    end

    defmodule Mobile do
      @moduledoc false
      defmodule Android do
        @moduledoc false
        defstruct app_package_name: nil,
                  sha256_cert_fingerprints: nil

        @type t :: %__MODULE__{
                app_package_name: String.t(),
                sha256_cert_fingerprints: list(String.t())
              }
      end

      defmodule Ios do
        @moduledoc false
        defstruct team_id: nil,
                  app_bundle_identifier: nil

        @type t :: %__MODULE__{
                team_id: String.t(),
                app_bundle_identifier: list(String.t())
              }
      end

      defstruct android: nil,
                ios: nil

      @type t :: %__MODULE__{
              android: Android.t(),
              ios: Ios.t()
            }
    end

    defmodule NativeSocialLogin do
      @moduledoc false
      defstruct apple: nil,
                facebook: nil

      @type t :: %__MODULE__{
              apple: map,
              facebook: map
            }
    end

    defmodule RefreshToken do
      @moduledoc false
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
    end

    defstruct name: nil,
              description: nil,
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
            name: String.t(),
            description: String.t(),
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
  end

  @type endpoint :: String.t()
  @type params :: Params.t() | map()
  @type config :: Config.t()
  @type entity :: list() | map()
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

  @doc """
  Create a client.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Clients/post_clients

  """
  @spec execute(endpoint, params, config) :: response
  def execute(endpoint, %Params{} = params, %Config{} = config) do
    execute(endpoint, params |> Util.to_map(), config)
  end

  def execute(endpoint, %{} = params, %Config{} = config) do
    body = params |> Util.remove_nil()

    Http.post(endpoint, body, config)
    |> case do
      {:ok, 201, body} -> {:ok, body |> Jason.decode!()}
      error -> error
    end
  end
end
