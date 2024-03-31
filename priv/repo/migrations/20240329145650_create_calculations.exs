defmodule RendaFixa.Repo.Migrations.CreateCalculations do
  use Ecto.Migration

  def change do
    create table(:calculations) do
      add :initial_investment, :float
      add :monthly_investment, :float
      add :profitability, :float
      add :term, :integer
      add :brute_final_value, :float
      add :brute_rentability, :float
      add :interest_rate, :float

      timestamps(type: :utc_datetime)
    end
  end
end
