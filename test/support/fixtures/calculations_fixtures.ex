defmodule RendaFixa.CalculationsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `RendaFixa.Calculations` context.
  """

  @doc """
  Generate a calculation.
  """
  def calculation_fixture(attrs \\ %{}) do
    {:ok, calculation} =
      attrs
      |> Enum.into(%{
        due_date: 42,
        initial_investment: 120.5,
        monthly_investment: 120.5,
        profitability: 120.5
      })
      |> RendaFixa.Calculations.create_calculation()

    calculation
  end
end
