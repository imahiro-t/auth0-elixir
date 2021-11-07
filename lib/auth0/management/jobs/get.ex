defmodule Auth0.Management.Jobs.Get do
  @moduledoc """
  Documentation for Auth0 Management Get a job.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Jobs/get_jobs_by_id
  """

  alias Auth0.Config
  alias Auth0.Common.Management.Http
  alias Auth0.Entity.Jobs

  @type endpoint :: String.t()
  @type id :: String.t()
  @type config :: Config.t()
  @type entity :: Jobs.t()
  @type response_body :: String.t()
  @type response :: {:ok, entity, response_body} | {:error, integer, term} | {:error, term}

  @doc """
  Get a job.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Jobs/get_jobs_by_id

  """
  @spec execute(endpoint, id, config) :: response
  def execute(endpoint, id, %Config{} = config) do
    endpoint
    |> String.replace("{id}", id)
    |> Http.get(config)
    |> case do
      {:ok, 200, body} -> {:ok, Jobs.from(body |> Jason.decode!()), body}
      error -> error
    end
  end
end
