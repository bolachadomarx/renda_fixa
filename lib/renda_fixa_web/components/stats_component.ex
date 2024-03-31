defmodule RendaFixaWeb.StatsComponent do
  use Phoenix.Component

  def stats(assigns) do
    ~H"""
    <div class="max-w-[85rem] px-4 py-10 sm:px-6 lg:px-8 lg:py-14 mx-auto">
      <!-- Grid -->
      <div class="grid sm:grid-cols-4 border-y border-gray-200 dark:border-gray-800">
        <!-- Card -->
        <div class="p-4 md:p-5 relative before:absolute before:top-0 before:start-0 before:w-full before:h-px sm:before:w-px sm:before:h-full before:bg-gray-200 before:first:bg-transparent dark:before:bg-gray-700">
          <div>
            <svg
              class="flex-shrink-0 size-5 text-gray-500"
              xmlns="http://www.w3.org/2000/svg"
              width="24"
              height="24"
              viewBox="0 0 24 24"
              fill="none"
              stroke="currentColor"
              stroke-width="2"
              stroke-linecap="round"
              stroke-linejoin="round"
            >
              <path d="M16 21v-2a4 4 0 0 0-4-4H6a4 4 0 0 0-4 4v2" /><circle cx="9" cy="7" r="4" /><path d="M22 21v-2a4 4 0 0 0-3-3.87" /><path d="M16 3.13a4 4 0 0 1 0 7.75" />
            </svg>

            <div class="mt-3">
              <div class="flex items-center gap-x-2">
                <p class="text-xs uppercase tracking-wide text-gray-500">
                  Investimento inicial
                </p>
              </div>
              <div class="mt-1 lg:flex lg:justify-between lg:items-center">
                <h3 class="text-xl sm:text-2xl font-semibold text-gray-800 dark:text-gray-200">
                  <%= @current_calculation.initial_investment %>
                </h3>
              </div>
              <div class="flex items-center gap-x-2 mt-5">
                <p class="text-xs uppercase tracking-wide text-gray-500">
                  Investimento mensal
                </p>
              </div>
              <div class="mt-1 lg:flex lg:justify-between lg:items-center">
                <h3 class="text-xl sm:text-2xl font-semibold text-gray-800 dark:text-gray-200">
                  <%= @current_calculation.monthly_investment %>
                </h3>
              </div>
            </div>
          </div>
        </div>
        <!-- End Card -->

    <!-- Card -->
        <div class="p-4 md:p-5 relative before:absolute before:top-0 before:start-0 before:w-full before:h-px sm:before:w-px sm:before:h-full before:bg-gray-200 before:first:bg-transparent dark:before:bg-gray-700">
          <div>
            <svg
              class="flex-shrink-0 size-5 text-gray-500"
              xmlns="http://www.w3.org/2000/svg"
              width="24"
              height="24"
              viewBox="0 0 24 24"
              fill="none"
              stroke="currentColor"
              stroke-width="2"
              stroke-linecap="round"
              stroke-linejoin="round"
            >
              <path d="M5 22h14" /><path d="M5 2h14" /><path d="M17 22v-4.172a2 2 0 0 0-.586-1.414L12 12l-4.414 4.414A2 2 0 0 0 7 17.828V22" /><path d="M7 2v4.172a2 2 0 0 0 .586 1.414L12 12l4.414-4.414A2 2 0 0 0 17 6.172V2" />
            </svg>

            <div class="mt-3">
              <div class="flex items-center gap-x-2">
                <p class="text-xs uppercase tracking-wide text-gray-500">
                  Rentabilidade
                </p>
              </div>
              <div class="mt-1 lg:flex lg:justify-between lg:items-center">
                <h3 class="text-xl sm:text-2xl font-semibold text-gray-800 dark:text-gray-200">
                  <%= @current_calculation.profitability %>
                </h3>
              </div>
              <div class="flex items-center gap-x-2 mt-5">
                <p class="text-xs uppercase tracking-wide text-gray-500">
                  Prazo em anos
                </p>
              </div>
              <div class="mt-1 lg:flex lg:justify-between lg:items-center">
                <h3 class="text-xl sm:text-2xl font-semibold text-gray-800 dark:text-gray-200">
                  <%= @current_calculation.term %>
                </h3>
              </div>
            </div>
          </div>
        </div>
        <!-- End Card -->

    <!-- Card -->
        <div class="p-4 md:p-5 relative before:absolute before:top-0 before:start-0 before:w-full before:h-px sm:before:w-px sm:before:h-full before:bg-gray-200 before:first:bg-transparent dark:before:bg-gray-700">
          <div>
            <svg
              class="flex-shrink-0 size-5 text-gray-500"
              xmlns="http://www.w3.org/2000/svg"
              width="24"
              height="24"
              viewBox="0 0 24 24"
              fill="none"
              stroke="currentColor"
              stroke-width="2"
              stroke-linecap="round"
              stroke-linejoin="round"
            >
              <path d="M21 11V5a2 2 0 0 0-2-2H5a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h6" /><path d="m12 12 4 10 1.7-4.3L22 16Z" />
            </svg>

            <div class="mt-3">
              <div class="flex items-center gap-x-2">
                <p class="text-xs uppercase tracking-wide text-gray-500">
                  Rentabilidade bruta
                </p>
              </div>
              <div class="mt-1 lg:flex lg:justify-between lg:items-center">
                <h3 class="text-xl sm:text-2xl font-semibold text-gray-800 dark:text-gray-200">
                  <%= @calculation_result.brute_final_value %>
                </h3>
              </div>
            </div>
          </div>
        </div>
        <!-- End Card -->

    <!-- Card -->
        <div class="p-4 md:p-5 relative before:absolute before:top-0 before:start-0 before:w-full before:h-px sm:before:w-px sm:before:h-full before:bg-gray-200 before:first:bg-transparent dark:before:bg-gray-700">
          <div>
            <svg
              class="flex-shrink-0 size-5 text-gray-500"
              xmlns="http://www.w3.org/2000/svg"
              width="24"
              height="24"
              viewBox="0 0 24 24"
              fill="none"
              stroke="currentColor"
              stroke-width="2"
              stroke-linecap="round"
              stroke-linejoin="round"
            >
              <path d="M5 12s2.545-5 7-5c4.454 0 7 5 7 5s-2.546 5-7 5c-4.455 0-7-5-7-5z" /><path d="M12 13a1 1 0 1 0 0-2 1 1 0 0 0 0 2z" /><path d="M21 17v2a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-2" /><path d="M21 7V5a2 2 0 0 0-2-2H5a2 2 0 0 0-2 2v2" />
            </svg>

            <div class="mt-3">
              <div class="flex items-center gap-x-2">
                <p class="text-xs uppercase tracking-wide text-gray-500">
                  Seu dinheiro rendeu
                </p>
              </div>
              <div class="mt-1 lg:flex lg:justify-between lg:items-center">
                <h3 class="text-xl sm:text-2xl font-semibold text-gray-800 dark:text-gray-200">
                  <%= format_number(@calculation_result.brute_rentability) %>
                </h3>
              </div>
            </div>
          </div>
        </div>
        <!-- End Card -->
      </div>
      <!-- End Grid -->
    </div>
    """
  end

  defp format_number(number) when is_float(number), do: Float.round(number, 2)
  defp format_number(number), do: number
end
