defmodule Flightex.Bookings.Report do
  alias Flightex.Bookings.Agent, as: BookingAgent
  alias Flightex.Bookings.Booking

  def create(initial_date, final_date, filename \\ "report.csv") do
    booking_list = build_bookings_list(initial_date, final_date)

    File.write(filename, booking_list)
  end

  def create(filename \\ "report.csv") do
    booking_list = build_bookings_list()

    File.write(filename, booking_list)
  end

  defp build_bookings_list(initial_date, final_date) do
    BookingAgent.get_all()
    |> Map.values()
    |> Enum.filter(fn %{complete_date: date} ->
      NaiveDateTime.diff(final_date, date) >= 0 &&
        NaiveDateTime.diff(date, initial_date) >= 0
    end)
    |> Enum.map(fn booking -> booking_string(booking) end)
  end

  defp build_bookings_list() do
    BookingAgent.get_all()
    |> Map.values()
    |> Enum.map(fn booking -> booking_string(booking) end)
  end

  defp booking_string(%Booking{
         user_id: user_id,
         local_origin: local_origin,
         local_destination: local_destination,
         complete_date: complete_date
       }) do
    "#{user_id},#{local_origin},#{local_destination},#{complete_date}\n"
  end
end
