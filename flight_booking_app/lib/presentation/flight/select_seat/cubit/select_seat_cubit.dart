import 'package:flight_booking_app/domain/entities/seat/seat_input.dart';
import 'package:flight_booking_app/domain/entities/seat/seat_zone_entity.dart';
import 'package:flight_booking_app/domain/usecase/booking/create_booking_usecase.dart';
import 'package:flight_booking_app/domain/usecase/seat/get_seat_layout_usecase.dart';
import 'package:flight_booking_app/domain/usecase/seat/get_seat_zones_usecase.dart';
import 'package:flight_booking_app/presentation/flight/select_seat/cubit/select_seat_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectSeatCubit extends Cubit<SelectSeatState> {
  final GetSeatLayoutUsecase getSeatLayout;
  final GetSeatZonesUsecase getSeatZones;
  final CreateBookingUsecase createBooking;
  String _flightId;
  String _cabinClass;
  set flightId(String v) => _flightId = v;
  set cabinClass(String v) => _cabinClass = v;
  void setBasePrice(double v) => emit(state.copyWith(basePrice: v));

  SelectSeatCubit({
    required this.getSeatLayout,
    required this.getSeatZones,
    required this.createBooking,
    required String flightId,
    required String cabinClass,
    required double basePrice,
  }) : _flightId = flightId,
       _cabinClass = cabinClass,
       super(SelectSeatState(basePrice: basePrice));

  Future<void> loadSeats() async {
    emit(state.copyWith(isLoading: true));
    final results = await Future.wait([
      getSeatLayout(_flightId),
      getSeatZones(_flightId),
    ]);
    results[0].fold(
      (error) =>
          emit(state.copyWith(isLoading: false, error: error.toString())),
      (seats) {
        final zonesResult = results[1];
        if (zonesResult.isRight()) {
          final zones = zonesResult.getOrElse(() => <SeatZoneEntity>[]);
          emit(
            state.copyWith(
              isLoading: false,
              seats: seats,
              zones: zones,
              selectedZoneId: zones.isNotEmpty ? zones.first.zoneId : null,
            ),
          );
        } else {
          emit(state.copyWith(isLoading: false, seats: seats));
        }
      },
    );
  }

  void selectZone(String zoneId) {
    emit(state.copyWith(selectedZoneId: zoneId));
  }

  void toggleSeat(String seatLabel, String zoneId) {
    final updated = List<SeatInput>.from(state.selectedSeats);
    final idx = updated.indexWhere((s) => s.seatLabel == seatLabel);
    if (idx >= 0) {
      updated.removeAt(idx);
    } else {
      updated.add(SeatInput(seatLabel: seatLabel, zoneId: zoneId));
    }
    emit(state.copyWith(selectedSeats: updated));
  }

  bool isSeatSelected(String seatLabel) {
    return state.selectedSeats.any((s) => s.seatLabel == seatLabel);
  }

  Future<String?> confirmSeat() async {
    if (state.selectedSeats.isEmpty) return null;
    emit(state.copyWith(isBooking: true));

    final result = await createBooking(
      flightId: _flightId,
      cabinClass: _cabinClass,
      seats: state.selectedSeats,
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
