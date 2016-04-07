defmodule User do
  use Ecto.Schema
  use SecurePassword

  @param if Map.has_key?(%Ecto.Changeset{}, :data), do: :invalid, else: :empty

  import Ecto.Changeset

  schema "users" do
    has_secure_password
  end

  def changeset(model, params \\ @param, secure_password_opts \\ []) do
    model
      |> cast(params, [], ~w(password))
      |> with_secure_password(secure_password_opts)
  end
end

defmodule UserWithCustomPK do
  use Ecto.Schema
  use SecurePassword

  @param if Map.has_key?(%Ecto.Changeset{}, :data), do: :invalid, else: :empty

  import Ecto.Changeset

  @primary_key {:_id, :id, autogenerate: true}

  schema "users_with_custom_pk" do
    has_secure_password
  end

  def changeset(model, params \\ @param, secure_password_opts \\ []) do
    model
      |> cast(params, [], ~w(password))
      |> with_secure_password(secure_password_opts)
  end
end

ExUnit.start()
