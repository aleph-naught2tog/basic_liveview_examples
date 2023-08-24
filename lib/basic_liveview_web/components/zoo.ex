defmodule BasicLiveviewWeb.Zoo do
  use Phoenix.Component

  attr(:name, :string,
    doc: "The name of the animal. This should be singular.",
    examples: ["dog", "cat", "horse", "pterodactyl"]
  )

  attr(:count, :integer, doc: "The current count of that animal.")

  attr(:add_event, :string,
    doc: "The name of the event for adding that animal.",
    examples: ["add-parrot", "obtain-lemming"]
  )

  attr(:remove_event, :string,
    doc:
      "The name of the event for remove that animal. Remember, this must match your `handle_event` arguments.",
    examples: ["take-iguana-to-groomers", "take-kitten-to-cat-cafe", "adopt-out-guinea-pig"]
  )

  def animal_count(assigns) do
    ~H"""
    <div>
      <dl class="animal-list">
        <dt>
          <span role="img" aria-label={@name}>🐈</span> <%= @name <> "s" %>
        </dt>
        <dd><%= @count %></dd>
      </dl>

      <div class="button-wrapper">
        <button phx-click={@add_event}>Add <%= @name %></button>
        <button phx-click={@remove_event} disabled={@count === 0}>
          Give <%= @name %> vacation
        </button>
      </div>
    </div>
    """
  end
end
