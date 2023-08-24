defmodule BasicLiveviewWeb.Clock.Updating do
  use BasicLiveviewWeb, :live_view

  # This is where we start to peel back the abstraction a bit. LiveViews are
  # processes, and are an abstraction over a kind of specific common server in
  # Elixir. One of the core concepts in Erlang/Elixir is message sending and
  # receiving between (and within) a process.

  # The biggest thing to know about processes generally is that Erlang/Elixir
  # processes are NOT the same as system processes; they are a million times
  # more lightweight. Spinning up a ton of processes is something we try to
  # avoid elsewhere; in Erlang/Elixir, it's how everything works.

  # Processes send messages back and forth by addressing messages to a process
  # by `pid`, which are process identifiers and are considered primitives in
  # Elixir.

  # The most important thing you need to know is: Live Views are one big
  # process, and the way LiveView (as in the front-end tooling powered by
  # Phoenix) works at its core is via processes. Anything rendered in a Live
  # View can message the parent and vice versa or anything else in the Live View
  # because they are all the same process.

  def mount(_params, _session, socket) do
    if connected?(socket) do
      # let's go ahead and send a message to ourselves to update the time again
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
    The current time is: <%= @current_time %>.
    """
  end

  defp send_delayed_update_time_message(frequency_in_ms \\ 1) do
    # `self()` returns the pid of the process you're in
    sender = self()
    target = self()


    # the format of most messages in Erlang/Elixir is {message_sender, message_type_as_atom, ...rest_of_message}
    message = {sender, :update_time}
    Process.send_after(target, message, frequency_in_ms)
  end
end
