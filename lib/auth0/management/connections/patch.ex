defmodule Auth0.Management.Connections.Patch do
  @moduledoc """
  Documentation for Auth0 Management Update a connection.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Connections/patch_connections_by_id
  """

  alias Auth0.Config
  alias Auth0.Common.Util
  alias Auth0.Common.Management.Http
  alias Auth0.Entity.Connection

  defmodule Params do
    defmodule Options do
      defstruct validation: nil,
                non_persistent_attrs: nil,
                enabledDatabaseCustomization: nil,
                import_mode: nil,
                customScripts: nil,
                passwordPolicy: nil,
                password_complexity_options: nil,
                password_history: nil,
                password_no_personal_info: nil,
                password_dictionary: nil,
                api_enable_users: nil,
                basic_profile: nil,
                ext_admin: nil,
                ext_is_suspended: nil,
                ext_agreed_terms: nil,
                ext_groups: nil,
                ext_assigned_plans: nil,
                ext_profile: nil,
                upstream_params: nil,
                set_user_root_attributes: nil,
                gateway_authentication: nil

      @type t :: %__MODULE__{
              validation: map,
              non_persistent_attrs: list(String.t()),
              enabledDatabaseCustomization: boolean,
              import_mode: boolean,
              customScripts: map,
              passwordPolicy: String.t(),
              password_complexity_options: map,
              password_history: map,
              password_no_personal_info: map,
              password_dictionary: map,
              api_enable_users: boolean,
              basic_profile: boolean,
              ext_admin: boolean,
              ext_is_suspended: boolean,
              ext_agreed_terms: boolean,
              ext_groups: boolean,
              ext_assigned_plans: boolean,
              ext_profile: boolean,
              upstream_params: map,
              set_user_root_attributes: map,
              gateway_authentication: map
            }
    end

    defstruct display_name: nil,
              options: nil,
              enabled_clients: nil,
              realms: nil,
              is_domain_connection: nil,
              metadata: nil

    @type t :: %__MODULE__{
            display_name: String.t(),
            options: Options.t(),
            enabled_clients: list(String.t()),
            realms: list(String.t()),
            is_domain_connection: boolean,
            metadata: map
          }
  end

  @type endpoint :: String.t()
  @type id :: String.t()
  @type params :: Params.t() | map()
  @type config :: Config.t()
  @type entity :: Connection.t()
  @type response_body :: String.t()
  @type response :: {:ok, entity, response_body} | {:error, integer, term} | {:error, term}

  @doc """
  Update a connection.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Connections/patch_connections_by_id

  """
  @spec execute(endpoint, id, params, config) :: response
  def execute(endpoint, id, %Params{} = params, %Config{} = config) do
    execute(endpoint, id, params |> Util.to_map(), config)
  end

  def execute(endpoint, id, %{} = params, %Config{} = config) do
    body = params |> Util.remove_nil()

    endpoint
    |> String.replace("{id}", id)
    |> Http.patch(body, config)
    |> case do
      {:ok, 200, body} -> {:ok, Connection.from(body |> Jason.decode!()), body}
      error -> error
    end
  end
end
