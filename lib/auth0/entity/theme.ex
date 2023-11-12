defmodule Auth0.Entity.Theme do
  @moduledoc false

  defmodule Borders do
    @moduledoc false

    alias Auth0.Common.Util

    defstruct button_border_radius: nil,
              button_border_weight: nil,
              buttons_style: nil,
              input_border_radius: nil,
              input_border_weight: nil,
              inputs_style: nil,
              show_widget_shadow: nil,
              widget_border_weight: nil,
              widget_corner_radius: nil

    @type t :: %__MODULE__{
            button_border_radius: integer,
            button_border_weight: integer,
            buttons_style: String.t(),
            input_border_radius: integer,
            input_border_weight: integer,
            inputs_style: String.t(),
            show_widget_shadow: boolean,
            widget_border_weight: integer,
            widget_corner_radius: integer
          }

    @spec from(map) :: __MODULE__.t()
    def from(value) do
      value |> Util.to_struct(__MODULE__)
    end
  end

  defmodule Colors do
    @moduledoc false

    alias Auth0.Common.Util

    defstruct base_focus_color: nil,
              base_hover_color: nil,
              body_text: nil,
              error: nil,
              header: nil,
              icons: nil,
              input_background: nil,
              input_border: nil,
              input_filled_text: nil,
              input_labels_placeholders: nil,
              links_focused_components: nil,
              primary_button: nil,
              primary_button_label: nil,
              secondary_button_border: nil,
              secondary_button_label: nil,
              success: nil,
              widget_background: nil,
              widget_border: nil

    @type t :: %__MODULE__{
            base_focus_color: String.t(),
            base_hover_color: String.t(),
            body_text: String.t(),
            error: String.t(),
            header: String.t(),
            icons: String.t(),
            input_background: String.t(),
            input_border: String.t(),
            input_filled_text: String.t(),
            input_labels_placeholders: String.t(),
            links_focused_components: String.t(),
            primary_button: String.t(),
            primary_button_label: String.t(),
            secondary_button_border: String.t(),
            secondary_button_label: String.t(),
            success: String.t(),
            widget_background: String.t(),
            widget_border: String.t()
          }

    @spec from(map) :: __MODULE__.t()
    def from(value) do
      value |> Util.to_struct(__MODULE__)
    end
  end

  defmodule Fonts do
    @moduledoc false

    defmodule Style do
      @moduledoc false

      alias Auth0.Common.Util

      defstruct bold: nil,
                size: nil

      @type t :: %__MODULE__{
              bold: boolean,
              size: integer
            }

      @spec from(map) :: __MODULE__.t()
      def from(value) do
        value |> Util.to_struct(__MODULE__)
      end
    end

    alias Auth0.Common.Util

    defstruct body_text: nil,
              buttons_text: nil,
              font_url: nil,
              input_labels: nil,
              links: nil,
              links_style: nil,
              reference_text_size: nil,
              subtitle: nil,
              title: nil

    @type t :: %__MODULE__{
            body_text: Style.t(),
            buttons_text: Style.t(),
            font_url: String.t(),
            input_labels: Style.t(),
            links: Style.t(),
            links_style: String.t(),
            reference_text_size: integer,
            subtitle: Style.t(),
            title: Style.t()
          }

    @spec from(map) :: __MODULE__.t()
    def from(value) do
      fonts = value |> Util.to_struct(__MODULE__)

      %{
        fonts
        | body_text:
            if(fonts.body_text |> is_map,
              do: fonts.body_text |> Style.from(),
              else: nil
            ),
          buttons_text:
            if(fonts.buttons_text |> is_map,
              do: fonts.buttons_text |> Style.from(),
              else: nil
            ),
          input_labels:
            if(fonts.input_labels |> is_map,
              do: fonts.input_labels |> Style.from(),
              else: nil
            ),
          links:
            if(fonts.links |> is_map,
              do: fonts.links |> Style.from(),
              else: nil
            ),
          subtitle:
            if(fonts.subtitle |> is_map,
              do: fonts.subtitle |> Style.from(),
              else: nil
            ),
          title:
            if(fonts.title |> is_map,
              do: fonts.title |> Style.from(),
              else: nil
            )
      }
    end
  end

  defmodule PageBackground do
    @moduledoc false

    alias Auth0.Common.Util

    defstruct background_color: nil,
              background_image_url: nil,
              page_layout: nil

    @type t :: %__MODULE__{
            background_color: String.t(),
            background_image_url: String.t(),
            page_layout: String.t()
          }

    @spec from(map) :: __MODULE__.t()
    def from(value) do
      value |> Util.to_struct(__MODULE__)
    end
  end

  defmodule Widget do
    @moduledoc false

    alias Auth0.Common.Util

    defstruct header_text_alignment: nil,
              logo_height: nil,
              logo_position: nil,
              logo_url: nil,
              social_buttons_layout: nil

    @type t :: %__MODULE__{
            header_text_alignment: String.t(),
            logo_height: integer,
            logo_position: String.t(),
            logo_url: String.t(),
            social_buttons_layout: String.t()
          }

    @spec from(map) :: __MODULE__.t()
    def from(value) do
      value |> Util.to_struct(__MODULE__)
    end
  end

  alias Auth0.Common.Util

  defstruct borders: nil,
            colors: nil,
            displayName: nil,
            fonts: nil,
            page_background: nil,
            themeId: nil,
            widget: nil

  @type t :: %__MODULE__{
          borders: Borders.t(),
          colors: Colors.t(),
          displayName: String.t(),
          fonts: Fonts.t(),
          page_background: PageBackground.t(),
          themeId: String.t(),
          widget: Widget.t()
        }

  @spec from(map) :: __MODULE__.t()
  def from(value) do
    theme = value |> Util.to_struct(__MODULE__)

    %{
      theme
      | borders:
          if(theme.borders |> is_map,
            do: theme.borders |> Borders.from(),
            else: nil
          ),
        colors:
          if(theme.colors |> is_map,
            do: theme.colors |> Colors.from(),
            else: nil
          ),
        fonts:
          if(theme.fonts |> is_map,
            do: theme.fonts |> Fonts.from(),
            else: nil
          ),
        page_background:
          if(theme.page_background |> is_map,
            do: theme.page_background |> PageBackground.from(),
            else: nil
          ),
        widget:
          if(theme.widget |> is_map,
            do: theme.widget |> Widget.from(),
            else: nil
          )
    }
  end
end
