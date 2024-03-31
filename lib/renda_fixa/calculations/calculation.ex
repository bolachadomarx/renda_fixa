defmodule RendaFixa.Calculations.Calculation do
  use Ecto.Schema
  import Ecto.Changeset

  schema "calculations" do
    field :initial_investment, :float
    field :monthly_investment, :float
    field :profitability, :float
    field :term, :integer
    field :brute_final_value, :float
    field :brute_rentability, :float
    field :interest_rate, :float

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(calculation, attrs) do
    calculation
    |> cast(attrs, [:initial_investment, :monthly_investment, :profitability, :term])
    |> validate_required([:initial_investment, :monthly_investment, :profitability, :term])
  end
end
