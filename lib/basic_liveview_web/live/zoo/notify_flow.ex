defmodule BasicLiveviewWeb.Zoo.NotifyFlow do
  use BasicLiveviewWeb, :live_view

  def mount(_params, _session, socket) do
    initial_zoo_map = %{cats: 0, dogs: 0}
    initial_count = 0

    {:ok,
     socket
     |> assign(:zoo_map, initial_zoo_map)
     |> assign(:total_animal_count, initial_count)}
  end

  def handle_info({_sender, :count, {animal, new_count}}, socket) do
    animal_map_key = String.to_atom(animal <> "s")
    updated_map = Map.put(socket.assigns.zoo_map, animal_map_key, new_count)
    updated_total_animal_count = calculate_animal_total(updated_map)

    {:noreply,
     socket
     |> assign(:zoo_map, updated_map)
     |> assign(:total_animal_count, updated_total_animal_count)}
  end

  defp calculate_animal_total(zoo_map) do
    zoo_map
    |> Map.values()
    |> Enum.sum()
  end
end
