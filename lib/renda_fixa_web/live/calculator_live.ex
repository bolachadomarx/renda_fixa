defmodule RendaFixaWeb.CalculatorLive do
  use RendaFixaWeb, :live_view

  alias RendaFixa.Calculations
  alias RendaFixaWeb.CalculatorFormComponent

  def mount(_params, _session, socket) do
    calculations = Calculations.list_calculations()

    socket =
      socket
      |> stream(:calculations, calculations)

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
        <%= @calculation.due_date %>
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
end
