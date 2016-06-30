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

  def new, do: %State{}

  def project(%State{} = state, events) do
    events
    |> Enum.reduce(state, &project_event/2)
  end

  def number_of_guests(%State{map: map}) do
    map
    |> Map.keys
    |> Enum.count
  end

  defp project_event(%GuestBookedAppointment{appointmentId: aId, guestId: gId, appointmentDateAndTime: dateTime}, %State{} = state) do
    %State{state | map: Map.put(state.map, gId, %Appointment{appointmentId: aId, guestId: gId, dateTime: dateTime})}
  end
  defp project_event(_, %State{} = state), do: state
end
