defmodule RendaFixaWeb.CalculatorLive do
  use RendaFixaWeb, :live_view

  alias RendaFixa.Calculations
  alias RendaFixa.Calculations.Calculation
  alias RendaFixaWeb.CalculatorFormComponent

  def mount(_params, _session, socket) do
    calculations = Calculations.list_calculations()

    socket =
      socket
      |> stream(:calculations, calculations)
      |> assign(:calculation_result, %{
        brute_final_value: 0,
        brute_rentability: 0,
        interest_rate: 0
      })
      |> assign(:current_calculation, %Calculation{})

    {:ok, socket}
  end

  def calculator_form(assigns) do
    ~H"""
    <div>
      <.live_component module={CalculatorFormComponent} id={:new} />
    </div>
    """
  end

  def table_row(assigns) do
    ~H"""
    <tr id={@id} class="hover:bg-gray-100 dark:hover:bg-gray-700">
      <td class="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-800 dark:text-gray-200">
        <%= @calculation.initial_investment %>
      </td>
      <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-800 dark:text-gray-200">
        <%= @calculation.monthly_investment %>
      </td>
      <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-800 dark:text-gray-200">
        <%= @calculation.term %>
      </td>
      <td class="px-6 py-4 whitespace-nowrap text-end text-sm font-medium">
        <%= @calculation.profitability %>
      </td>
    </tr>
    """
  end

  def handle_info({:calculation_created, calculation}, socket) do
    socket = stream_insert(socket, :calculations, calculation, at: 0)

    {:noreply, socket}
  end

  def handle_info({:calculation_changed, calculation}, socket) do
    calculation = build_calculation(calculation)

    calculation_result =
      Calculations.cdb_pos_profitability(calculation)

    socket =
      socket
      |> assign(:current_calculation, calculation)
      |> assign(:calculation_result, calculation_result)

    {:noreply, socket}
  end

  defp build_calculation(calculation) do
    %Calculation{
      initial_investment: Map.get(calculation, :initial_investment, 0),
      monthly_investment: Map.get(calculation, :monthly_investment, 0),
      profitability: Map.get(calculation, :profitability, 0),
      term: Map.get(calculation, :term, 0)
    }
  end
end
