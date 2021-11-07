defmodule Auth0.Entity.Branding do
  @moduledoc """
  Documentation for entity of Branding.

  """

  defmodule Colors do
    @moduledoc """
    Documentation for entity of Branding Colors.

    """

    alias Auth0.Common.Util

    defstruct primary: nil,
              page_background: nil

    @type t :: %__MODULE__{
            primary: String.t(),
            page_background: String.t()
          }

    @spec from(map) :: __MODULE__.t()
    def from(value) do
      value |> Util.to_struct(__MODULE__)
    end
  end

  defmodule Font do
    @moduledoc """
    Documentation for entity of Branding Font.

    """

    alias Auth0.Common.Util

    defstruct url: nil

    @type t :: %__MODULE__{
            url: String.t()
          }

    @spec from(map) :: __MODULE__.t()
    def from(value) do
      value |> Util.to_struct(__MODULE__)
    end
  end

  alias Auth0.Common.Util

  defstruct colors: nil,
            favicon_url: nil,
            logo_url: nil,
            font: nil

  @type t :: %__MODULE__{
          colors: Colors.t(),
          favicon_url: String.t(),
          logo_url: String.t(),
          font: Font.t()
        }

  @spec from(map) :: __MODULE__.t()
  def from(value) do
    branding = value |> Util.to_struct(__MODULE__)

    %{
      branding
      | colors:
          if(branding.colors |> is_map,
            do: branding.colors |> Colors.from(),
            else: nil
          ),
        font:
          if(branding.font |> is_map,
            do: branding.font |> Font.from(),
            else: nil
          )
    }
  end
end
