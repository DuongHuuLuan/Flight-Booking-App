import 'package:flight_booking_app/core/theme/app_color.dart';
import 'package:flight_booking_app/core/utils/widget_padding.dart';
import 'package:flutter/material.dart';

class SeatStatusLegend extends StatelessWidget {
  const SeatStatusLegend({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        _LegendItem(AppColor.white, "Available", border: true),
        SizedBox(width: 24),
        _LegendItem(AppColor.primary, "Selected"),
        SizedBox(width: 24),
        _LegendItem(AppColor.greyLight, "Reserved"),
      ],
    ).paddingHorizontal(24);
  }
}

class _LegendItem extends StatelessWidget {
  final Color color;
  final String text;
  final bool border;

  const _LegendItem(this.color, this.text, {this.border = false});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
            border: border ? Border.all(color: AppColor.grey300) : null,
          ),
        ),
        const SizedBox(width: 6),
        Text(text),
      ],
    );
  }
}
