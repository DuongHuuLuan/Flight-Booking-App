import 'package:flight_booking_app/core/theme/app_color.dart';
import 'package:flight_booking_app/core/theme/text_style.dart';
import 'package:flutter/material.dart';

class TicketItem extends StatelessWidget {
  final String label;
  final String value;
  final TextStyle? labelStyle;
  final TextStyle? valueStyle;
  final int? labelMaxLines;
  final int? valueMaxLines;

  const TicketItem({
    super.key,
    required this.label,
    required this.value,
    this.labelStyle,
    this.valueStyle,
    this.labelMaxLines,
    this.valueMaxLines,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            maxLines: labelMaxLines ?? 1,
            overflow: TextOverflow.ellipsis,
            style: labelStyle ??
                AppTextStyles.bodySmall.copyWith(
                  color: AppColor.greyDark,
                  fontWeight: FontWeight.w400,
                ),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            maxLines: valueMaxLines ?? 1,
            overflow: TextOverflow.ellipsis,
            style: valueStyle ??
                AppTextStyles.bodyMedium.copyWith(
                  color: AppColor.black,
                  fontWeight: FontWeight.w700,
                ),
          ),
        ],
      ),
    );
  }
}
