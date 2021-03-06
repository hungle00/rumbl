defmodule Rumbl.Accounts.User do
  use Ecto.Schema

  import Ecto.Changeset

  alias Rumbl.Accounts.Credential

  schema "users" do
    field :name, :string
    field :username, :string
    has_one :credential, Credential
    has_many :videos, Rumbl.Multimedia.Video

    timestamps()
  end

  def registration_changeset(user, params) do
    user
    |> changeset(params)
    |> cast_assoc(:credential, with: &Credential.changeset/2, required: true)
    |> unique_constraint(:username)
  end

  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :username])
    |> validate_required([:name, :username])
    |> validate_length(:username, min: 1, max: 20)
  end

end
