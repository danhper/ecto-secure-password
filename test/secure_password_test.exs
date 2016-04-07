defmodule SecurePasswordTest do
  use ExUnit.Case
  doctest SecurePassword

  import Ecto.Changeset

  test "changeset" do
    changeset = User.changeset %User{}, %{}
    refute changeset.valid?

    changeset = User.changeset %User{}
    refute changeset.valid?

    changeset = User.changeset %User{}, %{}, required: false
    assert changeset.valid?

    changeset = User.changeset %User{}, %{"password" => "a"}
    refute changeset.valid?

    changeset = User.changeset %User{}, %{"password" => "foobar", "password_confirmation" => "foobaz"}
    refute changeset.valid?

    changeset = User.changeset %User{}, %{"password" => "foobar"}
    assert changeset.valid?
    assert get_change(changeset, :password_digest)
    refute get_change(changeset, :password)

    changeset = User.changeset %User{}, %{"password" => "a"}, min_length: 1
    assert changeset.valid?

    changeset = User.changeset %User{}, %{"password" => "foobar", "password_confirmation" => "foobar"}
    assert changeset.valid?

    changeset = User.changeset %User{id: 1}, %{}
    assert changeset.valid?

    changeset = UserWithCustomPK.changeset %UserWithCustomPK{_id: 1}, %{}
    refute changeset.valid?

    changeset = UserWithCustomPK.changeset %UserWithCustomPK{__meta__: %{state: :loaded}}, %{}
    assert changeset.valid?

    changeset = User.changeset %User{id: 1}, %{"password" => "abcdef"}
    assert changeset.valid?
  end

  test "authenticate" do
    changeset = User.changeset %User{}, %{"password" => "foobar"}
    user = %User{password_digest: get_change(changeset, :password_digest)}
    assert User.authenticate(user, "foobar") == user
    refute User.authenticate(user, "foobaz")
    refute User.authenticate(user, nil)
    refute User.authenticate(nil, "whatever")
    refute User.authenticate(%User{}, "whatever")
  end
end
