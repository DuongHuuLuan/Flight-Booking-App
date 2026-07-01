import 'package:flight_booking_app/core/utils/color_utils.dart';
import 'package:flight_booking_app/core/utils/widget_padding.dart';
import 'package:flight_booking_app/domain/entities/seat/seat_entity.dart';
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
    final grouped = <String, List<SeatEntity>>{};
    for (final seat in state.seats) {
      final key = seat.zoneId ?? '';
      grouped.putIfAbsent(key, () => []);
      grouped[key]!.add(seat);
    }

    final activeZoneId = state.selectedZoneId;
    final entries = activeZoneId != null
        ? grouped.entries.where((e) => e.key == activeZoneId)
        : grouped.entries;

    return Column(
      children: entries.map((entry) {
        final zone = state.zones.cast<SeatZoneEntity?>().firstWhere(
          (z) => z?.zoneId == entry.key,
          orElse: () => null,
        );
        final zoneColor = parseHexColor(zone?.colorHex);
        final zonePrice = state.basePrice * (zone?.priceModifier ?? 1.0);

        final seats = entry.value;
        final rows = seats.map((s) => s.rowNumber).toSet().toList()..sort();

        return Column(
          children: [
            // Container(
            //   width: double.infinity,
            //   padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            //   color: zoneColor.withValues(alpha: 0.08),
            //   child: Text(
            //     '${zone?.zoneName ?? 'Unknown'} — ${zonePrice.toStringAsFixed(0)}₫/ghế',
            //     style: AppTextStyles.bodyMedium.copyWith(
            //       fontWeight: FontWeight.w600,
            //       color: zoneColor,
            //     ),
            //   ),
            // ),
            ...rows.map((row) {
              final seatsInRow = seats.where((s) => s.rowNumber == row).toList()
                ..sort((a, b) => a.position.compareTo(b.position));

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
            }),
          ],
        );
      }).toList(),
    );
  }
}
