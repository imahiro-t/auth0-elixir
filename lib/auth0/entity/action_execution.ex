defmodule Auth0.Entity.ActionExecution do
  @moduledoc """
  Documentation for entity of ActionExecution.

  """

  defmodule Result do
    @moduledoc """
    Documentation for entity of ActionExecution Result.

    """
    defmodule Response do
      @moduledoc """
      Documentation for entity of ActionExecution Result.

      """
      defmodule Stats do
        @moduledoc """
        Documentation for entity of ActionExecution Result.

        """

        alias Auth0.Common.Util

        defstruct total_request_duration_ms: nil,
                  total_runtime_execution_duration_ms: nil,
                  runtime_processing_duration_ms: nil,
                  action_duration_ms: nil,
                  runtime_external_call_duration_ms: nil,
                  boot_duration_ms: nil,
                  network_duration_ms: nil

        @type t :: %__MODULE__{
                total_request_duration_ms: integer,
                total_runtime_execution_duration_ms: integer,
                runtime_processing_duration_ms: integer,
                action_duration_ms: integer,
                runtime_external_call_duration_ms: integer,
                boot_duration_ms: integer,
                network_duration_ms: integer
              }

        @spec from(map) :: __MODULE__.t()
        def from(value) do
          value |> Util.to_struct(__MODULE__)
        end
      end

      alias Auth0.Common.Util

      defstruct stats: nil

      @type t :: %__MODULE__{
              stats: Stats.t()
            }

      @spec from(map) :: __MODULE__.t()
      def from(value) do
        response = value |> Util.to_struct(__MODULE__)

        %{
          response
          | stats:
              if(response.stats |> is_map,
                do: response.stats |> Stats.from(),
                else: nil
              )
        }
      end
    end

    alias Auth0.Common.Util

    defstruct action_name: nil,
              binding_id: nil,
              version_id: nil,
              response: nil,
              started_at: nil,
              ended_at: nil

    @type t :: %__MODULE__{
            action_name: String.t(),
            binding_id: String.t(),
            version_id: String.t(),
            response: Response.t(),
            started_at: String.t(),
            ended_at: String.t()
          }

    @spec from(map) :: __MODULE__.t()
    def from(value) do
      result = value |> Util.to_struct(__MODULE__)

      %{
        result
        | response:
            if(result.response |> is_map,
              do: result.response |> Response.from(),
              else: nil
            )
      }
    end
  end

  alias Auth0.Common.Util

  defstruct id: nil,
            trigger_id: nil,
            status: nil,
            results: nil,
            created_at: nil,
            updated_at: nil

  @type t :: %__MODULE__{
          id: String.t(),
          trigger_id: String.t(),
          status: String.t(),
          results: list(Result.t()),
          created_at: String.t(),
          updated_at: String.t()
        }

  @spec from(map) :: __MODULE__.t()
  def from(value) do
    execution = value |> Util.to_struct(__MODULE__)

    %{
      execution
      | results:
          if(execution.results |> is_list,
            do: execution.results |> Enum.map(&Result.from/1),
            else: nil
          )
    }
  end
end
