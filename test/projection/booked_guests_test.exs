defmodule Beauforma.Projection.BookedGuestsTest do
  use ExUnit.Case
  alias Beauforma.Events.{
    GuestBookedAppointment,
    GuestRescheduledAppointment
  }
  alias Beauforma.Projection.BookedGuests
  alias Beauforma.Projection.BookedGuests.{State, Appointment}
  doctest Beauforma


  test "Projection" do
    events = [
      %GuestBookedAppointment{
        appointmentId: 1,
        guestId: "Olivier",
        appointmentDateAndTime: "20160626",
        feelGoodPackageId: 1,
        subsidiaryId: 1
      },
      %GuestBookedAppointment{
        appointmentId: 2,
        guestId: "Olivier",
        appointmentDateAndTime: "20160626",
        feelGoodPackageId: 2,
        subsidiaryId: 1
      },
      %GuestRescheduledAppointment{
        appointmentId: 2,
        guestId: "Olivier",
        appointmentDateAndTime: "20160625",
        feelGoodPackageId: 2,
        subsidiaryId: 1
      },
      %GuestBookedAppointment{
        appointmentId: 3,
        guestId: "Rose",
        appointmentDateAndTime: "20160501",
        feelGoodPackageId: 2,
        subsidiaryId: 1
      },
      %GuestBookedAppointment{
        appointmentId: 4,
        guestId: "Rose",
        appointmentDateAndTime: "20160501",
        feelGoodPackageId: 2,
        subsidiaryId: 1
      },
    ]

    state = BookedGuests.project(%State{}, events)

    assert BookedGuests.number_of_guests(state) == 2
  end
end
