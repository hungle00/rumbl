defmodule RumblWeb.VideoChannel do
  alias Rumbl.Accounts
  use RumblWeb, :channel

  def join("videos:" <> video_id, _params, socket) do
    {:ok, assign(socket, :video_id, String.to_integer(video_id))}
    #:timer.send_interval(5_000, :ping)
    {:ok, socket}
  end

  def handle_in(event, params, socket) do
    user = Accounts.get_user!(socket.assigns.user_id)
    handle_in(event, params, user, socket)
  end

  def handle_info(:ping, socket) do
    count = socket.assigns[:count] || 1
    push(socket, "ping", %{count: count})
    {:noreply, assign(socket, :count, count + 1)}
  end

  def handle_in("new_annotation", params, user, socket) do
    broadcast!(socket, "new_annotation", %{
      user: %{username: user.username},
      body: params["body"],
      at: params["at"]
    })
    {:reply, :ok, socket}
  end
end
