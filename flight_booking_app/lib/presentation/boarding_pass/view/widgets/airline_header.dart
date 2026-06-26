import 'package:flight_booking_app/core/theme/app_color.dart';
import 'package:flight_booking_app/core/theme/text_style.dart';
import 'package:flutter/material.dart';

class AirlineHeader extends StatelessWidget {
  final String airlineName;
  final String aircraftType;

  const AirlineHeader({
    super.key,
    required this.airlineName,
    this.aircraftType = 'Airbus A330',
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: AppColor.primary,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              airlineName.isNotEmpty ? airlineName[0] : '?',
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColor.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            airlineName,
            style: AppTextStyles.bodyMedium.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Text(
          aircraftType,
          style: AppTextStyles.caption.copyWith(color: AppColor.greyDark),
        ),
      ],
    );
  }
}
