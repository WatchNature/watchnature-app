defmodule Watchnature.Accounts.GroupFactory do
  defmacro __using__(_opts) do
    quote do
      def accounts_group_factory do
        %Watchnature.Accounts.Group{
          name: sequence(:name, &"group-#{&1}"),
        }
      end
    end
  end
end
