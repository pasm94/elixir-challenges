defmodule Gitapi.Repo do
  use Ecto.Repo,
    otp_app: :gitapi,
    adapter: Ecto.Adapters.Postgres
end
