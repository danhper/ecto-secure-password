# ecto-secure-password [![Build Status](https://travis-ci.org/tuvistavie/ecto-secure-password.svg)](https://travis-ci.org/tuvistavie/ecto-secure-password) [![Hex Version](http://img.shields.io/hexpm/v/secure_password.svg?style=flat)](https://hex.pm/packages/secure_password) [![Hex docs](http://img.shields.io/badge/hex.pm-docs-green.svg?style=flat)](https://hexdocs.pm/secure_password/SecurePassword.html)


A port of Rails [has_secure_password](http://api.rubyonrails.org/classes/ActiveModel/SecurePassword/ClassMethods.html) for [Ecto](https://github.com/elixir-lang/ecto) models.

The full documentation is available at http://hexdocs.pm/secure_password/SecurePassword.html

## Installation

1. Add `secure_password` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [{:secure_password, "~> 0.1.0"}]
end
```

2. Ensure `secure_password` is started before your application:

```elixir
  def application do
    [applications: [:secure_password]]
  end
```

## Usage

### Setup the model

To use `secure_password`, you need to

1. Add `use SecurePassword` to your model
2. Add `has_secure_password` to your schema
3. Add `with_secure_password` to your changeset

Here is an example user module.

```elixir
defmodule User do
  use Ecto.Schema
  use SecurePassword

  import Ecto.Changeset

  schema "users" do
    field :email, :string
    field :name, :string

    has_secure_password
  end

  @required_fields ~w(email)
  @optional_fields ~w(name)

  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> with_secure_password(min_length: 8)
  end
end
```

### Authenticate

To authenticate the model, you just need to call `Model.authenticate`.
It will return the user struct when the password is valid, and `false` otherwise.

```elixir
if user = User.authenticate(MyRepo.get(User, 1), params["password"]) do
  # do something
else
  # you are not authenticated
end
```

## Testing

This library uses [https://github.com/elixircnx/comeonin](comeonin) to hash passwords.
To avoid slowing down the tests, you can add the following to your `config/test.exs`.

```elixir
config :comeonin, :bcrypt_log_rounds, 4
config :comeonin, :pbkdf2_rounds, 1
```
