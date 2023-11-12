defmodule Auth0.Management.Organizations.Invitations.Get do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Util
  alias Auth0.Common.Management.Http
  alias Auth0.Entity.Invitation

  defmodule Params do
    @moduledoc false
    defstruct fields: nil,
              include_fields: nil

    @type t :: %__MODULE__{
            fields: String.t(),
            include_fields: boolean
          }
  end

  @type endpoint :: String.t()
  @type id :: String.t()
  @type invitation_id :: String.t()
  @type params :: Params.t() | map
  @type config :: Config.t()
  @type entity :: Invitation.t()
  @type response_body :: String.t()
  @type response :: {:ok, entity, response_body} | {:error, integer, term} | {:error, term}

  @doc """
  Get an invitation to organization.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Organizations/get_invitations_by_invitation_id

  """
  @spec execute(endpoint, id, invitation_id, params, config) :: response
  def execute(endpoint, id, invitation_id, %Params{} = params, %Config{} = config) do
    execute(endpoint, id, invitation_id, params |> Util.to_map(), config)
  end

  def execute(endpoint, id, invitation_id, %{} = params, %Config{} = config) do
    params
    |> Util.convert_to_query()
    |> Util.append_query(
      endpoint
      |> String.replace("{id}", id)
      |> String.replace("{invitation_id}", invitation_id)
    )
    |> Http.get(config)
    |> case do
      {:ok, 200, body} -> {:ok, Invitation.from(body |> Jason.decode!()), body}
      error -> error
    end
  end
end
