defmodule Rumbl.MultimediaTest do
  use Rumbl.DataCase

  alias Rumbl.Multimedia
  alias Rumbl.Multimedia.Category

  describe "categories" do

    test "list alphabetical categories" do
      for name <- ~w(Action Romance Comedy), do: Multimedia.create_category(name)

      alpha_names = for %Category{name: name} <- Multimedia.list_alphabetical_categories() do
        name
      end

      assert alpha_names == ~w(Action Comedy Romance)
    end
  end

  describe "videos" do
    alias Rumbl.Multimedia.Video

    @valid_attrs %{description: "some description", title: "some title", url: "some url"}
    @invalid_attrs %{description: nil, title: nil, url: nil}


    test "list_videos/0 returns all videos" do
      owner = user_fixture()
      %Video{id: id1} = video_fixture(owner)
      assert [%Video{id: ^id1}] = Multimedia.list_videos()
    end

    test "get_video!/1 returns the video with given id" do
      owner = user_fixture()
      %Video{id: id} = video_fixture(owner)
      assert %Video{id: ^id} = Multimedia.get_video!(id)
    end

    test "create_video/1 with valid data creates a video" do
      owner = user_fixture()
      assert {:ok, %Video{} = video} = Multimedia.create_video(owner, @valid_attrs)
      assert video.description == "some description"
      assert video.title == "some title"
      assert video.url == "some url"
    end

    test "create_video/1 with invalid data returns error changeset" do
      owner = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Multimedia.create_video(owner, @invalid_attrs)
    end

    # test "update_video/2 with valid data updates the video" do
    #   video = video_fixture()
    #   assert {:ok, %Video{} = video} = Multimedia.update_video(video, @update_attrs)
    #   assert video.description == "some updated description"
    #   assert video.title == "some updated title"
    #   assert video.url == "some updated url"
    # end

    # test "update_video/2 with invalid data returns error changeset" do
    #   video = video_fixture()
    #   assert {:error, %Ecto.Changeset{}} = Multimedia.update_video(video, @invalid_attrs)
    #   assert video == Multimedia.get_video!(video.id)
    # end

    # test "delete_video/1 deletes the video" do
    #   video = video_fixture()
    #   assert {:ok, %Video{}} = Multimedia.delete_video(video)
    #   assert_raise Ecto.NoResultsError, fn -> Multimedia.get_video!(video.id) end
    # end

    # test "change_video/1 returns a video changeset" do
    #   video = video_fixture()
    #   assert %Ecto.Changeset{} = Multimedia.change_video(video)
    # end
  end
end
