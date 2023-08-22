defmodule BasicLiveview.Repo do
  use Ecto.Repo,
    otp_app: :basic_liveview,
    adapter: Ecto.Adapters.Postgres
end
