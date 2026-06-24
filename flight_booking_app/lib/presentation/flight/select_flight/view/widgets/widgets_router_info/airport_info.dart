import 'package:flight_booking_app/core/theme/app_color.dart';
import 'package:flight_booking_app/core/theme/text_style.dart';
import 'package:flutter/material.dart';

class AirportInfo extends StatelessWidget {
  final String city;
  final String code;
  final bool alignEnd;

  const AirportInfo({
    super.key,
    required this.city,
    required this.code,
    required this.alignEnd,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: alignEnd
          ? CrossAxisAlignment.end
          : CrossAxisAlignment.start,
      children: [
        Text(
          city,
          style: AppTextStyles.caption.copyWith(color: AppColor.white70),
        ),
        const SizedBox(height: 2),
        Text(
          code,
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColor.white,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }
}
