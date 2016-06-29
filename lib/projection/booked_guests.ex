defmodule Beauforma.Projection.BookedGuests do
  alias Beauforma.Events.{
    GuestBookedAppointment,
    GuestRescheduledAppointment,
    GuestSwappedAppointmentFeelGoodPackage,
    GuestCancelledAppointment,
    SubsidiaryCancelledAppointment
  }

  defmodule State do
    defstruct [map: %{}]
  end

  defmodule Appointment do
    defstruct [:appointmentId, :guestId, :dateTime]
  end

  def project(%State{} = state, %GuestBookedAppointment{appointmentId: aId, guestId: gId, appointmentDateAndTime: dateTime}) do
    %State{state | map: Map.put(state.map, gId, %Appointment{appointmentId: aId, guestId: gId, dateTime: dateTime})}
  end
  def project(%State{} = state, _), do: state
end
