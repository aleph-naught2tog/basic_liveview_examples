defmodule BasicLiveviewWeb.Clock.Boring do
  # This is the line that sets up everything you need for this to act as a live view.
  use BasicLiveviewWeb, :live_view

  # Docs: https://hexdocs.pm/phoenix_live_view/Phoenix.LiveView.html

  # This runs once, on load. Use this to fetch and set up any initial data, and
  # put anything you need on the socket via `assigns`.
  def mount(_params, _session, socket) do
    updated_socket =
      socket
      |> assign(:current_time, Time.utc_now())

    {:ok, updated_socket}
  end

  # The @ symbol here **always** refers to a _present_ item in the assigns
  # if it may not be present, use `assigns[:key_name]` which is always safe
  def render(assigns) do
    ~H"""
    The current time is: <%= @current_time %>.
    """
  end
end
