import 'package:flight_booking_app/core/utils/color_utils.dart';
import 'package:flight_booking_app/core/utils/widget_padding.dart';
import 'package:flight_booking_app/domain/entities/seat/seat_zone_entity.dart';
import 'package:flight_booking_app/presentation/flight/select_seat/cubit/select_seat_state.dart';
import 'package:flight_booking_app/presentation/flight/select_seat/view/widgets/seat_box.dart';
import 'package:flutter/material.dart';

class SeatGrid extends StatelessWidget {
  final SelectSeatState state;
  final void Function(String seatLabel) onSeatTap;

  const SeatGrid({super.key, required this.state, required this.onSeatTap});

  @override
  Widget build(BuildContext context) {
    final activeZoneId = state.selectedZoneId;
    final zoneIds = activeZoneId != null
        ? [activeZoneId]
        : state.seatsGroupedByZoneId.keys.toList();

    return Column(
      children: zoneIds.map((zoneId) {
        final zone = state.zones.cast<SeatZoneEntity?>().firstWhere(
          (z) => z?.zoneId == zoneId,
          orElse: () => null,
        );
        final zoneColor = parseHexColor(zone?.colorHex);

        final rows = state.rowsForZone(zoneId);

        return Column(
          children: rows.map((row) {
            final seatsInRow = state.seatsInZoneAndRow(zoneId, row);

            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: seatsInRow.map((seat) {
                final isSelected = state.selectedSeats.any(
                  (element) => element.seatLabel == seat.seatLabel,
                );
                final isReserved = seat.status == 'reserved';

                return SeatBox(
                  label: seat.seatLabel,
                  isSelected: isSelected,
                  isReserved: isReserved,
                  zoneColor: zoneColor,
                  onTap: isReserved ? null : () => onSeatTap(seat.seatLabel),
                );
              }).toList(),
            ).paddingVertical(10);
          }).toList(),
        );
      }).toList(),
    );
  }
}
