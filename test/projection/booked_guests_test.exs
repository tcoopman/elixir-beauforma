defmodule Beauforma.Projection.BookedGuestsTest do
  use ExUnit.Case
  alias Beauforma.Events.{
    GuestBookedAppointment,
    GuestRescheduledAppointment
  }
  alias Beauforma.Projection.BookedGuests
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

    state = BookedGuests.new
    |> BookedGuests.project(events)

    assert BookedGuests.nr_of_appointments_on_date(state, "20160626") == 1
    assert BookedGuests.nr_of_appointments_on_date(state, "20160625") == 1
  end
end
