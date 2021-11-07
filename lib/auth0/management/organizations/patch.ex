defmodule Auth0.Management.Organizations.Patch do
  @moduledoc """
  Documentation for Auth0 Management Modify an Organization.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Organizations/patch_organizations_by_id
  """

  alias Auth0.Config
  alias Auth0.Common.Util
  alias Auth0.Common.Management.Http
  alias Auth0.Entity.Organization

  defmodule Params do
    defmodule Branding do
      defmodule Colors do
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
  @type params :: Params.t()
  @type config :: Config.t()
  @type entity :: Organization.t()
  @type response_body :: String.t()
  @type response :: {:ok, entity, response_body} | {:error, integer, term} | {:error, term}

  @doc """
  Modify an Organization.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Organizations/patch_organizations_by_id

  """
  @spec execute(endpoint, id, params, config) :: response
  def execute(endpoint, id, %Params{} = params, %Config{} = config) do
    body = params |> Util.to_map() |> Util.remove_nil()

    endpoint
    |> String.replace("{id}", id)
    |> Http.patch(body, config)
    |> case do
      {:ok, 200, body} -> {:ok, Organization.from(body |> Jason.decode!()), body}
      error -> error
    end
  end
end
