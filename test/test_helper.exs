defmodule User do
  use Ecto.Schema
  use SecurePassword

  import Ecto.Changeset

  schema "users" do
    has_secure_password
  end

  def changeset(model, params \\ :empty, secure_password_opts \\ []) do
    model
      |> cast(params, [], [])
      |> with_secure_password(secure_password_opts)
  end
end

ExUnit.start()
