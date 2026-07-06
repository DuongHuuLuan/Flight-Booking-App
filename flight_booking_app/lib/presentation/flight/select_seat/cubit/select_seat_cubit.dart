import 'package:flight_booking_app/domain/entities/seat/seat_entity.dart';
import 'package:flight_booking_app/domain/entities/seat/seat_input.dart';
import 'package:flight_booking_app/domain/entities/seat/seat_zone_entity.dart';
import 'package:flight_booking_app/domain/enums/age_group.dart';
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
  int _children = 0;
  int _adults = 0;
  int _seniors = 0;

  SelectSeatCubit({
    required this.getSeatLayout,
    required this.getSeatZones,
    required this.createBooking,
    required String flightId,
    required double basePrice,
  }) : _flightId = flightId,
       super(SelectSeatState(basePrice: basePrice));

  String get flightId => _flightId;

  set flightId(String value) {
    _flightId = value;
  }

  int get children => _children;
  set children(int value) {
    _children = value < 0 ? 0 : value;
  }

  set adults(int value) {
    _adults = value < 0 ? 0 : value;
  }

  set seniors(int value) {
    _seniors = value < 0 ? 0 : value;
  }

  void setBasePrice(double value) {
    emit(state.copyWith(basePrice: value));
  }

  Set<String> get selectableSeatLabels {
    if (_children <= 0) {
      return state.seats
          .where((element) => _canSelectSeat(element))
          .map((e) => e.seatLabel)
          .toSet();
    }
    return state.seats
        .where((element) => _canSelectSeat(element))
        .where((element) {
          if (_isSelected(state.selectedSeats, element.seatLabel)) return true;
          return _findAvailableAdjacentSeat(element, state.selectedSeats) !=
              null;
        })
        .map((e) => e.seatLabel)
        .toSet();
  }

  List<AgeGroup> get ageGroups => [
    for (int i = 0; i < _adults; i++) AgeGroup.adult,
    for (int i = 0; i < _children; i++) AgeGroup.child,
    for (int i = 0; i < _seniors; i++) AgeGroup.senior,
  ];

  int get totalPassengers => _adults + _children + _seniors;

  List<String> get seatLabels =>
      state.selectedSeats.map((s) => s.seatLabel).toList();
  List<String> get seatZoneIds =>
      state.selectedSeats.map((e) => e.zoneId).toList();
  List<String> get ageGroupNames => ageGroups.map((ag) => ag.name).toList();

  Map<String, dynamic> buildNavigationPayload(String bookingId) => {
    'bookingId': bookingId,
    'seatCount': state.selectedSeats.length,
    'basePrice': state.basePrice,
    'totalPrice': state.totalPrice,
    'ageGroups': ageGroupNames,
    'seatLabels': seatLabels,
    'seatZoneIds': seatZoneIds,
    'flightId': _flightId,
  };

  Future<void> loadSeats() async {
    emit(state.copyWith(isLoading: true, error: null));

    final seatsResult = await getSeatLayout(_flightId);
    final zonesResult = await getSeatZones(_flightId);

    seatsResult.fold(
      (error) {
        emit(state.copyWith(isLoading: false, error: error.toString()));
      },
      (seats) {
        final zones = zonesResult.getOrElse(() => <SeatZoneEntity>[]);

        emit(
          state.copyWith(
            isLoading: false,
            seats: seats,
            zones: zones,
            selectedZoneId: zones.isNotEmpty ? zones.first.zoneId : null,
            error: null,
          ),
        );
      },
    );
  }

  void selectZone(String zoneId) {
    emit(state.copyWith(selectedZoneId: zoneId));
  }

  void toggleSeat(String seatLabel, String fallbackZoneId) {
    final seat = _findSeat(seatLabel);

    if (seat == null) {
      emit(state.copyWith(error: 'Seat not found'));
      return;
    }

    if (!_canSelectSeat(seat)) {
      emit(state.copyWith(error: 'Seat is not available'));
      return;
    }

    final updatedSeats = List<SeatInput>.from(state.selectedSeats);
    final alreadySelected = _isSelected(updatedSeats, seat.seatLabel);

    if (alreadySelected) {
      _removeSeat(updatedSeats, seat);
    } else {
      final totalPassengers = _adults + _children + _seniors;
      if (updatedSeats.length >= totalPassengers) {
        emit(state.copyWith(error: "Đã chọn đủ $totalPassengers ghế"));
        return;
      }
      if (_children > 0 && !selectableSeatLabels.contains(seatLabel)) {
        emit(state.copyWith(error: "Cần ghế kế bên cho trẻ em"));
        return;
      }
      _addSeat(updatedSeats, seat, fallbackZoneId);
    }

    emit(state.copyWith(selectedSeats: updatedSeats, error: null));
  }

  Future<String?> confirmSeat() async {
    final totalPassengers = _adults + _children + _seniors;
    if (state.selectedSeats.length != totalPassengers) {
      emit(
        state.copyWith(
          isBooking: false,
          error: 'Please select exactly $totalPassengers seats',
        ),
      );
      return null;
    }

    emit(state.copyWith(isBooking: true, error: null));

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
        emit(
          state.copyWith(isBooking: false, bookingId: booking.id, error: null),
        );
        return booking.id;
      },
    );
  }

  bool isSeatSelected(String seatLabel) {
    return state.selectedSeats.any((seat) => seat.seatLabel == seatLabel);
  }

  SeatEntity? _findSeat(String seatLabel) {
    try {
      return state.seats.firstWhere((seat) => seat.seatLabel == seatLabel);
    } catch (_) {
      return null;
    }
  }

  bool _canSelectSeat(SeatEntity seat) {
    final status = seat.status.toLowerCase();

    return status != 'booked' &&
        status != 'reserved' &&
        status != 'unavailable';
  }

  bool _isSelected(List<SeatInput> seats, String seatLabel) {
    return seats.any((seat) => seat.seatLabel == seatLabel);
  }

  String _resolveZoneId(SeatEntity seat, String fallbackZoneId) {
    final zoneId = seat.zoneId;

    if (zoneId == null || zoneId.isEmpty) {
      return fallbackZoneId;
    }

    return zoneId;
  }

  void _addSeat(
    List<SeatInput> selectedSeats,
    SeatEntity seat,
    String fallbackZoneId,
  ) {
    _addSeatIfNotExists(
      selectedSeats,
      seat.seatLabel,
      _resolveZoneId(seat, fallbackZoneId),
    );

    if (_children <= 0) return;
    final unpairedChildren = _calculateUnpairedChildren(selectedSeats);
    if (unpairedChildren <= 0) return;
    final totalPassengers = _adults + _children + _seniors;
    if (selectedSeats.length >= totalPassengers) return;
    final adjacentSeat = _findAvailableAdjacentSeat(seat, selectedSeats);
    if (adjacentSeat == null) {
      return;
    }

    _addSeatIfNotExists(
      selectedSeats,
      adjacentSeat.seatLabel,
      _resolveZoneId(adjacentSeat, fallbackZoneId),
    );
  }

  void _removeSeat(List<SeatInput> selectedSeats, SeatEntity seat) {
    selectedSeats.removeWhere(
      (selectedSeat) => selectedSeat.seatLabel == seat.seatLabel,
    );
    if (_children <= 0) return;

    final adjacentSeat = _findSelectedAdjacentSeat(seat, selectedSeats);

    if (adjacentSeat == null) return;
    selectedSeats.removeWhere(
      (selectedSeat) => selectedSeat.seatLabel == adjacentSeat.seatLabel,
    );
  }

  void _addSeatIfNotExists(
    List<SeatInput> selectedSeats,
    String seatLabel,
    String zoneId,
  ) {
    if (_isSelected(selectedSeats, seatLabel)) return;
    selectedSeats.add(SeatInput(seatLabel: seatLabel, zoneId: zoneId));
  }

  SeatEntity? _findAvailableAdjacentSeat(
    SeatEntity seat,
    List<SeatInput> selectedSeats,
  ) {
    final rightSeat = _findAdjacentSeat(seat, 1);

    if (rightSeat != null &&
        _canSelectSeat(rightSeat) &&
        !_isSelected(selectedSeats, rightSeat.seatLabel)) {
      return rightSeat;
    }

    final leftSeat = _findAdjacentSeat(seat, -1);

    if (leftSeat != null &&
        _canSelectSeat(leftSeat) &&
        !_isSelected(selectedSeats, leftSeat.seatLabel)) {
      return leftSeat;
    }
    return null;
  }

  SeatEntity? _findSelectedAdjacentSeat(
    SeatEntity seat,
    List<SeatInput> selectedSeats,
  ) {
    final rightSeat = _findAdjacentSeat(seat, 1);

    if (rightSeat != null && _isSelected(selectedSeats, rightSeat.seatLabel)) {
      return rightSeat;
    }

    final leftSeat = _findAdjacentSeat(seat, -1);

    if (leftSeat != null && _isSelected(selectedSeats, leftSeat.seatLabel)) {
      return leftSeat;
    }

    return null;
  }

  SeatEntity? _findAdjacentSeat(SeatEntity seat, int offset) {
    try {
      return state.seats.firstWhere(
        (s) =>
            s.rowNumber == seat.rowNumber &&
            s.position == seat.position + offset &&
            s.zoneId == seat.zoneId,
      );
    } catch (_) {
      return null;
    }
  }

  int _calculateUnpairedChildren(List<SeatInput> selectedSeats) {
    if (_children <= 0) return 0;

    final usedSeatLabels = <String>{};
    int pairCount = 0;

    for (final selectedSeat in selectedSeats) {
      if (usedSeatLabels.contains(selectedSeat.seatLabel)) continue;

      final seat = _findSeat(selectedSeat.seatLabel);
      if (seat == null) continue;

      final adjacentSeat = _findSelectedAdjacentSeat(seat, selectedSeats);
      if (adjacentSeat == null) continue;

      usedSeatLabels.add(seat.seatLabel);
      usedSeatLabels.add(adjacentSeat.seatLabel);
      pairCount++;
    }

    final unpaired = _children - pairCount;
    return unpaired < 0 ? 0 : unpaired;
  }
}
