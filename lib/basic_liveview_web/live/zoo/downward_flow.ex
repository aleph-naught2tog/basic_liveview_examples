defmodule BasicLiveviewWeb.Zoo.DownwardFlow do
  use BasicLiveviewWeb, :live_view

  def mount(_params, _session, socket) do
    initial_zoo_map = %{cats: 0, dogs: 0}
    initial_count = 0

    {:ok,
     socket
     |> assign(:zoo_map, initial_zoo_map)
     |> assign(:total_animal_count, initial_count)}
  end

  # This first argument must match a `phx-<event_name>` somewhere to fire
  # Here, we don't actually care about any params -- `add-cat` tells us everything we need to know.
  def handle_event("add-cat", _params, socket) do
    current_zoo_map = socket.assigns.zoo_map

    updated_zoo_map =
      Map.update!(current_zoo_map, :cats, fn current_cat_count -> current_cat_count + 1 end)

    updated_total = calculate_animal_total(updated_zoo_map)

    {:noreply,
     socket
     |> assign(:zoo_map, updated_zoo_map)
     |> assign(:total_animal_count, updated_total)}
  end

  def handle_event("add-dog", _params, socket) do
    current_zoo_map = socket.assigns.zoo_map

    updated_zoo_map =
      Map.update!(current_zoo_map, :dogs, fn current_cat_count -> current_cat_count + 1 end)

    updated_total = calculate_animal_total(updated_zoo_map)

    {:noreply,
     socket
     |> assign(:zoo_map, updated_zoo_map)
     |> assign(:total_animal_count, updated_total)}
  end

  def handle_event("remove-dog", _params, socket) do
    current_zoo_map = socket.assigns.zoo_map

    updated_zoo_map =
      Map.update!(current_zoo_map, :dogs, fn current_cat_count -> current_cat_count - 1 end)

    updated_total = calculate_animal_total(updated_zoo_map)

    {:noreply,
     socket
     |> assign(:zoo_map, updated_zoo_map)
     |> assign(:total_animal_count, updated_total)}
  end

  def handle_event("remove-cat", _params, socket) do
    current_zoo_map = socket.assigns.zoo_map

    updated_zoo_map =
      Map.update!(current_zoo_map, :cats, fn current_cat_count -> current_cat_count - 1 end)

    updated_total = calculate_animal_total(updated_zoo_map)

    {:noreply,
     socket
     |> assign(:zoo_map, updated_zoo_map)
     |> assign(:total_animal_count, updated_total)}
  end

  defp calculate_animal_total(zoo_map) do
    zoo_map
    |> Map.values()
    |> Enum.sum()
  end

  # No render function here! -- you can put it in a file as long as the file name is the same as this one, with an extension of `.html.heex`
end
