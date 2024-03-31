defmodule RendaFixa.Calculations do
  @moduledoc """
  The Calculations context.
  """

  import Ecto.Query, warn: false
  alias RendaFixa.Repo

  alias RendaFixa.Calculations.Calculation

  @di_rate 0.1065

  @doc """
  Returns the list of calculations.

  ## Examples

      iex> list_calculations()
      [%Calculation{}, ...]

  """
  def list_calculations do
    Repo.all(Calculation)
  end

  @doc """
  Gets a single calculation.

  Raises `Ecto.NoResultsError` if the Calculation does not exist.

  ## Examples

      iex> get_calculation!(123)
      %Calculation{}

      iex> get_calculation!(456)
      ** (Ecto.NoResultsError)

  """
  def get_calculation!(id), do: Repo.get!(Calculation, id)

  @doc """
  Creates a calculation.

  ## Examples

      iex> create_calculation(%{field: value})
      {:ok, %Calculation{}}

      iex> create_calculation(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_calculation(attrs \\ %{}) do
    %Calculation{}
    |> Calculation.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a calculation.

  ## Examples

      iex> update_calculation(calculation, %{field: new_value})
      {:ok, %Calculation{}}

      iex> update_calculation(calculation, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_calculation(%Calculation{} = calculation, attrs) do
    calculation
    |> Calculation.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a calculation.

  ## Examples

      iex> delete_calculation(calculation)
      {:ok, %Calculation{}}

      iex> delete_calculation(calculation)
      {:error, %Ecto.Changeset{}}

  """
  def delete_calculation(%Calculation{} = calculation) do
    Repo.delete(calculation)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking calculation changes.

  ## Examples

      iex> change_calculation(calculation)
      %Ecto.Changeset{data: %Calculation{}}

  """
  def change_calculation(%Calculation{} = calculation, attrs \\ %{}) do
    Calculation.changeset(calculation, attrs)
  end

  def cdb_pre_profitability(%Calculation{
        initial_investment: initial_investment,
        profitability: profitability,
        term: term
      }) do
    profitability = profitability(profitability)

    interest_rate = @di_rate * profitability

    rentability = calculate_rentability(initial_investment, interest_rate, term)

    {rentability, interest_rate * 100, rentability - initial_investment}
  end

  def cdb_pos_profitability(%Calculation{
        initial_investment: initial_investment,
        monthly_investment: monthly_investment,
        profitability: profitability,
        term: term
      }) do
    profitability = profitability(profitability)
    interest_rate = interest_rate(profitability)
    months = term_in_months(term)

    brute_initial_interest = initial_investment * interest_rate
    brute_reinvestment_interest = monthly_investment * interest_rate * months

    brute_rentability = brute_initial_interest + brute_reinvestment_interest

    brute_final_value = initial_investment + monthly_investment * months + brute_rentability

    %{
      brute_final_value: brute_final_value,
      brute_rentability: brute_rentability,
      interest_rate: interest_rate
    }
  end

  defp calculate_rentability(initial_investment, interest_rate, term),
    do: initial_investment * :math.pow(1 + interest_rate, term)

  defp profitability(profitability), do: profitability / 100

  defp interest_rate(profitability), do: @di_rate * profitability

  defp term_in_months(term), do: term * 12
end
