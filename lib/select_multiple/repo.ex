defmodule SelectMultiple.Repo do
  use Ecto.Repo,
    otp_app: :select_multiple,
    adapter: Ecto.Adapters.Postgres
end
