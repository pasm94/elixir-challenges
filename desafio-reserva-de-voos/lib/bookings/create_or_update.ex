defmodule Flightex.Bookings.CreateOrUpdate do
  alias Flightex.Bookings.Agent, as: BookingAgent
  alias Flightex.Bookings.Booking

  def call(%{
        complete_date: complete_date,
        local_origin: local_origin,
        local_destination: local_destination,
        user_id: user_id
      }) do
    with {:ok, booking} <-
           Booking.build(complete_date, local_origin, local_destination, user_id) do
      save_booking(booking)
    else
      error -> error
    end
  end

  defp save_booking(%Booking{} = booking) do
    BookingAgent.save(booking)

    {:ok, booking}
  end
end
