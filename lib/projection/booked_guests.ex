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

  def project(%State{} = state, events), do: Enum.reduce(events, state, &project_event/2)

  def nr_of_appointments_on_date(%State{map: map}, date) do
    map
    |> Map.values
    |> Stream.filter(&(&1.dateTime == date))
    |> Enum.count
  end

  def has_appointment_on_date(%State{map: map}, person, date) do
    map
    |> Map.values
    |> Stream.filter(&(&1.dateTime == date))
    |> Stream.filter(&(&1.guestId == person))
    |> Enum.any?
  end

  defp project_event(%GuestBookedAppointment{appointmentId: aId, guestId: gId, appointmentDateAndTime: dateTime}, %State{} = state) do
    appointment = %Appointment{appointmentId: aId, guestId: gId, dateTime: dateTime}
    new_map = Map.put(state.map, aId, appointment)
    %State{state | map: new_map}
  end
  defp project_event(%GuestRescheduledAppointment{appointmentId: aId, guestId: gId, appointmentDateAndTime: dateTime}, %State{} = state) do
    new_map = Map.update!(state.map, aId, fn _ ->
      %Appointment{appointmentId: aId, guestId: gId, dateTime: dateTime}
    end)
    %State{state | map: new_map}
  end
  defp project_event(%GuestCancelledAppointment{appointmentId: aId}, %State{map: map} = state) do
    %State{state | map: Map.delete(map, aId)}
  end
  defp project_event(%SubsidiaryCancelledAppointment{appointmentId: aId}, %State{map: map} = state) do
    %State{state | map: Map.delete(map, aId)}
  end
  defp project_event(%GuestSwappedAppointmentFeelGoodPackage{}, %State{} = state), do: state
  defp project_event(_, %State{} = state), do: state
end
