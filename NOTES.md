# LiveView vs Phoenix.Component vs LiveComponent

Stop me with questions any time!

## General notes

* [Elixir](https://elixir-lang.org/) is built on [Erlang](https://en.wikipedia.org/wiki/Erlang_(programming_language) (you can even call directly into Erlang from Elixir!)
* Erlang/Elixir processes (great guide: [Processes - The Elixir programming language](https://elixir-lang.org/getting-started/processes.html))
	* are NOT like our normal system processes
	* core to the language
		- "Process creation and destruction is a lightweight operation."
		- "Message passing is the only way for processes to interact."
		- "Processes have unique names."
		- "If you know the name of a process you can send it a message."
- Server-side
* All of this centers around ***sockets***, not HTTP requests

## Phoenix.LiveView

Docs: [Phoenix.LiveView — Phoenix LiveView v0.19.5](https://hexdocs.pm/phoenix_live_view/Phoenix.LiveView.html)

* Handles state, markup, events
* "A process that receives events, updates its state, renders updates to the page as diffs"
* Two main callbacks: `mount` and `render`
	* `Mount` -- a sort of initialization function. Set up your initial assigns, etc.
	* `Render` -- what it sounds like! Can also be done in a file with an identical name like `<live_view_file_name>.html.heex` .
* Other callbacks --` handle_event`, `handle_info` (for receiving messages), and others
* CREATES the socket that gets passed around

## Phoenix.LiveComponent

Docs: [Phoenix.LiveComponent — Phoenix LiveView v0.19.5](https://hexdocs.pm/phoenix_live_view/Phoenix.LiveComponent.html)

* "Compartmentalize state, markup, events"
* Stateful components - "run inside the LiveView process but have their own state and life-cycle"
* USES the socket from its parent LiveView
* Similar callbacks to the LiveView - also has `mount`, `render`
* Others -- `handle_event`, others (_no_ `handle_info`)

## Phoenix.Component

Docs: [Phoenix.Component — Phoenix LiveView v0.19.5](https://hexdocs.pm/phoenix_live_view/Phoenix.Component.html)

* Your basic component! Renders HTML
* Reusable markup, styles, etc.
* No callbacks

