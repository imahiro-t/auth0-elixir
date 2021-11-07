defmodule Auth0.Management.Branding.Patch do
  @moduledoc """
  Documentation for Auth0 Management Update branding settings.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Branding/patch_branding
  """

  alias Auth0.Config
  alias Auth0.Common.Util
  alias Auth0.Common.Management.Http
  alias Auth0.Entity.Branding

  defmodule Params do
    defmodule Colors do
      defstruct primary: nil,
                page_background: nil

      @type t :: %__MODULE__{
              primary: String.t(),
              page_background: String.t()
            }
    end

    defmodule Font do
      defstruct url: nil

      @type t :: %__MODULE__{
              url: String.t()
            }
    end

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
  end

  @type endpoint :: String.t()
  @type params :: Params.t()
  @type config :: Config.t()
  @type entity :: Branding.t()
  @type response_body :: String.t()
  @type response :: {:ok, entity, response_body} | {:error, integer, term} | {:error, term}

  @doc """
  Update branding settings.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Branding/patch_branding

  """
  @spec execute(endpoint, params, config) :: response
  def execute(endpoint, %Params{} = params, %Config{} = config) do
    body = params |> Util.to_map() |> Util.remove_nil()

    Http.patch(endpoint, body, config)
    |> case do
      {:ok, 200, body} -> {:ok, Branding.from(body |> Jason.decode!()), body}
      error -> error
    end
  end
end
