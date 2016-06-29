defmodule Beauforma.Events do
  defmodule GuestBookedAppointment do
    defstruct [:appointmentId, :guestId, :appointmentDateAndTime, :feelGoodPackageId, :subsidiaryId]
  end

  defmodule GuestRescheduledAppointment do
    defstruct [:appointmentId, :guestId, :appointmentDateAndTime, :feelGoodPackageId, :subsidiaryId]
  end

  defmodule GuestSwappedAppointmentFeelGoodPackage do
    defstruct [:appointmentId, :guestId, :feelGoodPackageId, :subsidiaryId]
  end

  defmodule GuestCancelledAppointment do
    defstruct [:appointmentId, :guestId, :reason, :subsidiaryId]
  end

  defmodule SubsidiaryCancelledAppointment do
    defstruct [:appointmentId, :guestId, :reason, :subsidiaryId]
  end
end
