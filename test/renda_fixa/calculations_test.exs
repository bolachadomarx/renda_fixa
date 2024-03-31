defmodule RendaFixa.CalculationsTest do
  use RendaFixa.DataCase

  alias RendaFixa.Calculations

  describe "calculations" do
    alias RendaFixa.Calculations.Calculation

    import RendaFixa.CalculationsFixtures

    @invalid_attrs %{
      initial_investment: nil,
      monthly_investment: nil,
      profitability: nil,
      term: nil
    }

    test "list_calculations/0 returns all calculations" do
      calculation = calculation_fixture()
      assert Calculations.list_calculations() == [calculation]
    end

    test "get_calculation!/1 returns the calculation with given id" do
      calculation = calculation_fixture()
      assert Calculations.get_calculation!(calculation.id) == calculation
    end

    test "create_calculation/1 with valid data creates a calculation" do
      valid_attrs = %{
        initial_investment: 120.5,
        monthly_investment: 120.5,
        profitability: 120.5,
        term: 42
      }

      assert {:ok, %Calculation{} = calculation} = Calculations.create_calculation(valid_attrs)
      assert calculation.initial_investment == 120.5
      assert calculation.monthly_investment == 120.5
      assert calculation.profitability == 120.5
      assert calculation.term == 42
    end

    test "create_calculation/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Calculations.create_calculation(@invalid_attrs)
    end

    test "update_calculation/2 with valid data updates the calculation" do
      calculation = calculation_fixture()

      update_attrs = %{
        initial_investment: 456.7,
        monthly_investment: 456.7,
        profitability: 456.7,
        term: 43
      }

      assert {:ok, %Calculation{} = calculation} =
               Calculations.update_calculation(calculation, update_attrs)

      assert calculation.initial_investment == 456.7
      assert calculation.monthly_investment == 456.7
      assert calculation.profitability == 456.7
      assert calculation.term == 43
    end

    test "update_calculation/2 with invalid data returns error changeset" do
      calculation = calculation_fixture()

      assert {:error, %Ecto.Changeset{}} =
               Calculations.update_calculation(calculation, @invalid_attrs)

      assert calculation == Calculations.get_calculation!(calculation.id)
    end

    test "delete_calculation/1 deletes the calculation" do
      calculation = calculation_fixture()
      assert {:ok, %Calculation{}} = Calculations.delete_calculation(calculation)
      assert_raise Ecto.NoResultsError, fn -> Calculations.get_calculation!(calculation.id) end
    end

    test "change_calculation/1 returns a calculation changeset" do
      calculation = calculation_fixture()
      assert %Ecto.Changeset{} = Calculations.change_calculation(calculation)
    end
  end
end
