defmodule Auth0.Management.Organizations.Patch do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Util
  alias Auth0.Common.Management.Http

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
  @type id :: String.t()
  @type params :: Params.t() | map
  @type config :: Config.t()
  @type entity :: list() | map()
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

  @doc """
  Modify an Organization.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Organizations/patch_organizations_by_id

  """
  @spec execute(endpoint, id, params, config) :: response
  def execute(endpoint, id, %Params{} = params, %Config{} = config) do
    execute(endpoint, id, params |> Util.to_map(), config)
  end

  def execute(endpoint, id, %{} = params, %Config{} = config) do
    body = params |> Util.remove_nil()

    endpoint
    |> String.replace("{id}", id)
    |> Http.patch(body, config)
    |> case do
      {:ok, 200, body} -> {:ok, body |> Jason.decode!()}
      error -> error
    end
  end
end
