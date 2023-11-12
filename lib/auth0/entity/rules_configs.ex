defmodule Auth0.Entity.RulesConfigs do
  @moduledoc false

  alias Auth0.Common.Util
  alias Auth0.Entity.RulesConfig

  defstruct rules_configs: []

  @type t :: %__MODULE__{
          rules_configs: list(RulesConfig.t())
        }

  @spec from(list) :: __MODULE__.t()
  def from(value) when value |> is_list do
    %{
      rules_configs: value |> Enum.map(&RulesConfig.from/1)
    }
    |> Util.to_struct(__MODULE__)
  end
end
