defmodule Beauforma.Projection.BookedGuestsTest do
  use ExUnit.Case
  alias Beauforma.Events.{GuestBookedAppointment}
  alias Beauforma.Projection.BookedGuests
  doctest Beauforma


  test "Simple event" do
    event = %GuestBookedAppointment{
      appointmentId: 1,
      guestId: "Olivier",
      appointmentDateAndTime: "20160626",
      feelGoodPackageId: 1,
      subsidiaryId: 1
    }
    
    state = BookedGuests.project(%BookedGuests.State{}, event)

    assert Map.has_key?(state.map, "Olivier")
  end
end
