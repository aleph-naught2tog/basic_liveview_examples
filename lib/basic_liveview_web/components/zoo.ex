defmodule BasicLiveviewWeb.Zoo do
  use Phoenix.Component

  def animal_action_buttons(assigns) do
    ~H"""
    <div class="actions">
      <div class="button-wrapper">
        <%!-- The value of 'phx-click' needs to exactly match the first argument of `handle_event` --%>
        <button phx-click="add-cat">Add cat</button>
        <button phx-click="remove-cat" disabled={@zoo_map[:cats] === 0}>
          Give cat vacation
        </button>
      </div>

      <div class="button-wrapper">
        <button phx-click="add-dog">Add dog</button>
        <button phx-click="remove-dog" disabled={@zoo_map[:dogs] === 0}>
          Give dog vacation
        </button>
      </div>
    </div>
    """
  end
end
