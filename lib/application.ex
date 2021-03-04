defmodule Astreu.Application do
  @moduledoc false
  use Application

  @impl true
  def start(_type, _args) do
    Node.set_cookie(String.to_atom("astreu"))

    Astreu.Server.Http.Metrics.Setup.setup()
    Astreu.Core.Supervisor.start_link([])
  end
end
