defmodule ListFilter do
  require Integer

  def call(list), do: get_only_numbers(list)

  defp get_only_numbers(list) do
    list
    |> Enum.filter(fn arg -> is_number(arg) end)
    |> get_only_odd_numbers()
  end

  defp get_only_odd_numbers(list) do
    list
    |> Enum.filter(fn arg -> is_integer(arg) end)
    |> Enum.filter(fn arg -> Integer.is_odd(arg) end)
    |> list_length()
  end

  defp list_length(list) do
    length(list)
  end
end
