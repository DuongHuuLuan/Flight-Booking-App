import 'package:flight_booking_app/core/theme/app_color.dart';
import 'package:flight_booking_app/core/theme/text_style.dart';
import 'package:flight_booking_app/domain/entities/flight_detail_entity.dart';
import 'package:flutter/material.dart';

class FlightSummaryCard extends StatelessWidget {
  final FlightDetailEntity detail;
  const FlightSummaryCard({super.key, required this.detail});

  String _formatTime(DateTime t) =>
      '${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}';

  String _durationText(int min) =>
      '${min ~/ 60}h ${(min % 60).toString().padLeft(2, '0')}m';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppColor.black.withValues(alpha: 0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            // Airline header
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Row(
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: const BoxDecoration(
                      color: AppColor.primary,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.flight,
                      color: AppColor.white,
                      size: 18,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    detail.airline.name,
                    style: AppTextStyles.bodyMedium.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    detail.flightNumber,
                    style: AppTextStyles.caption.copyWith(
                      color: AppColor.greyDark,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 1, color: AppColor.greyLight),
            // Route
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _formatTime(detail.departureTime),
                        style: AppTextStyles.bodyLarge.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        detail.departureAirport.code,
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColor.greyDark,
                        ),
                      ),
                      Text(
                        detail.departureAirport.city,
                        style: AppTextStyles.caption,
                      ),
                    ],
                  ),
                  const Spacer(),
                  Column(
                    children: [
                      Text(
                        _durationText(detail.duration),
                        style: AppTextStyles.caption,
                      ),
                      const SizedBox(height: 4),
                      Container(
                        width: 60,
                        height: 1,
                        color: AppColor.greyLight,
                      ),
                      Text(
                        detail.stops == 0 ? "Non Stop" : "${detail.stops} Stop",
                        style: AppTextStyles.caption.copyWith(
                          color: AppColor.greyDark,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        _formatTime(detail.arrivalTime),
                        style: AppTextStyles.bodyLarge.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        detail.arrivalAirport.code,
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColor.greyDark,
                        ),
                      ),
                      Text(
                        detail.arrivalAirport.city,
                        style: AppTextStyles.caption,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // View Details toggle
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: GestureDetector(
                onTap: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "View Details",
                      style: AppTextStyles.caption.copyWith(
                        color: AppColor.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Icon(
                      Icons.arrow_forward_ios,
                      size: 12,
                      color: AppColor.primary,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
