defmodule Auth0.Management.Organizations.Create do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Util
  alias Auth0.Common.Management.Http
  alias Auth0.Entity.Organization

  defmodule Params do
    @moduledoc false
    defmodule Branding do
      @moduledoc false
      defmodule Colors do
        @moduledoc false
        defstruct primary: nil,
                  page_background: nil

        @type t :: %__MODULE__{
                primary: String.t(),
                page_background: String.t()
              }
      end

      defstruct colors: nil,
                logo_url: nil

      @type t :: %__MODULE__{
              colors: Colors.t(),
              logo_url: String.t()
            }
    end

    defstruct name: nil,
              display_name: nil,
              branding: nil,
              metadata: nil

    @type t :: %__MODULE__{
            name: String.t(),
            display_name: String.t(),
            branding: Branding.t(),
            metadata: map
          }
  end

  @type endpoint :: String.t()
  @type params :: Params.t() | map
  @type config :: Config.t()
  @type entity :: Organization.t()
  @type response_body :: String.t()
  @type response :: {:ok, entity, response_body} | {:error, integer, term} | {:error, term}

  @doc """
  Create an Organization.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Organizations/post_organizations

  """
  @spec execute(endpoint, params, config) :: response
  def execute(endpoint, %Params{} = params, %Config{} = config) do
    execute(endpoint, params |> Util.to_map(), config)
  end

  def execute(endpoint, %{} = params, %Config{} = config) do
    body = params |> Util.remove_nil()

    Http.post(endpoint, body, config)
    |> case do
      {:ok, 201, body} -> {:ok, Organization.from(body |> Jason.decode!()), body}
      error -> error
    end
  end
end
