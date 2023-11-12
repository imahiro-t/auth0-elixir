defmodule Auth0.Entity.ActionVersions do
  @moduledoc false

  alias Auth0.Common.Util
  alias Auth0.Entity.ActionVersion

  defstruct total: nil,
            page: nil,
            per_page: nil,
            versions: []

  @type t :: %__MODULE__{
          total: integer,
          page: integer,
          per_page: integer,
          versions: list(ActionVersion.t())
        }

  @spec from(map) :: __MODULE__.t()
  def from(value) when value |> is_map do
    versions = value |> Util.to_struct(__MODULE__)

    if versions.versions |> is_list do
      %{
        versions
        | versions: versions.versions |> Enum.map(&ActionVersion.from/1)
      }
    else
      versions
    end
  end
end
