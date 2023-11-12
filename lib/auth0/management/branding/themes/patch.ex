defmodule Auth0.Management.Branding.Themes.Patch do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Util
  alias Auth0.Common.Management.Http
  alias Auth0.Entity.Theme

  defmodule Params do
    @moduledoc false
    defmodule Borders do
      @moduledoc false
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
    end

    defmodule Colors do
      @moduledoc false
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
    end

    defmodule Fonts do
      @moduledoc false
      defmodule Style do
        @moduledoc false
        defstruct bold: nil,
                  size: nil

        @type t :: %__MODULE__{
                bold: boolean,
                size: integer
              }
      end

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
    end

    defmodule PageBackground do
      @moduledoc false
      defstruct background_color: nil,
                background_image_url: nil,
                page_layout: nil

      @type t :: %__MODULE__{
              background_color: String.t(),
              background_image_url: String.t(),
              page_layout: String.t()
            }
    end

    defmodule Widget do
      @moduledoc false
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
    end

    defstruct borders: nil,
              colors: nil,
              displayName: nil,
              fonts: nil,
              page_background: nil,
              widget: nil

    @type t :: %__MODULE__{
            borders: Borders.t(),
            colors: Colors.t(),
            displayName: String.t(),
            fonts: Fonts.t(),
            page_background: PageBackground.t(),
            widget: Widget.t()
          }
  end

  @type endpoint :: String.t()
  @type theme_id :: String.t()
  @type params :: Params.t() | map()
  @type config :: Config.t()
  @type entity :: Theme.t()
  @type response_body :: String.t()
  @type response :: {:ok, entity, response_body} | {:error, integer, term} | {:error, term}

  @doc """
  Update branding theme.

  ## see
  https://auth0.com/docs/api/management/v2#!/Branding/patch_branding_theme

  """
  @spec execute(endpoint, theme_id, params, config) :: response
  def execute(endpoint, theme_id, %Params{} = params, %Config{} = config) do
    execute(endpoint, theme_id, params |> Util.to_map(), config)
  end

  def execute(endpoint, theme_id, %{} = params, %Config{} = config) do
    body = params |> Util.remove_nil()

    endpoint
    |> String.replace("{themeId}", theme_id)
    |> Http.patch(body, config)
    |> case do
      {:ok, 200, body} -> {:ok, Theme.from(body |> Jason.decode!()), body}
      error -> error
    end
  end
end
