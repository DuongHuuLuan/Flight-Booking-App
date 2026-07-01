import 'package:flight_booking_app/core/theme/app_color.dart';
import 'package:flight_booking_app/core/theme/text_style.dart';
import 'package:flight_booking_app/core/utils/widget_padding.dart';
import 'package:flutter/material.dart';

class SeatStatusLegend extends StatelessWidget {
  final List<ZoneColorInfo> zoneColors;

  const SeatStatusLegend({super.key, this.zoneColors = const []});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 16,
      runSpacing: 8,
      children: [
        ...zoneColors.map((z) => _LegendItem(z.color, z.name)),
        _LegendItem(AppColor.white, "Available", border: true),
        _LegendItem(AppColor.primary, "Selected"),
        _LegendItem(AppColor.grey200, "Reserved"),
      ],
    ).paddingHorizontal(24);
  }
}

class ZoneColorInfo {
  final Color color;
  final String name;
  const ZoneColorInfo({required this.color, required this.name});
}

Color parseZoneColor(String? hex) {
  if (hex == null || hex.isEmpty) return Colors.grey;
  return Color(int.parse(hex.replaceFirst('#', '0xFF')));
}

class _LegendItem extends StatelessWidget {
  final Color color;
  final String text;
  final bool border;

  const _LegendItem(this.color, this.text, {this.border = false});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
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
        Text(text, style: AppTextStyles.caption),
      ],
    );
  }
}
