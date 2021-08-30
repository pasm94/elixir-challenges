defmodule GenReport do
  alias GenReport.Parser

  @months %{
    1 => "janeiro",
    2 => "fevereiro",
    3 => "março",
    4 => "abril",
    5 => "maio",
    6 => "junho",
    7 => "julho",
    8 => "agosto",
    9 => "setembro",
    10 => "outubro",
    11 => "novembro",
    12 => "dezembro"
  }

  def build(filename) do
    lines = Parser.parse_file(filename)

    lines
    |> Enum.reduce(build_acc(lines), fn line, acc ->
      sum_values(line, acc)
    end)
  end

  def build_from_many(files) when not is_list(files) do
    {:error, "please provide a list of strings"}
  end

  def build_from_many(files) do
    files
    |> Task.async_stream(&build/1)
    |> Enum.reduce(build_simple_map(), fn {:ok, result}, report -> sum_reports(report, result) end)
  end

  defp sum_reports(report, result) do
    %{
      "all_hours" => all_hours1,
      "hours_per_month" => hours_per_month1,
      "hours_per_year" => hours_per_year1
    } = report

    %{
      "all_hours" => all_hours2,
      "hours_per_month" => hours_per_month2,
      "hours_per_year" => hours_per_year2
    } = result

    all_hours = merge_maps(all_hours1, all_hours2)
    hours_per_month = merge_maps(hours_per_month1, hours_per_month2)
    hours_per_year = merge_maps(hours_per_year1, hours_per_year2)

    %{
      "all_hours" => all_hours,
      "hours_per_month" => hours_per_month,
      "hours_per_year" => hours_per_year
    }
  end

  defp merge_maps(map1, map2) do
    Map.merge(map1, map2, fn _key, value1, value2 ->
      if is_map(value1) and is_map(value2) do
        merge_maps(value1, value2)
      else
        value1 + value2
      end
    end)
  end

  defp sum_values([name, hours, _day, month, year], acc) do
    %{
      "all_hours" => all_hours,
      "hours_per_month" => hours_per_month,
      "hours_per_year" => hours_per_year
    } = acc

    per_year = hours_per_year[name]
    per_month = hours_per_month[name]
    month_name = @months[month]

    all_hours = Map.put(all_hours, name, all_hours[name] + hours)

    per_month = Map.put(per_month, month_name, per_month[month_name] + hours)
    hours_per_month = Map.put(hours_per_month, name, per_month)

    per_year = Map.put(per_year, year, per_year[year] + hours)
    hours_per_year = Map.put(hours_per_year, name, per_year)

    %{
      "all_hours" => all_hours,
      "hours_per_month" => hours_per_month,
      "hours_per_year" => hours_per_year
    }
  end

  defp build_acc(lines) do
    initial_acc = %{
      "all_hours" => %{},
      "hours_per_month" => %{},
      "hours_per_year" => %{}
    }

    lines
    |> Enum.map(fn [name, _hours, _day, _month, _year] -> name end)
    |> Enum.uniq()
    |> Enum.reduce(initial_acc, fn name, acc ->
      build_map(name, acc)
    end)
  end

  defp build_map(name, acc) do
    %{
      "all_hours" => all_hours,
      "hours_per_month" => hours_per_month,
      "hours_per_year" => hours_per_year
    } = acc

    per_month = Enum.into(Map.values(@months), %{}, &{&1, 0})
    per_year = Enum.into(2016..2020, %{}, &{Integer.to_string(&1), 0})

    all_hours = Map.put(all_hours, name, 0)
    hours_per_month = Map.put(hours_per_month, name, per_month)
    hours_per_year = Map.put(hours_per_year, name, per_year)

    %{
      "all_hours" => all_hours,
      "hours_per_month" => hours_per_month,
      "hours_per_year" => hours_per_year
    }
  end

  defp build_simple_map do
    %{
      "all_hours" => %{},
      "hours_per_month" => %{},
      "hours_per_year" => %{}
    }
  end
end
