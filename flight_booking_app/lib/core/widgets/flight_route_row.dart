import 'package:flight_booking_app/core/theme/app_color.dart';
import 'package:flight_booking_app/core/theme/text_style.dart';
import 'package:flutter/material.dart';

class FlightRouteRow extends StatelessWidget {
  final String departureTime;
  final String departureCode;
  final String departureLocation;
  final String arrivalTime;
  final String arrivalCode;
  final String arrivalLocation;
  final Widget centerWidget;

  const FlightRouteRow({
    super.key,
    required this.departureTime,
    required this.departureCode,
    required this.departureLocation,
    required this.arrivalTime,
    required this.arrivalCode,
    required this.arrivalLocation,
    required this.centerWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                departureTime,
                style: AppTextStyles.bodyLarge.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                departureCode,
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColor.greyDark,
                ),
              ),
              Text(departureLocation, style: AppTextStyles.caption),
            ],
          ),
        ),
        centerWidget,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                arrivalTime,
                style: AppTextStyles.bodyLarge.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                arrivalCode,
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColor.greyDark,
                ),
              ),
              Text(arrivalLocation, style: AppTextStyles.caption),
            ],
          ),
        ),
      ],
    );
  }
}
