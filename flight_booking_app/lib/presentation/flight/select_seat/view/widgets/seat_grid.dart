import 'package:flight_booking_app/core/utils/widget_padding.dart';
import 'package:flight_booking_app/presentation/flight/select_seat/cubit/select_seat_state.dart';
import 'package:flight_booking_app/presentation/flight/select_seat/view/widgets/seat_box.dart';
import 'package:flutter/material.dart';

class SeatGrid extends StatelessWidget {
  final SelectSeatState state;
  final void Function(String seatLabel) onSeatTap;

  const SeatGrid({super.key, required this.state, required this.onSeatTap});

  @override
  Widget build(BuildContext context) {
    final rows = state.seats.map((s) => s.rowNumber).toSet().toList()..sort();

    return Column(
      children: rows.map((row) {
        final seatsInRow = state.seats.where((s) => s.rowNumber == row).toList()
          ..sort((a, b) => a.position.compareTo(b.position));

        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: seatsInRow.map((seat) {
            final isSelected = seat.seatLabel == state.selectedSeat;
            final isReserved = seat.status == 'reserved';

            return SeatBox(
              label: seat.seatLabel,
              isSelected: isSelected,
              isReserved: isReserved,
              onTap: isReserved ? null : () => onSeatTap(seat.seatLabel),
            );
          }).toList(),
        ).paddingVertical(8);
      }).toList(),
    );
  }
}
