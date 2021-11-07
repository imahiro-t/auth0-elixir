defmodule Auth0.Entity.Action do
  @moduledoc """
  Documentation for entity of Action.

  """

  defmodule SupportedTrigger do
    @moduledoc """
    Documentation for entity of Action SupportedTrigger.

    """

    alias Auth0.Common.Util

    defstruct id: nil,
              version: nil

    @type t :: %__MODULE__{
            id: String.t(),
            version: String.t()
          }

    @spec from(map) :: __MODULE__.t()
    def from(value) do
      value |> Util.to_struct(__MODULE__)
    end
  end

  defmodule Dependency do
    @moduledoc """
    Documentation for entity of Action Dependency.

    """

    alias Auth0.Common.Util

    defstruct name: nil,
              version: nil

    @type t :: %__MODULE__{
            name: String.t(),
            version: String.t()
          }

    @spec from(map) :: __MODULE__.t()
    def from(value) do
      value |> Util.to_struct(__MODULE__)
    end
  end

  defmodule Secret do
    @moduledoc """
    Documentation for entity of Action Secret.

    """

    alias Auth0.Common.Util

    defstruct name: nil,
              updated_at: nil

    @type t :: %__MODULE__{
            name: String.t(),
            updated_at: String.t()
          }

    @spec from(map) :: __MODULE__.t()
    def from(value) do
      value |> Util.to_struct(__MODULE__)
    end
  end

  defmodule Integration do
    @moduledoc """
    Documentation for entity of Action Integration.

    """

    alias Auth0.Common.Util

    defstruct id: nil,
              catalog_id: nil,
              url_slug: nil,
              partner_id: nil,
              name: nil,
              description: nil,
              short_description: nil,
              logo: nil,
              feature_type: nil,
              terms_of_use_url: nil,
              privacy_policy_url: nil,
              public_support_link: nil,
              current_release: nil,
              created_at: nil,
              updated_at: nil

    @type t :: %__MODULE__{
            id: String.t(),
            catalog_id: String.t(),
            url_slug: String.t(),
            partner_id: String.t(),
            name: String.t(),
            description: String.t(),
            short_description: String.t(),
            logo: String.t(),
            feature_type: String.t(),
            terms_of_use_url: String.t(),
            privacy_policy_url: String.t(),
            public_support_link: String.t(),
            current_release: map,
            created_at: String.t(),
            updated_at: String.t()
          }

    @spec from(map) :: __MODULE__.t()
    def from(value) do
      value |> Util.to_struct(__MODULE__)
    end
  end

  alias Auth0.Common.Util
  alias Auth0.Entity.ActionVersion

  defstruct id: nil,
            name: nil,
            supported_triggers: nil,
            code: nil,
            dependencies: nil,
            runtime: nil,
            secrets: nil,
            current_version: nil,
            deployed_version: nil,
            installed_integration_id: nil,
            integration: nil,
            status: nil,
            all_changes_deployed: nil,
            built_at: nil,
            created_at: nil,
            updated_at: nil

  @type t :: %__MODULE__{
          id: String.t(),
          name: String.t(),
          supported_triggers: list(SupportedTrigger.t()),
          code: String.t(),
          dependencies: list(Dependency.t()),
          runtime: String.t(),
          secrets: list(Secret.t()),
          current_version: ActionVersion.t() | nil,
          deployed_version: ActionVersion.t() | nil,
          installed_integration_id: String.t(),
          integration: Integration.t(),
          status: String.t(),
          all_changes_deployed: boolean,
          built_at: String.t(),
          created_at: String.t(),
          updated_at: String.t()
        }

  @spec from(map) :: __MODULE__.t()
  def from(value) do
    action = value |> Util.to_struct(__MODULE__)

    %{
      action
      | supported_triggers:
          if(action.supported_triggers |> is_list,
            do: action.supported_triggers |> Enum.map(&SupportedTrigger.from/1),
            else: nil
          ),
        dependencies:
          if(action.dependencies |> is_list,
            do: action.dependencies |> Enum.map(&Dependency.from/1),
            else: nil
          ),
        secrets:
          if(action.secrets |> is_list,
            do: action.secrets |> Enum.map(&Secret.from/1),
            else: nil
          ),
        current_version:
          if(action.current_version |> is_map,
            do: action.current_version |> ActionVersion.from(),
            else: nil
          ),
        deployed_version:
          if(action.deployed_version |> is_map,
            do: action.deployed_version |> ActionVersion.from(),
            else: nil
          ),
        integration:
          if(action.integration |> is_map,
            do: action.integration |> Integration.from(),
            else: nil
          )
    }
  end
end
