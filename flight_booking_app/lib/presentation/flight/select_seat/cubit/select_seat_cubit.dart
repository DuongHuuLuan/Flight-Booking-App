import 'package:flight_booking_app/domain/usecase/booking/create_booking_usecase.dart';
import 'package:flight_booking_app/domain/usecase/seat/get_seat_layout_usecase.dart';
import 'package:flight_booking_app/presentation/flight/select_seat/cubit/select_seat_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectSeatCubit extends Cubit<SelectSeatState> {
  final GetSeatLayoutUsecase getSeatLayout;
  final CreateBookingUsecase createBooking;
  String _flightId;
  String _cabinClass;
  set flightId(String v) => _flightId = v;
  set cabinClass(String v) => _cabinClass = v;
  void setBasePrice(double v) => emit(state.copyWith(basePrice: v));

  SelectSeatCubit({
    required this.getSeatLayout,
    required this.createBooking,
    required String flightId,
    required String cabinClass,
    required double basePrice,
  }) : _flightId = flightId,
       _cabinClass = cabinClass,
       super(SelectSeatState(basePrice: basePrice));

  Future<void> loadSeats() async {
    emit(state.copyWith(isLoading: true));
    final result = await getSeatLayout(_flightId);
    result.fold(
      (error) =>
          emit(state.copyWith(isLoading: false, error: error.toString())),
      (seats) => emit(state.copyWith(isLoading: false, seats: seats)),
    );
  }

  void toggleSeat(String seatLabel) {
    final updated = List<String>.from(state.selectedSeats);
    if (updated.contains(seatLabel)) {
      updated.remove(seatLabel);
    } else {
      updated.add(seatLabel);
    }
    emit(state.copyWith(selectedSeats: updated));
  }

  Future<String?> confirmSeat() async {
    if (state.selectedSeats.isEmpty) return null;
    emit(state.copyWith(isBooking: true));

    final result = await createBooking(
      flightId: _flightId,
      cabinClass: _cabinClass,
      seatLabels: state.selectedSeats,
    );

    return result.fold(
      (error) {
        emit(state.copyWith(isBooking: false, error: error.toString()));
        return null;
      },
      (booking) {
        emit(state.copyWith(isBooking: false, bookingId: booking.id));
        return booking.id;
      },
    );
  }
}
