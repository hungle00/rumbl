defmodule RumblWeb.UserSocket do
  use Phoenix.Socket

  ## Channels
  channel "videos:*", RumblWeb.VideoChannel

  @max_age 2 * 7 * 24 * 60 * 60
  @impl true
  def connect(%{"token" => token}, socket) do
    case Phoenix.Token.verify(socket, "user socket", token, max_age: @max_age) do
      {:ok, user_id} ->
        {:ok, assign(socket, :user_id, user_id)}
      {:error, _reason} ->
        :error
    end
  end

  def connect(_params, _socket), do: :error

  @impl true
  def id(socket), do: "users_socket:#{socket.assigns.user_id}"

  # Socket id's are topics that allow you to identify all sockets for a given user
  #
  # Would allow you to broadcast a "disconnect" event and terminate
  # all active sockets and channels for a given user:
  #
  #     RumblWeb.Endpoint.broadcast("user_socket:#{user.id}", "disconnect", %{})
  #
  # Returning `nil` makes this socket anonymous.
end
