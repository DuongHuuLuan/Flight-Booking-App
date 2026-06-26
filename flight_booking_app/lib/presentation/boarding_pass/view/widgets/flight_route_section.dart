import 'package:flight_booking_app/core/theme/app_color.dart';
import 'package:flight_booking_app/core/theme/text_style.dart';
import 'package:flutter/material.dart';

class FlightRouteSection extends StatelessWidget {
  final String departureTime;
  final String departureCode;
  final String departureLocation;
  final String arrivalTime;
  final String arrivalCode;
  final String arrivalLocation;
  final String duration;

  const FlightRouteSection({
    super.key,
    required this.departureTime,
    required this.departureCode,
    required this.departureLocation,
    required this.arrivalTime,
    required this.arrivalCode,
    required this.arrivalLocation,
    required this.duration,
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
                style: AppTextStyles.heading2.copyWith(color: AppColor.black),
              ),
              const SizedBox(height: 4),
              Text(
                departureCode,
                style: AppTextStyles.bodyMedium.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                departureLocation,
                style: AppTextStyles.caption.copyWith(color: AppColor.greyDark),
              ),
            ],
          ),
        ),
        Column(
          children: [
            Text(
              duration,
              style: AppTextStyles.caption.copyWith(color: AppColor.greyDark),
            ),
            const SizedBox(height: 4),
            Container(
              width: 36,
              height: 36,
              decoration: const BoxDecoration(
                color: AppColor.primary,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.flight, color: AppColor.white, size: 18),
            ),
          ],
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                arrivalTime,
                style: AppTextStyles.heading2.copyWith(color: AppColor.black),
              ),
              const SizedBox(height: 4),
              Text(
                arrivalCode,
                style: AppTextStyles.bodyMedium.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                arrivalLocation,
                style: AppTextStyles.caption.copyWith(color: AppColor.greyDark),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
