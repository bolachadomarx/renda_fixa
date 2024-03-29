defmodule RendaFixa.Repo do
  use Ecto.Repo,
    otp_app: :renda_fixa,
    adapter: Ecto.Adapters.Postgres
end
