defmodule Auth0.Entity.Organization do
  @moduledoc """
  Documentation for entity of Organization.

  """

  alias Auth0.Common.Util
  alias Auth0.Entity.Branding

  defstruct id: nil,
            name: nil,
            display_name: nil,
            branding: nil,
            metadata: nil

  @type t :: %__MODULE__{
          id: String.t(),
          name: String.t(),
          display_name: String.t(),
          branding: Branding.t(),
          metadata: map
        }

  @spec from(map) :: __MODULE__.t()
  def from(value) do
    organization = value |> Util.to_struct(__MODULE__)

    if organization.branding |> is_map do
      %{organization | branding: organization.branding |> Branding.from()}
    else
      organization
    end
  end
end
