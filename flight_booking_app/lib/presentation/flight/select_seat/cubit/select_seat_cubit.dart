import 'package:flight_booking_app/domain/entities/seat/seat_entity.dart';
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
  int _children;
  set flightId(String v) => _flightId = v;
  String get flightId => _flightId;
  set children(int v) => _children = v;
  void setBasePrice(double v) => emit(state.copyWith(basePrice: v));

  SelectSeatCubit({
    required this.getSeatLayout,
    required this.getSeatZones,
    required this.createBooking,
    required String flightId,
    required double basePrice,
  }) : _flightId = flightId,
       _children = 0,
       super(SelectSeatState(basePrice: basePrice));

  Future<void> loadSeats() async {
    emit(state.copyWith(isLoading: true));
    final seatsResult = await getSeatLayout(_flightId);
    final zonesResult = await getSeatZones(_flightId);
    seatsResult.fold(
      (error) =>
          emit(state.copyWith(isLoading: false, error: error.toString())),
      (seats) {
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

  SeatEntity? _findSeat(String seatLabel) {
    return state.seats.cast<SeatEntity?>().firstWhere(
      (s) => s?.seatLabel == seatLabel,
      orElse: () => null,
    );
  }

  String? _adjacentLabel(SeatEntity seat) {
    final adj = state.seats.cast<SeatEntity?>().firstWhere(
      (s) => s?.rowNumber == seat.rowNumber && s?.position == seat.position + 1,
      orElse: () => null,
    );
    return adj?.seatLabel;
  }

  int get _unpairedChildCount {
    if (_children == 0) return 0;
    final selected = state.selectedSeats;
    final used = <String>{};
    int pairs = 0;
    for (final s in selected) {
      if (used.contains(s.seatLabel)) continue;
      final entity = _findSeat(s.seatLabel);
      if (entity == null) continue;
      final adj = _adjacentLabel(entity);
      if (adj != null && selected.any((x) => x.seatLabel == adj)) {
        pairs++;
        used.add(s.seatLabel);
        used.add(adj);
      }
    }
    return _children - pairs;
  }

  void toggleSeat(String seatLabel, String zoneId) {
    final updated = List<SeatInput>.from(state.selectedSeats);
    final idx = updated.indexWhere((s) => s.seatLabel == seatLabel);
    final seat = _findSeat(seatLabel);
    final actualZoneId = seat?.zoneId ?? zoneId;

    if (idx >= 0) {
      updated.removeAt(idx);
      if (_children > 0 && seat != null) {
        final adj = _adjacentLabel(seat);
        if (adj != null) {
          updated.removeWhere((s) => s.seatLabel == adj);
        }
      }
    } else {
      updated.add(SeatInput(seatLabel: seatLabel, zoneId: actualZoneId));
      if (_children > 0 && seat != null && _unpairedChildCount > 0) {
        final adj = _adjacentLabel(seat);
        if (adj != null && !updated.any((s) => s.seatLabel == adj)) {
          updated.add(SeatInput(seatLabel: adj, zoneId: actualZoneId));
        }
      }
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
