defmodule ListLength do
  def call(list) do
    count_numbers(list, 0)
  end

  defp count_numbers([], acc) do
    acc
  end

  defp count_numbers([_head | tail], acc) do
    acc = acc + 1
    count_numbers(tail, acc)
  end
end
