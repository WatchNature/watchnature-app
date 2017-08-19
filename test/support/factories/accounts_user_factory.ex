defmodule Watchnature.Accounts.UserFactory do
  defmacro __using__(_opts) do
    quote do
      def accounts_user_factory do
        %Watchnature.Accounts.User{
          email: sequence(:email, &"email-#{&1}@watchnature.co"),
          first_name: "first_name",
          last_name: "last_name",
          password: "123456",
          password_hash: "123456",
          groups: [build(:accounts_group)]
        }
      end
    end
  end
end
