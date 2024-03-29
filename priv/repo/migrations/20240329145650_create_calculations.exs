defmodule RendaFixa.Repo.Migrations.CreateCalculations do
  use Ecto.Migration

  def change do
    create table(:calculations) do
      add :initial_investment, :float
      add :monthly_investment, :float
      add :profitability, :float
      add :due_date, :integer

      timestamps(type: :utc_datetime)
    end
  end
end
