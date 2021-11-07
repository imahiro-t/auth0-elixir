defmodule Auth0.Entity.ActionVersion do
  @moduledoc """
  Documentation for entity of ActionVersion.

  """

  defmodule Dependency do
    @moduledoc """
    Documentation for entity of ActionVersion Dependency.

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

  alias Auth0.Common.Util
  alias Auth0.Entity.Action

  defstruct id: nil,
            action_id: nil,
            code: nil,
            runtime: nil,
            number: nil,
            deployed: nil,
            dependencies: nil,
            secrets: nil,
            status: nil,
            created_at: nil,
            updated_at: nil,
            built_at: nil,
            build_time: nil,
            errors: nil,
            action: nil

  @type t :: %__MODULE__{
          id: String.t(),
          action_id: String.t(),
          code: String.t(),
          runtime: String.t(),
          number: integer,
          deployed: boolean,
          dependencies: list(Dependency.t()),
          secrets: list(Secret.t()),
          status: String.t(),
          created_at: String.t(),
          updated_at: String.t(),
          built_at: String.t(),
          build_time: String.t(),
          errors: list(map),
          action: Action.t()
        }

  @spec from(map) :: __MODULE__.t()
  def from(value) do
    action_version = value |> Util.to_struct(__MODULE__)

    %{
      action_version
      | dependencies:
          if(action_version.dependencies |> is_list,
            do: action_version.dependencies |> Enum.map(&Dependency.from/1),
            else: nil
          ),
        secrets:
          if(action_version.secrets |> is_list,
            do: action_version.secrets |> Enum.map(&Secret.from/1),
            else: nil
          ),
        action:
          if(action_version.action |> is_map,
            do: action_version.action |> Action.from(),
            else: nil
          )
    }
  end
end
