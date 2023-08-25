defmodule BasicLiveviewWeb.Zoo.NotifyingZoo do
  use BasicLiveviewWeb, :live_component

  alias BasicLiveviewWeb.Zoo.NotifyingZoo

  def render(assigns) do
    # We initialize our count using the count we get from the parent
    assigns =
      assigns
      |> assign_new(:count, fn -> assigns[:count] end)

    ~H"""
    <div class="animal-wrapper">
      <div>
        <dl class="animal-list">
          <dt>
            <span role="img" aria-label={@name}>🐈</span> <%= @name <> "s" %>
          </dt>
          <dd><%= @count %></dd>
        </dl>

        <div class="button-wrapper">
          <%!-- phx-target={@myself} is how the event gets sent to _this_
          component, instead of the parent LiveView --%>
          <button phx-click="add-animal" phx-target={@myself}>
            Add <%= @name %>
          </button>
          <button phx-click="remove-animal" disabled={@count === 0} phx-target={@myself}>
            Give <%= @name %> vacation
          </button>
        </div>
      </div>
    </div>
    """
  end

  def handle_event("add-animal", _params, socket) do
    current_count = socket.assigns.count
    updated_count = current_count + 1

    recipient = self()
    # that's us!
    sender = NotifyingZoo
    message = {socket.assigns.name, updated_count}

    # This notifies the live view of our updated count This is just like when we
    # were doing Process.send for the clock -- we're in the same process, so
    # we're sending a message to the process. This will be handled by
    # `handle_info` in the LiveView.
    send(recipient, {sender, :count, message})

    {:noreply, socket |> assign(:count, updated_count)}
  end

  # If you're looking at this and going "wow, this is the same as 'add-animal'
  # except for the -1" -- it sure is. We could totally refactor this up one more
  # level if we wanted.
  def handle_event("remove-animal", _params, socket) do
    current_count = socket.assigns.count
    updated_count = current_count - 1

    recipient = self()
    sender = NotifyingZoo
    message = {socket.assigns.name, updated_count}

    send(recipient, {sender, :count, message})

    {:noreply, socket |> assign(:count, updated_count)}
  end
end
