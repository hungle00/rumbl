defmodule Rumbl.AccountsTest do
  use Rumbl.DataCase

  alias Rumbl.Accounts
  alias Rumbl.Accounts.User

  describe "register_user/1" do
    alias Rumbl.Accounts.Credential

    @valid_attrs %{
      name: "steve",
      username: "steve lee",
      credential: %{email: "steve@email.com", password: "009933"}
    }
    @invalid_attrs %{email: nil, password_hash: nil}

    test "with valid data user" do
      assert {:ok, %User{id: id} = user} = Accounts.register_user(@valid_attrs)
      assert user.name == "steve"
      assert user.username == "steve lee"
    end

    test "with invalid data does not insert user" do
      assert {:error, _changeset} = Accounts.register_user(@invalid_attrs)
    end
  end
end
