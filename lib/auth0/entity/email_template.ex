defmodule Auth0.Entity.EmailTemplate do
  @moduledoc false

  alias Auth0.Common.Util

  defstruct template: nil,
            body: nil,
            from: nil,
            resultUrl: nil,
            subject: nil,
            syntax: nil,
            urlLifetimeInSeconds: nil,
            includeEmailInRedirect: nil,
            enabled: nil

  @type t :: %__MODULE__{
          template: String.t(),
          body: String.t(),
          from: String.t(),
          resultUrl: String.t(),
          subject: String.t(),
          syntax: String.t(),
          urlLifetimeInSeconds: integer,
          includeEmailInRedirect: boolean,
          enabled: boolean
        }

  @spec from(map) :: __MODULE__.t()
  def from(value) do
    value |> Util.to_struct(__MODULE__)
  end
end
