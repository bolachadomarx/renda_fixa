defmodule RendaFixa.Calculations.Calculation do
  use Ecto.Schema
  import Ecto.Changeset

  schema "calculations" do
    field :initial_investment, :float
    field :monthly_investment, :float
    field :profitability, :float
    field :due_date, :integer

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(calculation, attrs) do
    calculation
    |> cast(attrs, [:initial_investment, :monthly_investment, :profitability, :due_date])
    |> validate_required([:initial_investment, :monthly_investment, :profitability, :due_date])
  end
end
