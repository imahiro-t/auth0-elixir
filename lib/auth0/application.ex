defmodule Auth0.Application do
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      Auth0.Common.Management.TokenManager.Store
    ]

    Supervisor.start_link(children, strategy: :one_for_one, name: Auth0.Supervisor)
  end
end
