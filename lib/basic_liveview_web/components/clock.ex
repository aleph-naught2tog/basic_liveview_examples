defmodule BasicLiveviewWeb.Clock do
  # once again, this is the magic that makes it work
  use Phoenix.Component

  # Docs: https://hexdocs.pm/phoenix_live_view/Phoenix.Component.html

  # This is a list of attributes and information about them. Only
  # Phoenix.Components can have this list, so sometimes you will see these
  # wrapping Live Components just for the sake of documentation purposes.
  attr(:current_time, Time, required: true, doc: "The time to show")

  slot(:header, required: true, doc: "The text to precede the time displayed")

  # This is a "special" slot -- if you're familiar with React, this is the equivalent of children. It's whatever you put inside the
  slot(:inner_block)

  def clock(assigns) do
    ~H"""
    <section>
      <div>
        <%= render_slot(@header) %> <%= @current_time %>
      </div>

      <%= render_slot(@inner_block) %>
    </section>
    """
  end
end
