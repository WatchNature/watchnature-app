defmodule Watchnature.IntegrationCase do
  @moduledoc """
  A case template for integration tests using Hound.
  """

  use ExUnit.CaseTemplate

  using do
    quote do
      use Hound.Helpers

      import Ecto
      import Ecto.Query, only: [from: 2]
      import Watchnature.Router.Helpers

      alias Watchnature.Repo

      # The default endpoint for testing
      @endpoint Watchnature.Endpoint

      @moduletag :integration

      hound_session()
    end
  end

  setup_all do
        :ok = Watchnature.PhantomJS.start
        :ok
  end

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Watchnature.Repo)
    Ecto.Adapters.SQL.Sandbox.mode(Watchnature.Repo, {:shared, self()})
    :ok
  end
end
