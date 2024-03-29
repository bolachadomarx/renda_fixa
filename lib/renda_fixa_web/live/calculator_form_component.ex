defmodule RendaFixaWeb.CalculatorFormComponent do
  use RendaFixaWeb, :live_component

  alias RendaFixa.Calculations
  alias RendaFixa.Calculations.Calculation

  def mount(socket) do
    changeset = Calculations.change_calculation(%Calculation{})

    socket =
      socket
      |> assign(:form, to_form(changeset))

    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <div>
      <.form phx-submit="save" phx-change="validate" for={@form} phx-target={@myself}>
        <div class="mb-4 sm:mb-8">
          <label class="block mb-2 text-sm font-medium dark:text-white">
            Investimento inicial
          </label>
          <.input placeholder="Investimento inicial" field={@form[:initial_investment]} />
        </div>

        <div class="mb-4 sm:mb-8">
          <label class="block mb-2 text-sm font-medium dark:text-white">
            Investimento mensal
          </label>
          <.input placeholder="Investimento mensal" field={@form[:monthly_investment]} />
        </div>

        <div class="mb-4 sm:mb-8">
          <label class="block mb-2 text-sm font-medium dark:text-white">
            Vencimento
          </label>
          <.input placeholder="Vencimento" field={@form[:due_date]} />
          <select class="py-3 px-4 pe-9 border-gray-200 rounded-lg text-sm focus:border-blue-500 focus:ring-blue-500 disabled:opacity-50 disabled:pointer-events-none dark:bg-slate-900 dark:border-gray-700 dark:text-gray-400 dark:focus:ring-gray-600">
            <option selected>Anos</option>
            <option disabled>Meses</option>
            <option disabled>Dias</option>
          </select>
        </div>

        <div class="mb-4 sm:mb-8">
          <label class="block mb-2 text-sm font-medium dark:text-white">
            Rentabilidade
          </label>
          <.input
            class="py-3 px-4 block w-full border-gray-200 rounded-lg text-sm focus:border-blue-500 focus:ring-blue-500 disabled:opacity-50 disabled:pointer-events-none dark:bg-slate-900 dark:border-gray-700 dark:text-gray-400 dark:focus:ring-gray-600"
            placeholder="Rentabilidade"
            field={@form[:profitability]}
          />
        </div>

        <div class="mt-6 grid">
          <.button
            phx-disable-with="Saving..."
            class="w-full py-3 px-4 inline-flex justify-center items-center gap-x-2 text-sm font-semibold rounded-lg border border-transparent bg-blue-600 text-white hover:bg-blue-700 disabled:opacity-50 disabled:pointer-events-none dark:focus:outline-none dark:focus:ring-1 dark:focus:ring-gray-600"
          >
            Submit
          </.button>
        </div>
      </.form>
    </div>
    """
  end

  def handle_event("save", %{"calculation" => calculation_params}, socket) do
    case Calculations.create_calculation(calculation_params) do
      {:ok, calculation} ->
        send(self(), {:calculation_created, calculation})

        changeset = Calculations.change_calculation(%Calculation{})

        {:noreply, assign(socket, :form, to_form(changeset))}

      {:error, changeset} ->
        {:noreply, assign(socket, :form, to_form(changeset))}
    end
  end

  def handle_event("validate", %{"calculation" => calculation_params}, socket) do
    changeset =
      %Calculation{}
      |> Calculations.change_calculation(calculation_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :form, to_form(changeset))}
  end
end
