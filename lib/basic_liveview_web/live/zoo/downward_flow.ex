defmodule BasicLiveviewWeb.Zoo.DownwardFlow do
  use BasicLiveviewWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:zoo_map, %{cats: 0, dogs: 0, horses: 0})}
  end
end
