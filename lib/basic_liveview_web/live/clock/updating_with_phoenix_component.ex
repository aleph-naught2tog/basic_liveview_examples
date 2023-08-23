defmodule BasicLiveviewWeb.Clock.UpdatingWithPhoenixComponent do
  use BasicLiveviewWeb, :live_view

  import BasicLiveviewWeb.Clock

  def mount(_params, _session, socket) do
    if connected?(socket) do
      send_delayed_update_time_message()
    end

    updated_socket =
      socket
      |> assign(:current_time, Time.utc_now())

    {:ok, updated_socket}
  end

  # `handle_info` is for handling _messages_
  def handle_info({_sender, :update_time}, socket) do
    send_delayed_update_time_message()

    {:noreply, socket |> assign(:current_time, Time.utc_now())}
  end

  def render(assigns) do
    ~H"""
    <.clock current_time={@current_time}>
      <:header>
        <b>The time is now:</b>
      </:header>

      Today is <%= Date.utc_today() %>.
    </.clock>
    """
  end

  defp send_delayed_update_time_message(frequency_in_ms \\ 1) do
    sender = self()
    target = self()

    message = {sender, :update_time}
    Process.send_after(target, message, frequency_in_ms)
  end
end
