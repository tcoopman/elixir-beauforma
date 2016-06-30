defmodule Beauforma.Projection.BookedGuestsTest do
  use ExUnit.Case
  alias Beauforma.Events.{
    GuestBookedAppointment,
    GuestRescheduledAppointment,
    GuestSwappedAppointmentFeelGoodPackage,
    GuestCancelledAppointment,
    SubsidiaryCancelledAppointment
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
      %GuestSwappedAppointmentFeelGoodPackage{
        appointmentId: 2,
        guestId: "Olivier",
        feelGoodPackageId: 3,
        subsidiaryId: 1
      },
      %GuestCancelledAppointment{
        appointmentId: 3,
        guestId: "Rose",
        reason: "some reason",
        subsidiaryId: 1
      },
      %SubsidiaryCancelledAppointment{
        appointmentId: 2,
        guestId: "Olivier",
        reason: "other reason",
        subsidiaryId: 1
      }
    ]

    state = BookedGuests.new
    |> BookedGuests.project(events)

    assert BookedGuests.nr_of_appointments_on_date(state, "20160626") == 1
    assert BookedGuests.nr_of_appointments_on_date(state, "20160625") == 0
    assert BookedGuests.has_appointment_on_date(state, "Olivier", "20160625") == false
    assert BookedGuests.has_appointment_on_date(state, "Olivier", "20160626") == true
    assert BookedGuests.has_appointment_on_date(state, "Rose", "20160501") == true
    assert BookedGuests.nr_of_appointments_on_date(state, "20160501") == 1
  end
end
