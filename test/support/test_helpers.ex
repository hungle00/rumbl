defmodule Rumbl.TestHelpers do
  alias Rumbl.{Accounts, Multimedia}

  def user_fixture(attrs \\ %{}) do
    username = "username#{:rand.uniform(100)}"
    {:ok, user} =
      attrs
      |> Enum.into(%{
        name: "steve lee",
        username: username,
        credential: %{
          email: attrs[:email] || "#{username}@email.com",
          password: attrs[:password] || "hungle0000"
        }
      })
      |> Accounts.register_user()
    user
  end

  def video_fixture(%Accounts.User{} = user, attrs \\ %{}) do
    attrs =
      Enum.into(attrs, %{
        title: "First Video",
        url: "https://youtu.be/tV7APwv68tY",
        description: "a description"
      })
      {:ok, video} = Multimedia.create_video(user, attrs)
    video
  end
end
